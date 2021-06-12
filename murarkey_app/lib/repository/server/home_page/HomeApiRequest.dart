import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'dart:convert';

import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';

/**
 * Created by Suman Prasad Neupane on 6/11/2021.
 */

class HomeApiRequest extends ApiRequest {
  // Get home page banners list
  Future<List<HomepageBannerModel>> getBanner(
      {String path, List<String> arguments}) async {
    List<HomepageBannerModel> result = new List<HomepageBannerModel>();

    await this.getData(path: path).then((Map<String, dynamic> value) => {
          print("HomepageBannerModel"),
          result = value["data"]
              .map((i) => HomepageBannerModel.fromJson(i))
              .toList()
              .cast<HomepageBannerModel>(),
        });
    return result;
  }

  // Get parlor list
  Future<List<ParlorModel>> getPopularParlor(
      {String path, List<String> arguments}) async {
    List<ParlorModel> result = new List<ParlorModel>();

    await this.getData(path: path).then((Map<String, dynamic> value) => {
      print("PopularParlorModel"),
      result = value["data"]
          .map((i) => ParlorModel.fromJson(i))
          .toList()
          .cast<ParlorModel>(),
    });
    return result;
  }
}
