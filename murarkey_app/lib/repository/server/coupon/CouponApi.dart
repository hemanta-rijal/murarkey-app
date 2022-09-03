import 'package:murarkey_app/repository/api_call/ApiRequest.dart';

class CouponApi extends ApiRequest {
  //get coupon
  //?code=MURARKEY75
  Future<Map<String, dynamic>> applyCoupon(
      {String url, Map<String, dynamic> queryParams}) async {
    Map<String, dynamic> value = await this.getData(
      url: url,
      queryParams: queryParams,
      useToken: true,
    );

    return value;
  }
}
