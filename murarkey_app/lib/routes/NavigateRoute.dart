import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/MainScreenWidget.dart';
import 'package:murarkey_app/views/address/EditAddressWidget.dart';
import 'package:murarkey_app/views/auth/register/RegisterWidget.dart';
import 'package:murarkey_app/views/profile/EditProfileWidget.dart';

class NavigateRoute{
  //1.
  //Flutter Routes & Navigation – Parameters, Named Routes, onGenerateRoute
  //https://www.youtube.com/watch?v=nyvwx7o277U
  //NavigateRoute.popAndPushNamed(context, NavigateRoute.HOME);

  static const String LOGIN = "LoginWidget";
  static const String REGISTER = "RegisterWidget";
  static const String HOME = "MainScreenWidget";
  static const String PROFILE_Edit = "EditProfileWidget";
  static const String ADDRESS_Edit = "EditAddressWidget";

  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case LOGIN:
        return _MaterialPageRoute(LoginWidget());
      case REGISTER:
        return _MaterialPageRoute(RegisterWidget());
      case HOME:
        return _MaterialPageRoute(MainScreenWidget());
      case PROFILE_Edit:
        return _MaterialPageRoute(EditProfileWidget());
      case ADDRESS_Edit:
        return _MaterialPageRoute(EditAddressWidget());
      default:
        LoginWidget();
      //   return _errorRoute();
    }
  }

  static _MaterialPageRoute(Widget widget){
    return MaterialPageRoute(builder: (_) => widget);
  }

  static pushNamed(context, routeName){
    Navigator.of(context).pushNamed(routeName);
  }

  static popAndPushNamed(context, routeName){
    Navigator.of(context).popAndPushNamed(routeName);
  }

  static pop(context){
    Navigator.of(context).pop();
  }
}