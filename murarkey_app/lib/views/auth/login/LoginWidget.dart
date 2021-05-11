import 'package:flutter/services.dart';
import 'package:murarkey_app/custom_views/CheckBoxWidget.dart';
import 'package:murarkey_app/custom_views/EditText.dart';
import 'package:murarkey_app/custom_views/FlatStatefulButton.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/utils/Validation.dart';
import 'package:murarkey_app/views/auth/login/LoginViewModel.dart';

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
    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom, SystemUiOverlay.top]);

    return Scaffold(
      backgroundColor: AppConstants.appColor.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // Email
            new EditText(
              text: "Email",
              icon: Icons.email,
              fontSize: SizeConfig.textMultiplier * 2.5,
              textColor: AppConstants.appColor.textColor,
              keyboardType: TextInputType.emailAddress,
              margin: EdgeInsets.only(top: screenSize.width * .05, bottom: screenSize.width * .05),
              controller: widget.viewModel.formEmail,
            ),

            //Password
            new EditText(
              text: AppConstants.constants.PASSWORD,
              icon: Icons.remove_red_eye,
              fontSize: SizeConfig.textMultiplier * 2.5,
              textColor: AppConstants.appColor.textColor,
              keyboardType: TextInputType.text,
              margin: EdgeInsets.only(bottom: screenSize.width * .08),
              controller: widget.viewModel.formPassword,
              obscureText: true,
            ),

            //Remember me
            CheckboxWidget(
              text: AppConstants.constants.REMEMBER_ME,
              value: widget.viewModel.rememberME,
              onValueChange: (bool value) {
                setState(() {
                  widget.viewModel.rememberME = value;
                });
              },
              fontSize: SizeConfig.textMultiplier * 2.2,
              textColor: AppConstants.appColor.textColor,
              screenSize: screenSize,
              margin: EdgeInsets.only(bottom: screenSize.width * .05),
            ),

            //Log in
            new FlatStatefulButton(
              text: AppConstants.constants.LOG_IN,
              fontSize: SizeConfig.textMultiplier * 2.0,
              textColor: AppConstants.appColor.whiteColor,
              padding: EdgeInsets.all(screenSize.width * .02),
              backgroundColor: AppConstants.appColor.primaryDarkColor,
              onPressedCallback: () {
                String emailValidate =
                Validation.validateEmail(widget.viewModel.formEmail.text.trim());
                String passwordValid =
                Validation.validatePassword(widget.viewModel.formPassword.text.trim());

                if (emailValidate != Validation.SUCCESS) {
                  Commons.toastMessage(context, emailValidate);
                } else if (passwordValid != Validation.SUCCESS) {
                  Commons.toastMessage(context, passwordValid);
                } else {
                  Commons.toastMessage(context, "Successfully login");
                  //ShowAlert.saveCredentials(widget, false, _repository);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
