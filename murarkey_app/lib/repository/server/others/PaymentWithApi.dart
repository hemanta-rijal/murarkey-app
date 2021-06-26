import 'package:murarkey_app/repository/api_call/ApiRequest.dart';

/**
 * Created by Suman Prasad Neupane on 6/21/2021.
 */

class PaymentWithApi extends ApiRequest {
  //Get Payment List
  Future<dynamic> getPaymentList({String url}) async {
    var result;

    await this.getData(url: url).then((Map<String, dynamic> value) => {
          print("getPaymentList"),
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