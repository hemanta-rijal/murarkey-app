import 'package:intl/intl.dart';
import 'package:murarkey_app/repository/share_preferences/LocalSharePref.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 */

class UserTokenPref{ //extends LocalSharePref {
  static final KEY_TOKEN_TYPE = "token_type";
  static final KEY_USER_TOKEN = "access_token";
  static final KEY_USER_SESSION = "x-app-session";
  static final KEY_USER_SESSION_TIME = "x-token-expires";


  // For token type
  void setTokenType(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(KEY_TOKEN_TYPE, token);
  }

  Future<String> getTokenType() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(KEY_TOKEN_TYPE);
  }

  // For user access token
  void setUserToken(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(KEY_USER_TOKEN, token);
  }

  Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_USER_TOKEN);
  }

  // For user session
  void setUserSession(String token) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(KEY_USER_SESSION, token);
  }

  Future<String> getUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_USER_SESSION);
  }

  // For user session
  void setSessionExpireTime(String timeSec) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    timeSec = _convertSecondToDateTime(timeSec);
    _prefs.setString(KEY_USER_SESSION_TIME, timeSec);
  }

  Future<String> getSessionExpireTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_USER_SESSION_TIME);
  }


  String _convertSecondToDateTime(String timeSec){
    String splittedTimeSec = timeSec.split("sec")[0];
    int time = int.parse(splittedTimeSec);
    //print("splitted time------> ${time}");

    DateTime now = DateTime.now();
    now = now.add(Duration(seconds:time));
    dynamic currentTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    //dynamic currentTime = DateFormat.jm().format(now);
    //print("SessionExpireTime------> ${currentTime}");

    return currentTime;
  }
}
