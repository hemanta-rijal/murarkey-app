import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:murarkey_app/repository/api_call/ApiUrls.dart';
import 'package:murarkey_app/utils/Commons.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 6/27/2021.
 * https://developer.esewa.com.np/#/android?id=credentials-amp-urls
 * https://pub.dev/packages/esewa_pnp
 * https://www.youtube.com/watch?v=xeSTulUzmCc&ab_channel=AshimUpadhaya
 */
//Username: epaytest@gmail.com
// Password: test@1234
// Merchant ID/Service Code: EPAYTEST

class EsewaPayment {
  String CALLBACK_URL =
      ApiUrls.PAYMENT_ESWEA_CALLACK; //"https://somecallbackurl.com";
  String MERCHANT_ID = "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R";
  String MERCHANT_SECRET_KEY = "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==";

  void init(BuildContext context, double amount) async {
    //Create a ESewaConfiguration object
    ESewaConfiguration _configuration = ESewaConfiguration(
        clientID: MERCHANT_ID,
        secretKey: MERCHANT_SECRET_KEY,
        environment: ESewaConfiguration.ENVIRONMENT_TEST //ENVIRONMENT_LIVE
        );

    //Create ESewaPnp object and pass configuration.
    ESewaPnp _eSewaPnp = ESewaPnp(configuration: _configuration);

    //Finally create the payment object
    ESewaPayment _payment = ESewaPayment(
        amount: 20,
        productName: "someProductName",
        productID: "12345",
        //"someUniqueId_" + DateTime.now().millisecondsSinceEpoch.toString(),
        callBackURL: CALLBACK_URL);

    //Now call initPayment method.
    try {
      final _res = await _eSewaPnp.initPayment(payment: _payment);
      // Handle success
      Commons.toastMessage(context, _res.message);
      print("ESewaPayment");
      print(_res);
    } on ESewaPaymentException catch (e) {
      // Handle error
      Commons.toastMessage(context, e.message);
    }
  }
}
