import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/wallet/WalletModel.dart';
import 'package:murarkey_app/utils/Imports.dart';

/**
 * Created by Suman Prasad Neupane on 7/14/2021.
 */

class WalletApiRequest extends ApiRequest {
  Future<int> getWalletInfo({@required String url}) async {
    int result = 0;

    final value = await this.getData(url: url, useToken: true);
    print("getWalletInfo-----------> ${value}");

    if (value == null) {
      result = 0;
    } else {
      final data = value["data"];
      result = data["amount"];
      return result;
    }
    return result;
  }

  Future<List<WalletModel>> getMyWalletHistory({String url}) async {
    List<WalletModel> result = new List();

    await this
        .getData(url: url, useToken: true)
        .then((Map<String, dynamic> value) => {
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
