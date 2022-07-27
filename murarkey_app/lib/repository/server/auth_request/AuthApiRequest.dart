import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/auth/LoginModel.dart';
import 'package:murarkey_app/repository/models/base_model/BaseModel.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';
import 'package:murarkey_app/repository/provider/GoogleSignInProvider.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/11/2021.
 */

class AuthApiRequest extends ApiRequest {
  //Login User
  Future<LoginModel> login({
    String url,
    Map<String, dynamic> params,
    BuildContext context,
  }) async {
    // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});
    Map<String, dynamic> value = await this.postData(url: url, params: params);
    print("login data");
    print(value);
    if (value == null) {
      return LoginModel(error: "Something went wrong.", success: false);
    } else if (value["success"] == false) {
      return LoginModel(error: value["error"], success: value["success"]);
    } else {
      return LoginModel.fromJson(value);
    }
  }

  //Register User
  Future<UserModel> register({
    String url,
    Map<String, dynamic> params,
  }) async {
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
    GoogleSignInProvider google = new GoogleSignInProvider();
    await google.googleLogout();

    await this.postData(url: url, useToken: true).then((value) {
      result = value;
    });
    return result;
  }

  //Login User
  Future<LoginModel> loginWithGoogle({
    String url,
    Map<String, dynamic> params,
    BuildContext context,
  }) async {
    // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});
    Map<String, dynamic> value = await this.postData(url: url, params: params);
    print("login data");
    print(value);
    if (value == null) {
      return LoginModel(error: "Something went wrong.", success: false);
    } else if (value["success"] == false) {
      return LoginModel(error: value["error"], success: value["success"]);
    } else {
      return LoginModel.fromJson(value);
    }
  }

  //Reset Password
  Future<String> resetPasswordAndAccount({
    String url,
    Map<String, dynamic> params,
    BuildContext context,
  }) async {
    Map<String, dynamic> value = await this.postData(
      url: url,
      params: params,
    );
    print(value);
    if (value == null) {
      return "Something went wrong";
    } else
      return value["message"];
  }
}
