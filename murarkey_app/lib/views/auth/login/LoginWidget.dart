import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:murarkey_app/custom_views/CheckBoxWidget.dart';
import 'package:murarkey_app/custom_views/EditText.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/SocialMediaLoginCardWidget.dart';
import 'package:murarkey_app/custom_views/buttons/FlatButton3.dart';
import 'package:murarkey_app/custom_views/dialogs/ErrorDialogWidget.dart';
import 'package:murarkey_app/custom_views/loader/CustomAnimation.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/auth/LoginModel.dart';
import 'package:murarkey_app/repository/provider/GoogleSignInProvider.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/Validation.dart';
import 'package:murarkey_app/views/auth/login/view_model/LoginViewModel.dart';
import 'package:murarkey_app/views/auth/register/RegisterWidget.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatefulWidget {
  final LoginViewModel viewModel = new LoginViewModel();

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  Repository _repository = new Repository();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppConstants.appColor.primaryDarkColor));

    braintreeView() async {
      var amount = "10.0";

      var request = BraintreeDropInRequest(
        tokenizationKey: "sandbox_ndhr5c7k_b5wny6h357jq7kp4",
        collectDeviceData: true,
        paypalRequest: BraintreePayPalRequest(
          amount: amount,
          displayName: "Suman Neupane",
          currencyCode: "USD",
        ),
        cardEnabled: false,
      );

      BraintreeDropInResult result = await BraintreeDropIn.start(request);
      if (result != null) {
        print(result.paymentMethodNonce.description);
        print(result.paymentMethodNonce.nonce);
        //mount,payment_method_nonce,device_data
        Map<String, dynamic> params = new Map<String, dynamic>();
        params["amount"] = amount;
        params["payment_method_nonce"] = result.paymentMethodNonce.nonce;
        params["device_data"] = result.deviceData;

        var data = await _repository.payPalApi.addToTransaction(
          url: ApiUrls.PAYPAL_TRANSACTION,
          params: params,
        );
      }
    }

    login() async {
      String emailValidate =
          Validation.validateEmail(widget.viewModel.formEmail.text.trim());
      String passwordValid = Validation.validatePassword(
          widget.viewModel.formPassword.text.trim());

      if (emailValidate != Validation.SUCCESS) {
        Commons.toastMessage(context, emailValidate);
      } else if (passwordValid != Validation.SUCCESS) {
        Commons.toastMessage(context, passwordValid);
      } else {
        Map<String, dynamic> params = new Map();
        params["email"] = widget.viewModel.formEmail.text.trim();
        params["password"] = widget.viewModel.formPassword.text.trim();

        EasyLoadingView.show(message: 'Logging in...');
        await _repository.authApiRequest
            .login(url: ApiUrls.LOGIN_URL, params: params, context: context)
            .then((LoginModel value) => {
                  EasyLoadingView.dismiss(),
                  this.setState(() {
                    if (value != null && !value.success) {
                      ErrorDialogWidget.showAlertDialog(
                        context: context,
                        message: value.error,
                        cancelText: "Done",
                        cancleCallback: () {
                          NavigateRoute.pop(context);
                        },
                      );
                    } else if (value != null && value.success) {
                      Commons.toastMessage(context, "Successfully login");
                      NavigateRoute.popAndPushNamed(
                        context,
                        NavigateRoute.APP_LOADER,
                      );
                    }
                  }),
                });
      }

      //braintreeView();
    }

    Future loginWithGoogle({String accessToken, String name}) async {
      Map<String, dynamic> params = new Map();
      params["accessToken"] = "${accessToken}";
      params["name"] = "${name}";

      EasyLoadingView.show(message: 'Logging out...');
      final LoginModel result = await _repository.authApiRequest
          .loginWithGoogle(
              url: ApiUrls.GOOGLE_LOGIN_URL, params: params, context: context);
      EasyLoadingView.dismiss();
      this.setState(() {
        if (result != null && !result.success) {
          ErrorDialogWidget.showAlertDialog(
            context: context,
            message: result.error,
            cancelText: "Done",
            cancleCallback: () {
              NavigateRoute.pop(context);
            },
          );
        } else if (result != null && result.success) {
          Commons.toastMessage(context, "Successfully login");
          NavigateRoute.popAndPushNamed(
            context,
            NavigateRoute.APP_LOADER,
          );
        }
      });
    }

    return Material(
      child: Scaffold(
        backgroundColor: AppConstants.appColor.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                    color: AppConstants.appColor.primaryDarkColor,
                    width: screenSize.width,
                    height: 260,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, left: 24.0, right: 24, bottom: 48),
                      child: Image.asset('images/app_logo_golden.png'),
                    )),
                Container(
                  margin: const EdgeInsets.only(top: 245),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12.0)),
                    color: AppConstants.appColor.backgroundColor,
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Email
                      new EditText(
                        text: "Email",
                        icon: Icons.email,
                        fontSize: SizeConfig.textMultiplier * 2.0,
                        textColor: AppConstants.appColor.textColor,
                        keyboardType: TextInputType.emailAddress,
                        margin: EdgeInsets.only(
                            top: screenSize.width * .08,
                            bottom: screenSize.width * .06),
                        controller: widget.viewModel.formEmail,
                      ),

                      //Password
                      new EditText(
                        text: AppConstants.constants.PASSWORD,
                        icon: Icons.remove_red_eye,
                        fontSize: SizeConfig.textMultiplier * 2.0,
                        textColor: AppConstants.appColor.textColor,
                        keyboardType: TextInputType.text,
                        margin: EdgeInsets.only(bottom: screenSize.width * .03),
                        controller: widget.viewModel.formPassword,
                        obscureText: true,
                      ),

                      //Remember me
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 5,
                            child: CheckboxWidget(
                              text: AppConstants.constants.REMEMBER_ME,
                              value: widget.viewModel.rememberME,
                              onValueChange: (bool value) {
                                setState(() {
                                  widget.viewModel.rememberME = value;
                                });
                              },
                              fontSize: SizeConfig.textMultiplier * 1.8,
                              textColor: AppConstants.appColor.textColor,
                              screenSize: screenSize,
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              onTap: () {
                                NavigateRoute.pushNamed(
                                    context, NavigateRoute.RESET_ACCOUNT);
                              },
                              child: Text(
                                AppConstants.constants.FORGET_PASSWORD,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: AppConstants.appColor.redColor,
                                  fontSize: SizeConfig.textMultiplier * 1.8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),

                      //Log in
                      new FlatStatefulButton(
                        text: AppConstants.constants.LOG_IN,
                        fontSize: SizeConfig.textMultiplier * 2.0,
                        textColor: AppConstants.appColor.accentColor,
                        padding: EdgeInsets.all(screenSize.width * .02),
                        backgroundColor:
                            AppConstants.appColor.primaryLightColor,
                        onPressedCallback: () {
                          login();
                        },
                      ),
                      // FlatButton3(
                      //   text: AppConstants.constants.LOG_IN,
                      //   fontSize: SizeConfig.textMultiplier * 2.0,
                      //   textColor: AppConstants.appColor.accentColor,
                      //   padding: EdgeInsets.all(screenSize.width * .02),
                      //   backgroundColor:
                      //       AppConstants.appColor.primaryLightColor,
                      //   buttonCurve: 16,
                      //   fontWeight: FontWeight.normal,
                      //   boderColor: AppConstants.appColor.whiteColor,
                      //   buttonWidth: double.infinity,
                      //   onPressedCallback: () {},
                      // ),
                      SizedBox(
                        height: 16,
                      ),

                      Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: (){
                            NavigateRoute.popAndPushNamed(
                                context, NavigateRoute.APP_LOADER);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "GO HOME",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color:  Colors.red,
                                  fontSize: SizeConfig.textMultiplier * 1.8,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_right_alt,
                                size: 45,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 16,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have Account?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppConstants.appColor.textColor,
                              fontSize: SizeConfig.textMultiplier * 1.8,
                            ),
                          ),
                          InkWell(
                            child: Text(
                              "  Sign up ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppConstants.appColor.accentColor,
                                fontSize: SizeConfig.textMultiplier * 1.8,
                              ),
                            ),
                            onTap: () {
                              NavigateRoute.popAndPushNamed(
                                  context, NavigateRoute.REGISTER);
                            },
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 40,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 1,
                              color: AppConstants.appColor.greyColor,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "OR",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppConstants.appColor.textColor3,
                                fontSize: SizeConfig.textMultiplier * 2.0,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              height: 1,
                              color: AppConstants.appColor.greyColor,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 24,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Sign in with",
                            style: TextStyle(
                                color: AppConstants.appColor.textColor3,
                                fontSize: SizeConfig.textMultiplier * 1.6,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialMediaLoginCardWidget(
                            text: "Google",
                            imageSrc: 'images/ic_google.png',
                            textColor: AppConstants.appColor.textColor3,
                            fontSize: SizeConfig.textMultiplier * 1.5,
                            onTap: () async {
                              // final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                              // provider.googleLogin();
                              GoogleSignInProvider google =
                                  new GoogleSignInProvider();
                              final accessToken =
                                  await google.googleLoginFromUrl();
                              var user = google.user;
                              print("user----------->${user.id}");
                              print(user.email);
                              print(user.displayName);
                              print(user.photoUrl);
                              loginWithGoogle(
                                  accessToken: accessToken,
                                  name: user.displayName);
                            },
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          SocialMediaLoginCardWidget(
                            text: "Facebook",
                            imageSrc: 'images/ic_facebook.png',
                            textColor: AppConstants.appColor.textColor3,
                            fontSize: SizeConfig.textMultiplier * 1.5,
                            onTap: () {},
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 24,
                      ),

                      RichText(
                        text: TextSpan(
                          text: AppConstants.constants.PRIVACY_POLICY_MSG,
                          style: TextStyle(
                            color: AppConstants.appColor.textColor3,
                            fontSize: SizeConfig.textMultiplier * 1.4,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: AppConstants.constants.PRIVACY_POLICY,
                                style: TextStyle(
                                  color: AppConstants.appColor.primaryDarkColor,
                                  fontSize: SizeConfig.textMultiplier * 1.55,
                                )),
                          ],
                        ),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
