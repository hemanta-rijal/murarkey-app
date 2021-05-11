import 'package:murarkey_app/utils/Imports.dart';

class AppColor {
  int get _primaryDarkColor => 0x4c3061;

  final MaterialColor primarySwatchColor =
      new MaterialColor(0x4c3061, <int, Color>{
    500:  new Color(0x4c3061).withOpacity(1.0),
  });

  final Color primaryDarkColor = new Color(0x4c3061).withOpacity(1.0);
  final Color primaryColor = new Color(0x795a8f).withOpacity(1.0);
  final Color primaryLightColor = new Color(0xa987bf).withOpacity(1.0);

  final Color accentColor = new Color(0xdbc4a3).withOpacity(1.0);
  final Color textColor = new Color(0x795a8f).withOpacity(1.0);
  final Color textHintColor = new Color(0xdbc4a3).withOpacity(1.0);

  final Color blackColor = new Color(0x000000).withOpacity(1.0);
  final Color whiteColor = new Color(0xFFFFFF).withOpacity(1.0);
}
