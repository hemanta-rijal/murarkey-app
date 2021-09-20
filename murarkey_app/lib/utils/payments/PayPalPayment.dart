import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:murarkey_app/repository/Repository.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 9/12/2021.
 */

class PayPalPayment {
  final _tokenizationKey = "sandbox_ndhr5c7k_b5wny6h357jq7kp4";
  static final AUSTRALIAN_CODE = "AUD";
  static final USA_CODE = "USD";

  payBalance(
      {@required Repository repository,
      @required var amount,
      @required String displayName,
      @required String currencyCode, Function(bool) onCallback}) async {
    var request = BraintreeDropInRequest(
      tokenizationKey: _tokenizationKey,
      collectDeviceData: true,
      paypalRequest: BraintreePayPalRequest(
        amount: amount,
        displayName: displayName,
        currencyCode: currencyCode,
      ),
      cardEnabled: false,
    );

    BraintreeDropInResult result = await BraintreeDropIn.start(request);
    if (result != null) {
      print(result.paymentMethodNonce.description);
      print(result.paymentMethodNonce.nonce);

      Map<String, dynamic> params = new Map<String, dynamic>();
      params["amount"] = amount;
      params["payment_method_nonce"] = result.paymentMethodNonce.nonce;
      params["device_data"] = result.deviceData;

      var data = await repository.payPalApi.addToTransaction(
        url: ApiUrls.PAYPAL_TRANSACTION,
        params: params,
      );

      onCallback(data["success"]);
    }
  }

  loadBalance(){

  }
}
