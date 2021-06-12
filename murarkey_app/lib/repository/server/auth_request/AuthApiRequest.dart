import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/auth/LoginModel.dart';

/**
 * Created by Suman Prasad Neupane on 6/11/2021.
 */

class AuthApiRequest extends ApiRequest {
  // Get home page banners list
  Future<LoginModel> login({String url, Map<String, dynamic> params}) async {
    // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});

    LoginModel result = new LoginModel();

    await this
        .postData(url: url, params: params)
        .then((Map<String, dynamic> value) =>
    {
      result = LoginModel.fromJson(value),
    });
    return result;
  }

  Future<LoginModel> logout({String url}) async {
    LoginModel result = new LoginModel();

    await this
        .postData(url: url,)
        .then((Map<String, dynamic> value) =>
    {
      result = LoginModel.fromJson(value),
    });
    return result;
  }
}
