import 'package:murarkey_app/themes/AppTheme.dart';
import 'package:murarkey_app/themes/colors/AppColor.dart';

class AppConstants{
  static _Constants get constants => _Constants();
  static AppColor get appColor => AppColor();
  static AppTheme get appTheme => AppTheme();
}

class _Constants {
  String get APP_NAME => "Murarkey";

  // Login and Register
  String get EMAIL => "Email";
  String get PASSWORD => "Password";
  String get CONFIRM_PASSWORD => "Confirm Password";
  String get LOG_IN => 'LOG IN';
  String get REGISTER => 'REGISTER';
  String get FORGET_PASSWORD => "Lost your password?";
  String get REMEMBER_ME => "Remember me";
  String get PRIVACY_POLICY_MSG => '© Your personal data will be used to support your experience throughout this app, to manage access to your account as described in our';
  String get PRIVACY_POLICY => " privacy policy.";

}

class _PaddingConstants{

}

