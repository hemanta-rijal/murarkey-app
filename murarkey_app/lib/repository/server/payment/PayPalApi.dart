import 'package:murarkey_app/repository/api_call/ApiRequest.dart';

/**
 * Created by Suman Prasad Neupane on 9/12/2021.
 */

class PayPalApi extends ApiRequest {
  //Add to Wishlis
  Future<dynamic> addToTransaction(
      {String url, Map<String, dynamic> params}) async {
    var result = await this.postData(
      url: url,
      params: params,
      useToken: false,
    );
    print("addToTransaction");
    print(result);
    return result;
  }
}
