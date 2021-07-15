import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/our_services/OurServicesModel.dart';
import 'package:murarkey_app/repository/models/our_services/service_category_lists/ServicesCategoryListsModel.dart';

/**
 * Created by Suman Prasad Neupane on 7/14/2021.
 */

class ServicesApiRequest extends ApiRequest{
  // Get services list and categories
  Future<List<OurServicesModel>> getOurServicesList({String url}) async {
    List<OurServicesModel> result = new List<OurServicesModel>();

    await this.getData(url: url).then((Map<String, dynamic> value) => {
      print("OurServices"),
      if (value != null)
        {
          result = value["data"]
              .map((i) => OurServicesModel.fromJson(i))
              .toList()
              .cast<OurServicesModel>(),
        }
      else
        {result = null}
    });
    return result;
  }

  Future<List<ServicesCategoryListsModel>> getServicesListFromCategory({String url}) async {
    List<ServicesCategoryListsModel> result = new List();

    await this.getData(url: url).then((Map<String, dynamic> value) => {
      print("getServicesListFromCategory"),
      if (value != null)
        {
          result = value["data"]
              .map((i) => ServicesCategoryListsModel.fromJson(i))
              .toList()
              .cast<ServicesCategoryListsModel>(),
        }
      else
        {result = null}
    });
    return result;
  }
}