import 'package:murarkey_app/botton_navigation_views/AccountFragmentWidget.dart';
import 'package:murarkey_app/botton_navigation_views/CartFragmentWidget.dart';
import 'package:murarkey_app/botton_navigation_views/HomeFragmentWidget.dart';
import 'package:murarkey_app/botton_navigation_views/MessageFragmentWidget.dart';
import 'package:murarkey_app/custom_views/BottomNavigationWidget.dart';
import 'package:murarkey_app/custom_views/CustomStatefulWidget.dart';
import 'package:murarkey_app/utils/Imports.dart';

class MainScreenWidget extends StatefulWidget {
  @override
  _MainScreenWidgetState createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends CustomStatefulWidgetState<MainScreenWidget> {

  @override
  Widget build(BuildContext context) {
    super.build(context);


    List<BottomNavigationModel> navigationModels = [];
    navigationModels.add(new BottomNavigationModel(
        title: "Home", icon: Icons.home, widgetView: HomeFragmentWidget()));
    navigationModels.add(new BottomNavigationModel(
        title: "Messages",
        icon: Icons.chat,
        widgetView: MessagesFragmentWidget()));
    navigationModels.add(new BottomNavigationModel(
        title: "Cart", icon: Icons.shopping_cart_rounded, widgetView: CartFragmentWidget()));
    navigationModels.add(new BottomNavigationModel(
        title: "Account",
        icon: Icons.account_circle_sharp,
        widgetView: AccountFragmentWidget()));


    return render(
        childWidget: BottomNavigationWidget(models: navigationModels));
  }
}
