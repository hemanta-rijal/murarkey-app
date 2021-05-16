import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/MainScreenWidget.dart';
import 'package:murarkey_app/views/auth/register/RegisterWidget.dart';

class NavigateRoute{
  //1.
  //Flutter Routes & Navigation – Parameters, Named Routes, onGenerateRoute
  //https://www.youtube.com/watch?v=nyvwx7o277U
  //NavigateRoute.popAndPushNamed(context, NavigateRoute.HOME);

  static const String LOGIN = "LoginWidget";
  static const String REGISTER = "RegisterWidget";
  static const String HOME = "MainScreenWidget";

  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name){
      case LOGIN:
        return _MaterialPageRoute(LoginWidget());
      case REGISTER:
        return _MaterialPageRoute(RegisterWidget());
      case HOME:
        return _MaterialPageRoute(MainScreenWidget());
      default:
        LoginWidget();
      //   return _errorRoute();
    }
  }

  static _MaterialPageRoute(Widget widget){
    return MaterialPageRoute(builder: (_) => widget);
  }

  static pushNamed(context, routeName){
    Navigator.of(context).popAndPushNamed(routeName);
  }

  static popAndPushNamed(context, routeName){
    Navigator.of(context).popAndPushNamed(routeName);
  }

  static pop(context){
    Navigator.of(context).pop();
  }
}