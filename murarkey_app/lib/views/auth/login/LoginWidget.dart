import 'package:flutter/services.dart';
import 'package:murarkey_app/custom_views/CheckBoxWidget.dart';
import 'package:murarkey_app/custom_views/EditText.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/custom_views/SocialMediaLoginCardWidget.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/Validation.dart';
import 'package:murarkey_app/views/auth/login/view_model/LoginViewModel.dart';

class LoginWidget extends StatefulWidget {
  final LoginViewModel viewModel = new LoginViewModel();

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
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
                      margin:
                          EdgeInsets.only(bottom: screenSize.width * .03),
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
                          child: Text(
                            "Forget your password?",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: AppConstants.appColor.redColor,
                              fontSize: SizeConfig.textMultiplier * 1.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    //Log in
                    new FlatStatefulButton(
                      text: AppConstants.constants.LOG_IN,
                      fontSize: SizeConfig.textMultiplier * 2.0,
                      textColor: AppConstants.appColor.accentColor,
                      padding: EdgeInsets.all(screenSize.width * .02),
                      backgroundColor: AppConstants.appColor.buttonColor,
                      onPressedCallback: () {
                        String emailValidate = Validation.validateEmail(
                            widget.viewModel.formEmail.text.trim());
                        String passwordValid = Validation.validatePassword(
                            widget.viewModel.formPassword.text.trim());

                        if (emailValidate != Validation.SUCCESS) {
                          Commons.toastMessage(context, emailValidate);
                        } else if (passwordValid != Validation.SUCCESS) {
                          Commons.toastMessage(context, passwordValid);
                        } else {
                          Commons.toastMessage(
                              context, "Successfully login");
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
                          "  Don't have Account?  ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppConstants.appColor.textColor,
                            fontSize: SizeConfig.textMultiplier * 1.8,
                          ),
                        ),
                        Text(
                          "  Sign up ",
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
