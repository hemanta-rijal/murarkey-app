import 'package:murarkey_app/utils/Imports.dart';

class BottomNavigationWidget extends StatefulWidget {
  List<BottomNavigationModel> models;

  BottomNavigationWidget({Key key, @required this.models}) : super(key: key);

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _navigationWidgetScreenList() =>
      widget.models.map((model) => model.widgetView);

  navigationItemList() => widget.models
      .map(
        (model) => BottomNavigationBarItem(
          icon: model.icon != null ? Icon(model.icon) : model.svgIcon,
          label: model.title,
          activeIcon: model.svgIcon != null ? model.svgActiveIcon : null,
          backgroundColor: AppConstants.appColor.primaryColor,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: _navigationWidgetScreenList().elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: navigationItemList(),
          currentIndex: _selectedIndex,
          selectedItemColor: AppConstants.appColor.accentColor,
          unselectedItemColor: AppConstants.appColor.whiteColor,
          backgroundColor: AppConstants.appColor.primaryColor,
          onTap: _onItemTapped,
          iconSize: 22,
          elevation: 4,
        ),
      ),
    );
  }
}

class BottomNavigationModel {
  String title;
  IconData icon;
  Widget svgIcon;
  Widget svgActiveIcon;
  Widget widgetView;

  //if you use svg image then pass
  //svgIcon and svgActiveIcon images
  //and icon = null
  BottomNavigationModel({
    @required this.title,
    @required this.icon,
    @required this.widgetView,
    this.svgIcon,
    this.svgActiveIcon,
  });
}
