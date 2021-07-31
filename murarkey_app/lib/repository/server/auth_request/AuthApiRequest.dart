import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/auth/LoginModel.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/11/2021.
 */

class AuthApiRequest extends ApiRequest {
  //Login User
  Future<LoginModel> login(
      {String url, Map<String, dynamic> params, BuildContext context}) async {
    // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});
    LoginModel result = new LoginModel();

    await this
        .postData(url: url, params: params)
        .then((Map<String, dynamic> value) {
      print("login data");
      print(value);
      if (value.containsKey("success")) {
        if (value["success"] == false) {
          Commons.toastMessage(context, value["message"]);
          return null;
        }
      } else {
        result = LoginModel.fromJson(value);
      }
    });
    return result;
  }

  //Register User
  Future<UserModel> register({String url, Map<String, dynamic> params}) async {
    // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});
    UserModel result = new UserModel();

    await this
        .postData(url: url, params: params)
        .then((Map<String, dynamic> value) => {
              if (value == null)
                {print(value)}
              else if (value["success"])
                {result = UserModel.fromJson(value["data"])}
              else
                {result = null}
            });
    return result;
  }

  //Logout user
  Future logout({String url}) async {
    var result;

    await this.postData(url: url, useToken: true).then((value) {
      result = value;
    });
    return result;
  }
}
