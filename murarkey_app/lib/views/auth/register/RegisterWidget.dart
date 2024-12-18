import 'package:flutter/services.dart';
import 'package:murarkey_app/custom_views/CheckBoxWidget.dart';
import 'package:murarkey_app/custom_views/EditText.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/SocialMediaLoginCardWidget.dart';
import 'package:murarkey_app/custom_views/dialogs/ErrorDialogWidget.dart';
import 'package:murarkey_app/custom_views/loader/CustomAnimation.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/repository/models/auth/LoginModel.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';
import 'package:murarkey_app/repository/provider/GoogleSignInProvider.dart';
import 'package:murarkey_app/routes/NavigateRoute.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/Validation.dart';
import 'package:murarkey_app/views/auth/register/view_model/RegisterViewModel.dart';

class RegisterWidget extends StatefulWidget {
  final RegisterViewModel viewModel = new RegisterViewModel();

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  Repository _repository = new Repository();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppConstants.appColor.primaryDarkColor));

    void register() async {
      String firstNameValidate = Validation.validateUserName(
          widget.viewModel.formFirstName.text.trim(), "First name");

      String lastNameValidate = Validation.validateUserName(
          widget.viewModel.formLastName.text.trim(), "Last name");

      String emailValidate =
          Validation.validateEmail(widget.viewModel.formEmail.text.trim());

      String passwordValid = Validation.validatePassword(
          widget.viewModel.formPassword.text.trim());

      String confirmPasswordValid = Validation.validateConfirmPassword(
          widget.viewModel.formPassword.text.trim(),
          widget.viewModel.formConfirmPassword.text.trim());

      if (firstNameValidate != Validation.SUCCESS) {
        Commons.toastMessage(context, firstNameValidate);
      } else if (firstNameValidate != Validation.SUCCESS) {
        Commons.toastMessage(context, lastNameValidate);
      } else if (emailValidate != Validation.SUCCESS) {
        Commons.toastMessage(context, emailValidate);
      } else if (passwordValid != Validation.SUCCESS) {
        Commons.toastMessage(context, passwordValid);
      } else if (confirmPasswordValid != Validation.SUCCESS) {
        Commons.toastMessage(context, confirmPasswordValid);
      } else {
        Map<String, dynamic> params = new Map();
        params["first_name"] = widget.viewModel.formFirstName.text.trim();
        params["last_name"] = widget.viewModel.formLastName.text.trim();
        params["email"] = widget.viewModel.formEmail.text.trim();
        params["password"] = widget.viewModel.formPassword.text.trim();
        params["role"] = widget.viewModel.formRole;

        EasyLoadingView.show(message: 'Registering...');
        await _repository.authApiRequest
            .register(url: ApiUrls.REGISTER_URL, params: params)
            .then((UserModel value) => {
                  EasyLoadingView.dismiss(),
                  this.setState(() {
                    Commons.toastMessage(
                        context, "Registered Successfully! Please Login.");
                    NavigateRoute.popAndPushNamed(context, NavigateRoute.LOGIN);
                  }),
                });
      }
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
                      //First Name
                      new EditText(
                        text: "First name",
                        icon: Icons.account_circle_rounded,
                        fontSize: SizeConfig.textMultiplier * 2.0,
                        textColor: AppConstants.appColor.textColor,
                        keyboardType: TextInputType.emailAddress,
                        margin: EdgeInsets.only(
                            top: screenSize.width * .08,
                            bottom: screenSize.width * .03),
                        controller: widget.viewModel.formFirstName,
                      ),

                      //Last Name
                      new EditText(
                        text: "Last Name",
                        icon: Icons.account_circle_rounded,
                        fontSize: SizeConfig.textMultiplier * 2.0,
                        textColor: AppConstants.appColor.textColor,
                        keyboardType: TextInputType.emailAddress,
                        margin: EdgeInsets.only(bottom: screenSize.width * .03),
                        controller: widget.viewModel.formLastName,
                      ),

                      // Email
                      new EditText(
                        text: AppConstants.constants.EMAIL,
                        icon: Icons.email,
                        fontSize: SizeConfig.textMultiplier * 2.0,
                        textColor: AppConstants.appColor.textColor,
                        keyboardType: TextInputType.emailAddress,
                        margin: EdgeInsets.only(bottom: screenSize.width * .03),
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

                      //Password
                      new EditText(
                        text: AppConstants.constants.CONFIRM_PASSWORD,
                        icon: Icons.remove_red_eye,
                        fontSize: SizeConfig.textMultiplier * 2.0,
                        textColor: AppConstants.appColor.textColor,
                        keyboardType: TextInputType.text,
                        margin: EdgeInsets.only(bottom: screenSize.width * .03),
                        controller: widget.viewModel.formConfirmPassword,
                        obscureText: true,
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      //Register
                      new FlatStatefulButton(
                        text: AppConstants.constants.REGISTER,
                        fontSize: SizeConfig.textMultiplier * 2.0,
                        textColor: AppConstants.appColor.accentColor,
                        padding: EdgeInsets.all(screenSize.width * .02),
                        backgroundColor: AppConstants.appColor.buttonColor,
                        onPressedCallback: () {
                          register();
                        },
                      ),

                      SizedBox(
                        height: 16,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " Already have Account?  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppConstants.appColor.textColor,
                              fontSize: SizeConfig.textMultiplier * 1.8,
                            ),
                          ),
                          InkWell(
                            child: Text(
                              "  Sign in ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppConstants.appColor.accentColor,
                                fontSize: SizeConfig.textMultiplier * 1.8,
                              ),
                            ),
                            onTap: () {
                              NavigateRoute.popAndPushNamed(
                                  context, NavigateRoute.LOGIN);
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
                            "Sign up with",
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
