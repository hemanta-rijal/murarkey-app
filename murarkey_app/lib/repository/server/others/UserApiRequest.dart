import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';

/**
 * Created by Suman Prasad Neupane on 6/22/2021.
 */

class UserApiRequest extends ApiRequest{
  //About user
  Future<UserModel> getMyDetails(
      {String url}) async {
    // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});
    var result;

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
    return result;
  }
}