import 'package:murarkey_app/repository/api_call/ApiRequest.dart';

class ReviewApi extends ApiRequest {
  //Product List
  Future<dynamic> postReview(
      {String url, Map<String, dynamic> queryParams}) async {
    dynamic result;

    await this
        .postData(url: url, params: queryParams, useToken: true)
        .then((Map<String, dynamic> value) {
      print("ReviewApi list");
      if (value != null) {
        result = value["message"];
      } else {
        result = null;
      }
    });
    return result;
  }
}
