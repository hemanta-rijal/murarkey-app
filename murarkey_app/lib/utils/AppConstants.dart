import 'package:murarkey_app/themes/AppTheme.dart';
import 'package:murarkey_app/themes/colors/AppColor.dart';

class AppConstants{
  static _Constants get constants => _Constants();
  static AppColor get appColor => AppColor();
  static AppTheme get appTheme => AppTheme();
}

class _Constants {
  String get APP_NAME => "Murarkey";

  // Login
  String get EMAIL => "Email";
  String get PASSWORD => "Password";
  String get LOG_IN => 'LOG IN';
  String get FORGET_PASSWORD => "Forgot Password";
  String get REMEMBER_ME => "Remember me";

}

class _PaddingConstants{

}

