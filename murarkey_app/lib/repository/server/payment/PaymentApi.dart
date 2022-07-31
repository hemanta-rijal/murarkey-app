import 'package:flutter/material.dart';
import 'package:murarkey_app/repository/api_call/ApiRequest.dart';

class PaymentApi extends ApiRequest {
  postCashOnDelivery({
    @required String url,
    @required Map<String, dynamic> params,
  }) async {
    List result = new List();

    var value = await this.postData(url: url, params: params, useToken: true);
    print("postCashOnDelivery-----------> ${value}");

    // if (value != null) {
    //   result = value["data"]
    //       .map((i) => WalletModel.fromJson(i))
    //       .toList()
    //       .cast<WalletModel>();
    // } else {
    //   result = null;
    // }
    return result;
  }
}
