import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/brands/BrandModel.dart';
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
  Future<List<ParlorModel>> getParlor(
      {String path, List<String> arguments}) async {
    List<ParlorModel> result = new List<ParlorModel>();

    await this.getData(path: path).then((Map<String, dynamic> value) => {
      print("ParlorModel"),
      result = value["data"]
          .map((i) => ParlorModel.fromJson(i))
          .toList()
          .cast<ParlorModel>(),
    });
    return result;
  }

  // Get parlor list
  Future<List<BrandModel>> getBrand(
      {String path, List<String> arguments}) async {
    List<BrandModel> result = new List<BrandModel>();

    await this.getData(path: path).then((Map<String, dynamic> value) => {
      print("BrandModel"),
      result = value["data"]
          .map((i) => BrandModel.fromJson(i))
          .toList()
          .cast<BrandModel>(),
    });
    return result;
  }
}
