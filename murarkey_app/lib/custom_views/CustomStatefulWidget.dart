import 'package:flutter/services.dart';
import 'package:murarkey_app/utils/Imports.dart';

class CustomStatefulWidgetState<T> extends State {
  Size screenSize;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppConstants.appColor.primaryDarkColor));
    screenSize = MediaQuery.of(context).size;
    SizeConfig().init(context);
  }

  Widget render({ @required Widget childWidget}) {
    return Material(
      color: AppConstants.appColor.backgroundColor,
      child: childWidget
    );
  }
}
