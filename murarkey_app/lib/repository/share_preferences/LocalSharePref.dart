import 'package:shared_preferences/shared_preferences.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 * https://suragch.medium.com/saving-and-reading-data-in-flutter-with-sharedpreferences-bb4238d3105
 * https://stackoverflow.com/questions/52831605/flutter-shared-preferences
 * https://stackoverflow.com/questions/51112206/how-to-use-shared-preference-in-flutter
 */

class LocalSharePref {
  SharedPreferences _prefs;

  LocalSharePref() {
    _init();
  }

  _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences getPref() {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    return _prefs;
  }

}
