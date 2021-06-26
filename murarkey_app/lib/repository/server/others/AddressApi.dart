import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/country_list/CountryModel.dart';

/**
 * Created by Suman Prasad Neupane on 6/26/2021.
 */

class AddressApi extends ApiRequest {
  //Country List
  Future<List<CountryModel>> getCountryList({String url}) async {
    List<CountryModel> result = new List<CountryModel>();

    await this.getData(url: url).then((Map<String, dynamic> value) => {
          print("CountryModel list"),
          if (value != null)
            {
              result = value["data"]
                  .map((i) => CountryModel.fromJson(i))
                  .toList()
                  .cast<CountryModel>(),
            }
          else
            {result = null}
        });
    return result;
  }
}
