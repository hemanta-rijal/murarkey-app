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
      .map((model) => BottomNavigationBarItem(
          icon: Icon(model.icon),
          label: model.title,
          backgroundColor: AppConstants.appColor.primaryColor))
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
        ),
      ),
    );
  }
}

class BottomNavigationModel {
  String title;
  IconData icon;
  Widget widgetView;

  BottomNavigationModel(
      {@required this.title, @required this.icon, @required this.widgetView});
}
