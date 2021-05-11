import 'package:murarkey_app/utils/Imports.dart';

class AppTheme{
  ThemeData buildTheme() {

    return ThemeData(
      primarySwatch: Colors.amber,
      primaryColor: AppConstants.appColor.primaryColor,
      primaryColorDark: AppConstants.appColor.primaryDarkColor,
      accentColor: AppConstants.appColor.accentColor,

      hintColor: AppConstants.appColor.textHintColor,

      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: AppConstants.appColor.primaryDarkColor,
        ),
        labelStyle: TextStyle(
          color: AppConstants.appColor.primaryLightColor,
        ),
      ),
    );
  }
}