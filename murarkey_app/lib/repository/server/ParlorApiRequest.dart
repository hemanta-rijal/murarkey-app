import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';

class ParlorApiRequest extends ApiRequest {
  // Get parlor list
  Future<List<ParlorModel>> getParlor(
      {String url, List<String> arguments}) async {
    List<ParlorModel> result = new List<ParlorModel>();

    await this.getData(url: url).then((Map<String, dynamic> value) => {
      print("ParlorModel"),
      if (value != null)
        {
          result = value["data"]
              .map((i) => ParlorModel.fromJson(i))
              .toList()
              .cast<ParlorModel>(),
        }
      else
        {result = null}
    });
    return result;
  }

  // Get parlor list
  Future<ParlorModel> getParlorDetails(
      {String url}) async {
    ParlorModel result = new ParlorModel();

    await this.getData(url: url).then((Map<String, dynamic> value) => {
      print("ParlorModelDetails"),
      if (value != null)
        {
          result = ParlorModel.fromJson(value["data"]),
        }
      else
        {result = null}
    });
    return result;
  }
}