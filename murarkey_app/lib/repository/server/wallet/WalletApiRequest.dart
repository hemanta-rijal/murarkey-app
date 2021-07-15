import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/wallet/WalletModel.dart';

/**
 * Created by Suman Prasad Neupane on 7/14/2021.
 */

class WalletApiRequest extends ApiRequest {
  getWalletInfo() {}

  Future<List<WalletModel>> getMyWalletHistory({String url}) async {
    List<WalletModel> result = new List();

    await this.getData(url: url, useToken: true).then((Map<String, dynamic> value) => {
      print("getServicesListFromCategory"),
      if (value != null)
        {
          result = value["data"]
              .map((i) => WalletModel.fromJson(i))
              .toList()
              .cast<WalletModel>(),
        }
      else
        {result = null}
    });
    return result;
  }
}
