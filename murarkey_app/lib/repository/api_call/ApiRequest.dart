import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:murarkey_app/repository/api_call/Api.dart';
import 'package:murarkey_app/utils/Imports.dart';
import 'ApiUrls.dart';

/**
 * Created by Suman Prasad Neupane on 6/11/2021.
 */
abstract class ApiRequest extends Api {
  @override
  Future<Map<String, dynamic>> getData({String path, List<String> arguments}) async {
    super.getData();
    try {
      //for https url
      //var url = Uri.https(ApiUrls.BASE_URL, path, {'q': '{http}'});

      //for https url
      var url = ApiUrls.BASE_URL + path;

      // Headers
      //var response = await http.get(url, headers: {'Authorization': 'Bearer $_token'});
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        //print(jsonResponse);
        return jsonResponse;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<dynamic> postData() {
    super.postData();
  }
}

//https://stackoverflow.com/questions/61577284/fetch-data-from-web-api-in-flutter
// Future fetchData() async {
//     var body =
//         json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});
//     http.Response response;
//     response = await http.post("http://example.com",
//         body: body, headers: {'Content-type': 'application/json'});
//
//     if (response.statusCode == 200) {
//       setState(() {
//         mapresponse = jsonDecode(response.body);
//         listfacts = mapresponse['Data'];
//       });
//     }
//   }
