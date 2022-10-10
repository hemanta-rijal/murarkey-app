import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';

/**
 * Created by Suman Prasad Neupane on 6/22/2021.
 */

class UserApiRequest extends ApiRequest {
  //About user
  Future<UserModel> getMyDetails({String url}) async {
    var result;

    try {
      await this
          .postData(url: url, useToken: true)
          .then((Map<String, dynamic> value) => {
                print("userme"),
                if (value != null)
                  {
                    result = UserModel.fromJson(value["user"]),
                  }
                else
                  {result = null}
              });
    } catch (e) {
      result = null;
    }
    return result;
  }

  //About user
  Future updateUserProfile({String url, Map<String, dynamic> params}) async {
    var result;

    await this
        .postData(url: url, params: params, useToken: true)
        .then((Map<String, dynamic> value) {
      print("updateUserProfile");
      if (value != null) {
        result = value;
      } else {
        result = null;
      }
    });
    return result;
  }

  //Change Password
  Future changePassword({String url, Map<String, dynamic> params}) async {
    var result;

    await this
        .postData(url: url, params: params, useToken: true)
        .then((Map<String, dynamic> value) {
      print("changePassword");
      if (value != null) {
        result = value;
      } else {
        result = null;
      }
    });
    return result;
  }
}
