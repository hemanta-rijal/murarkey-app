import 'package:murarkey_app/botton_navigation_views/AccountFragmentWidget.dart';
import 'package:murarkey_app/botton_navigation_views/CartFragmentWidget.dart';
import 'package:murarkey_app/botton_navigation_views/HomeFragmentWidget.dart';
import 'package:murarkey_app/botton_navigation_views/WishlistFragmentWidget.dart';
import 'package:murarkey_app/custom_views/BottomNavigationWidget.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/custom_views/load_image/SvgImage.dart';
import 'package:murarkey_app/utils/Imports.dart';

class MainScreenWidget extends StatefulWidget {
  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState
    extends CustomStatefulWidgetState<MainScreenWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<BottomNavigationModel> navigationModels = [];
    navigationModels.add(
      new BottomNavigationModel(
        title: "Home",
        icon: Icons.home,
        widgetView: HomeFragmentWidget(),
      ),
    );
    navigationModels.add(
      new BottomNavigationModel(
        title: "Cart",
        icon: Icons.shopping_cart_rounded,
        widgetView: CartFragmentWidget(),
      ),
    );
    navigationModels.add(
      new BottomNavigationModel(
        title: "Wishlist",
        icon: null,
        svgIcon: svgImageAssert3(
          imgUrl: "images/cart/ic_wishlist.svg",
          color: AppConstants.appColor.whiteColor,
          size: 22,
        ),
        svgActiveIcon: svgImageAssert3(
          imgUrl: "images/cart/ic_wishlist.svg",
          color: AppConstants.appColor.accentColor,
          size: 22,
        ),
        widgetView: WishlistFragmentWidget(),
      ),
    );
    navigationModels.add(
      new BottomNavigationModel(
        title: "Account",
        icon: Icons.account_circle_sharp,
        widgetView: AccountFragmentWidget(),
      ),
    );

    return render(
        childWidget: BottomNavigationWidget(models: navigationModels));
  }
}
