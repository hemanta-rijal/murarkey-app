import 'package:murarkey_app/repository/share_preferences/LocalSharePref.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 */

class UserTokenPref extends LocalSharePref {
  static final KEY_TOKEN_TYPE = "token_type";
  static final KEY_USER_TOKEN = "access_token";

  // For token type
  void setTokenType(String token) {
    getPref().setString(KEY_TOKEN_TYPE, token);
  }

  String getTokenType() {
    return getPref().getString(KEY_TOKEN_TYPE);
  }

  // For user access token
  void setUserToken(String token) {
    getPref().setString(KEY_USER_TOKEN, token);
  }

  Future<String> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_USER_TOKEN);
  }
}