import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/auth/LoginModel.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';

/**
 * Created by Suman Prasad Neupane on 6/11/2021.
 */

class AuthApiRequest extends ApiRequest {
  //Login User
  Future<LoginModel> login({String url, Map<String, dynamic> params}) async {
    // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});
    LoginModel result = new LoginModel();

    await this
        .postData(url: url, params: params)
        .then((Map<String, dynamic> value) => {
              result = LoginModel.fromJson(value),
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
  Future<LoginModel> logout({String url}) async {
    LoginModel result = new LoginModel();

    await this
        .postData(
          url: url,
        )
        .then((Map<String, dynamic> value) => {
              result = LoginModel.fromJson(value),
            });
    return result;
  }
}
