import 'package:murarkey_app/repository/api_call/ApiRequest.dart';

/**
 * Created by Suman Prasad Neupane on 6/26/2021.
 */

class PaymentCardAddressApi extends ApiRequest{
  //Update Billing Address
  Future<dynamic> updateBillingAddress({String url, Map<String, dynamic> params}) async {
    var result;

    await this
        .postData(url: url, params: params, useToken: true)
        .then((Map<String, dynamic> value) => {
      print("updateBillingAddress"),
      if (value != null)
        {
          result = value,
        }
      else
        {result = null}
    });
    return result;
  }

  //Update Shipping Address
  Future<dynamic> updateShippingAddress({String url, Map<String, dynamic> params}) async {
    var result;

    await this
        .postData(url: url, params: params, useToken: true)
        .then((Map<String, dynamic> value) => {
      print("updateShippingAddress"),
      if (value != null)
        {
          result = value,
        }
      else
        {result = null}
    });
    return result;
  }
}