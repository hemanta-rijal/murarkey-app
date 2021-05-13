import 'package:flutter/services.dart';
import 'package:murarkey_app/custom_views/CheckBoxWidget.dart';
import 'package:murarkey_app/custom_views/EditText.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/SocialMediaLoginCardWidget.dart';
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
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppConstants.appColor.primaryDarkColor));

    return Material(
      child: Scaffold(
        backgroundColor: AppConstants.appColor.backgroundColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  color: AppConstants.appColor.primaryDarkColor,
                  width: screenSize.width,
                  height: 260,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 48, left: 24.0, right: 24, bottom: 48),
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
                    //Full Name
                    new EditText(
                      text: "Username",
                      icon: Icons.account_circle_rounded,
                      fontSize: SizeConfig.textMultiplier * 2.0,
                      textColor: AppConstants.appColor.textColor,
                      keyboardType: TextInputType.emailAddress,
                      margin: EdgeInsets.only(
                          top: screenSize.width * .08,
                          bottom: screenSize.width * .03),
                      controller: widget.viewModel.formUserName,
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
                        String usernameValidate = Validation.validateUserName(
                            widget.viewModel.formUserName.text.trim());

                        String emailValidate = Validation.validateEmail(
                            widget.viewModel.formEmail.text.trim());

                        String passwordValid = Validation.validatePassword(
                            widget.viewModel.formPassword.text.trim());

                        String confirmPasswordValid =
                            Validation.validateConfirmPassword(
                                widget.viewModel.formPassword.text.trim(),
                                widget.viewModel.formConfirmPassword.text
                                    .trim());

                        if (usernameValidate != Validation.SUCCESS) {
                          Commons.toastMessage(context, usernameValidate);
                        } else if (emailValidate != Validation.SUCCESS) {
                          Commons.toastMessage(context, emailValidate);
                        } else if (passwordValid != Validation.SUCCESS) {
                          Commons.toastMessage(context, passwordValid);
                        } else if (confirmPasswordValid != Validation.SUCCESS) {
                          Commons.toastMessage(context, confirmPasswordValid);
                        } else {
                          Commons.toastMessage(
                              context, "Registered Successfully");
                        }
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
                        Text(
                          "  Sign in ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppConstants.appColor.accentColor,
                            fontSize: SizeConfig.textMultiplier * 1.8,
                          ),
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
                            fontSize: SizeConfig.textMultiplier * 1.5),
                        SizedBox(
                          width: 30,
                        ),
                        SocialMediaLoginCardWidget(
                            text: "Facebook",
                            imageSrc: 'images/ic_facebook.png',
                            textColor: AppConstants.appColor.textColor3,
                            fontSize: SizeConfig.textMultiplier * 1.5),
                      ],
                    ),

                    SizedBox(
                      height: 24,
                    ),

                    RichText(
                      text: TextSpan(
                        text:
                        AppConstants.constants.PRIVACY_POLICY_MSG,
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
    );
  }
}
