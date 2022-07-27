import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:murarkey_app/custom_views/CheckBoxWidget.dart';
import 'package:murarkey_app/custom_views/EditText.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/SocialMediaLoginCardWidget.dart';
import 'package:murarkey_app/custom_views/dialogs/ErrorDialogWidget.dart';
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
import 'package:murarkey_app/views/auth/reset_account/view_model/ResetAccountViewModel.dart';
import 'package:provider/provider.dart';

class ResetAccountWidget extends StatefulWidget {
  final ResetAccountViewModel viewModel = new ResetAccountViewModel();

  @override
  _ResetAccountWidgetState createState() => _ResetAccountWidgetState();
}

class _ResetAccountWidgetState extends State<ResetAccountWidget> {
  Repository _repository = new Repository();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppConstants.appColor.primaryDarkColor));

    resetAccount() async {
      String emailValidate =
          Validation.validateEmail(widget.viewModel.formEmail.text.trim());

      if (emailValidate != Validation.SUCCESS) {
        Commons.toastMessage(context, emailValidate);
      } else {
        Map<String, dynamic> params = new Map();
        params["email"] = widget.viewModel.formEmail.text.trim();
        final result = await _repository.authApiRequest.resetPasswordAndAccount(
          url: ApiUrls.RESET_PASSWORD_URL,
          params: params,
          context: context,
        );
        Commons.toastMessage(context, result);
      }
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
                      SizedBox(height: screenSize.width * .06),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppConstants.constants.FIND_YOUR_ACCOUNT,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppConstants.appColor.blackColor,
                                fontSize: SizeConfig.textMultiplier * 2.7,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppConstants.constants.ENTER_YOUR_EMAIL_ACCOUNT,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppConstants.appColor.blackColor,
                                fontSize: SizeConfig.textMultiplier * 2.0,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      new FlatStatefulButton(
                        text: AppConstants.constants.SEND_A_RESET_LINK,
                        fontSize: SizeConfig.textMultiplier * 2.0,
                        textColor: AppConstants.appColor.accentColor,
                        padding: EdgeInsets.all(screenSize.width * .02),
                        backgroundColor: AppConstants.appColor.buttonColor,
                        onPressedCallback: () {
                          resetAccount();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          NavigateRoute.pop(context);
                        },
                        child: Text(
                          AppConstants.constants.BACK_TO_LOGIN,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppConstants.appColor.redColor,
                            fontSize: SizeConfig.textMultiplier * 1.8,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
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
