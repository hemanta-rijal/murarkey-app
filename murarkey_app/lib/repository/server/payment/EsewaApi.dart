import 'dart:math';

import 'package:murarkey_app/repository/api_call/ApiRequest.dart';

class EsewaApi extends ApiRequest {
  //Get Eswea PID
  //{data: {pid: 9587767235}, success: true, status: 200, message: esewa pid stored and returned successfully}
  Future getEsewaPID({String url}) async {
    var result = await this.getData(
      url: url,
      useToken: true,
    );
    print("getEsewaPID");
    print(result);

    var pid = result["data"]["pid"];
    print("pid ${pid}");
    return pid.toString();
  }
}
