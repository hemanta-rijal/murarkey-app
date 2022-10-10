import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/navigation_drawer/MenuItemModel.dart';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class NavigationDrawerApi extends ApiRequest {
  Future<List<MenuItemModel>> getMenu({
    String url,
  }) async {
    List<MenuItemModel> result = [];

    try {
      //for http url
      var full_url = getUrl(url);
      print("url= ");
      print(full_url);

      //
      print("headers");
      var header = await headers(false);
      print(header);

      // Get Http call
      // Await the http get response, then decode the json-formatted response.
      http.Response response = await http
          .get(full_url, headers: header)
          .timeout(const Duration(seconds: 60));
      List<dynamic> data = await _parseData(response, url) as List<dynamic>;

      print("Data-> ${data}");
      if (data != null) {
        result = data
            .map((i) => MenuItemModel.fromJson(i))
            .toList()
            .cast<MenuItemModel>();
      } else {
        result = null;
      }

      return result;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future _parseData(http.Response response, String url) async {
    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse = convert.jsonDecode(response.body);
      var jsonHeader = response.headers;
      print(url);
      print(jsonResponse);
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
