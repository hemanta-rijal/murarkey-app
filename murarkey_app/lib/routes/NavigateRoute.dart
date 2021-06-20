import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/MainScreenWidget.dart';
import 'package:murarkey_app/views/address/widgets/EditBillingAddressWidget.dart';
import 'package:murarkey_app/views/address/widgets/EditShippingAddressWidget.dart';
import 'file:///D:/Personal/Projects/murarkey-app/murarkey_app/lib/views/address/widgets/EditAddressWidget.dart';
import 'package:murarkey_app/views/auth/register/RegisterWidget.dart';
import 'package:murarkey_app/views/book_appoinment/widget/BookAppontmentWidget.dart';
import 'package:murarkey_app/views/product/ProductDetailWidget.dart';
import 'package:murarkey_app/views/profile/EditProfileWidget.dart';
import 'package:murarkey_app/views/search/SearchWidget.dart';

class NavigateRoute {
  //1.
  //Flutter Routes & Navigation – Parameters, Named Routes, onGenerateRoute
  //https://www.youtube.com/watch?v=nyvwx7o277U
  //NavigateRoute.popAndPushNamed(context, NavigateRoute.HOME);

  static const String LOGIN = "LoginWidget";
  static const String REGISTER = "RegisterWidget";
  static const String HOME = "MainScreenWidget";
  static const String PROFILE_Edit = "EditProfileWidget";
  static const String ADDRESS_Edit = "EditAddressWidget";
  static const String ADDRESS_BILLING_Edit = "EditBillingAddressWidget";
  static const String ADDRESS_SHIPPING_Edit = "EditShippingAddressWidget";
  static const String BOOK_APPOINTMENT = "BookAppontmentWidget";
  static const String SEARCH = "SearchWidget";
  static const String PRODUCT_DETAIL = "ProductDetailWidget";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
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
      case ADDRESS_BILLING_Edit:
        return _MaterialPageRoute(EditBillingAddressWidget());
      case ADDRESS_SHIPPING_Edit:
        return _MaterialPageRoute(EditShippingAddressWidget());
      case BOOK_APPOINTMENT:
        return _MaterialPageRoute(BookAppontmentWidget());
      case SEARCH:
        Map<String, dynamic> arguments = args as Map;
        return _MaterialPageRoute(SearchWidget(
            categoryModelList: arguments["categoryModelList"],
            brandModelList: arguments["brandModelList"],
            categoryModel: arguments["categoryModel"]));
      case PRODUCT_DETAIL:
        Map<String, dynamic> arguments = args as Map;
        return _MaterialPageRoute(
            ProductDetailWidget(productModel: arguments["productDetailModel"]));
      default:
        LoginWidget();
      //   return _errorRoute();
    }
  }

  static _MaterialPageRoute(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }

  static pushNamed(context, routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  static pushNamedWithArguments(
      context, routName, Map<String, dynamic> arguments) {
    Navigator.of(context).pushNamed(routName, arguments: arguments);
  }

  static popAndPushNamed(context, routeName) {
    Navigator.of(context).popAndPushNamed(routeName);
  }

  static pop(context) {
    Navigator.of(context).pop();
  }

  static String initialRoute() {
    return NavigateRoute.HOME;
  }
}
