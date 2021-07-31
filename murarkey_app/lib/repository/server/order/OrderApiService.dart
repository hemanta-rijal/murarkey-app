import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/order/MyOrderModel.dart';

/**
 * Created by Suman Prasad Neupane on 7/23/2021.
 */

class OrderApiService extends ApiRequest {
  //My order List
  Future<List<MyOrderModel>> getMyOrderList(
      {String url, Map<String, dynamic> queryParams}) async {
    List<MyOrderModel> result = new List();

    await this
        .getData(url: url, useToken: true)
        .then((Map<String, dynamic> value) {
      print("MyOrderModel list");
      if (value != null) {
        result = value["data"]
            .map((i) => MyOrderModel.fromJson(i))
            .toList()
            .cast<MyOrderModel>();
      } else {
        result = null;
      }
    });
    return result;
  }
}
