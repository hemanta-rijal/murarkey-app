import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:murarkey_app/repository/api_call/Api.dart';
import 'package:murarkey_app/repository/share_preferences/LocalSharePref.dart';
import 'package:murarkey_app/repository/share_preferences/UserTokenPref.dart';
import 'ApiUrls.dart';

/**
 * Created by Suman Prasad Neupane on 6/11/2021.
 * https://stackoverflow.com/questions/62215138/my-flutter-http-post-request-is-not-sending-form-data
 * https://stackoverflow.com/questions/64347175/how-to-post-form-data-request-using-flutter-in-http-package
 */
abstract class ApiRequest extends Api {
  UserTokenPref _sharePref;

  ApiRequest() {
    _sharePref = new UserTokenPref();
  }

  Uri _getUrl(String urlPath) {
    if (ApiUrls.BASE_URL.contains("http")) {
      return Uri.http(ApiUrls.BASE_URL.replaceAll("http://", "www."), urlPath,
          {'q': '{http}'});
    } else {
      return Uri.https(ApiUrls.BASE_URL.replaceAll("https://", "www."), urlPath,
          {'q': '{http}'});
    }
  }

  Future<Map<String, String>> _headers(bool useToken) async {
    // Headers
    //var response = await http.get(url, headers: {'Authorization': 'Bearer $_token'});

    useToken = useToken == null ? false : useToken;

    Map<String, String> headers = new Map();
    headers["Content-Type"] = "application/json";
    headers["Accept"] = "application/json";

    if (useToken) {
      //'Authorization': 'Bearer $token',
      await _sharePref.getUserToken().then((value) => {
            headers["Authorization"] = "Bearer ${value}",
            print("useToken " + value)
          });
    }

    return headers;
  }

  Map<String, dynamic> _parseData(http.Response response, String url) {
    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(url);
      print(jsonResponse);
      _saveUserToken(jsonResponse, url);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  _saveUserToken(Map<String, dynamic> jsonResponse, String url) {
    if (url == ApiUrls.LOGIN_URL) {
      _sharePref.setTokenType(jsonResponse["token_type"]);
      _sharePref.setUserToken(jsonResponse["access_token"]);

      _sharePref.getUserToken().then((value) => {print("useToken " + value)});
    }
  }

  @override
  Future<Map<String, dynamic>> getData(
      {String url,
      Map<String, dynamic> queryParams,
      List<String> arguments,
      bool useToken}) async {
    super.getData();
    try {
      //for http url
      var full_url = ApiUrls.BASE_URL + url;
      print(full_url);

      //params
      if (queryParams != null) {
        String queryString = Uri(queryParameters: queryParams).query;
        url = url + "?" + queryString;
      }

      //
      print("headers");
      var header = await _headers(useToken);
      print(header);

      // Get Http call
      // Await the http get response, then decode the json-formatted response.
      http.Response response = await http
          .get(full_url, headers: header)
          .timeout(const Duration(seconds: 60));
      ;
      return _parseData(response, url);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> postData(
      {String url,
      Map<String, dynamic> params,
      List<String> arguments,
      bool useToken}) async {
    super.postData();
    try {
      // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});

      //for https url
      var full_url = ApiUrls.BASE_URL + url;
      //print(full_url);

      // Body
      var body = json.encode(params);
      print(params);

      //
      print("headers");
      var header = await _headers(useToken);
      print(header);

      // Post Http call
      // Await the http get response, then decode the json-formatted response.
      http.Response response = await http
          .post(
            full_url,
            body: body,
            headers: header,
          )
          .timeout(const Duration(seconds: 60));
      return _parseData(response, url);
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<Map<String, dynamic>> putData(
      {String url,
        Map<String, dynamic> params,
        List<String> arguments,
        bool useToken}) async {
    super.postData();
    try {
      // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});

      //for https url
      var full_url = ApiUrls.BASE_URL + url;
      //print(full_url);

      // Body
      var body = json.encode(params);
      print(params);

      //
      print("headers");
      var header = await _headers(useToken);
      print(header);

      // Post Http call
      // Await the http get response, then decode the json-formatted response.
      http.Response response = await http
          .put(
        full_url,
        body: body,
        headers: header,
      )
          .timeout(const Duration(seconds: 60));
      return _parseData(response, url);
    } catch (e) {
      print(e);
      return null;
    }
  }
}

//TODO: Image upload and multi form data
// @override
// Future<Map<String, dynamic>> postData(
//     {String url, Map<String, String> params, List<String> arguments}) async {
//   super.postData();
//   try {
//     // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});
//
//     //for https url
//     var full_url = ApiUrls.BASE_URL + url;
//     print(full_url);
//
//     // Headers
//     //var response = await http.get(url, headers: {'Authorization': 'Bearer $_token'});
//     var headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//
//       //"Content-Type": "application/x-www-form-urlencoded"
//     };
//
//     // Body
//     var body = json.encode(params);
//     print(params);
//
//     var uri = Uri.parse('${ApiUrls.BASE_URL}${url}');
//
//     var request = http.MultipartRequest('POST', uri)..fields.addAll(params);
//
//     request.headers.addAll({
//       //'Content-Type': 'application/json',
//       'Content-Type': 'multipart/form-data',
//       'Accept': 'application/json',
//       //'Authorization':'your token'
//     });
//
//     var response = await request.send();
//     final respStr = await response.stream.bytesToString();
//     print(
//       jsonDecode(respStr),
//     );
//     //
//     // if (response.statusCode == 200) {
//     //   var jsonResponse =
//     //   convert.jsonDecode(respStr) as Map<String, dynamic>;
//     //   print(jsonResponse);
//     //   return jsonResponse;
//     // } else {
//     //   print('Request failed with status: ${response.statusCode}.');
//     // }
//   } catch (e) {
//     print(e);
//   }
// }

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
