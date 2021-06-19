import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/join_professional/JoinProfessionalModel.dart';

/**
 * Created by Suman Prasad Neupane on 6/18/2021.
 */

class JoinProfessionalApi extends ApiRequest {
  //Join Us
  Future<JoinProfessionalModel> postJoinProfessional({String url, Map<String, dynamic> params}) async {
    // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});
    JoinProfessionalModel result = new JoinProfessionalModel();

    await this.postData(url: url, params: params).then((Map<String, dynamic> value) => {
          print("ProductDetailModel"),
          if (value != null)
            {
              result = JoinProfessionalModel.fromJson(value),
            }
          else
            {result = null}
        });
    return result;
  }
}
