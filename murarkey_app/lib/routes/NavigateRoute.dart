import 'package:murarkey_app/custom_views/loader/Loader2Widget.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'package:murarkey_app/views/MainScreenWidget.dart';
import 'package:murarkey_app/views/address/EditAddressWidget.dart';
import 'package:murarkey_app/views/address/widgets/EditBillingAddressWidget.dart';
import 'package:murarkey_app/views/address/widgets/EditShippingAddressWidget.dart';
import 'package:murarkey_app/views/app_loader/AppLoaderWidget.dart';
import 'package:murarkey_app/views/auth/register/RegisterWidget.dart';
import 'package:murarkey_app/views/book_appoinment/widget/BookAppontmentWidget.dart';
import 'package:murarkey_app/views/order/place_order/PlaceOrderWidget.dart';
import 'package:murarkey_app/views/our_services/OurServicesItemWidget.dart';
import 'package:murarkey_app/views/product/ProductDetailWidget.dart';
import 'package:murarkey_app/views/profile/EditProfileWidget.dart';
import 'package:murarkey_app/views/search/SearchWidget.dart';
import 'package:murarkey_app/views/wallet/WalletWidget.dart';

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
  static const String ORDER_PLACED_PRODUCTS = "PlaceOrderWidget";
  static const String MY_WALLET = "WalletWidget";
  static const String APP_LOADER = "AppLoaderWidget";
  static const String OUR_SERVICES_ITEM = "OurServicesItemWidget";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case LOGIN:
        return _MaterialPageRoute(LoginWidget());
      case APP_LOADER:
        return _MaterialPageRoute(AppLoaderWidget());
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
      case ORDER_PLACED_PRODUCTS:
        return _MaterialPageRoute(PlaceOrderWidget());
      case MY_WALLET:
        return _MaterialPageRoute(WalletWidget());
      case OUR_SERVICES_ITEM:
        Map<String, dynamic> arguments = args as Map;
        return _MaterialPageRoute(OurServicesItemWidget(title:arguments["title"], servicesList: arguments["servicesSubModel"],));
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
    return NavigateRoute.APP_LOADER;
  }
}
