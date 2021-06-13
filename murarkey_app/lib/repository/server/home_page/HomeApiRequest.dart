import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/brands/BrandModel.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'dart:convert';

import 'package:murarkey_app/repository/models/popular_parlor/ParlorModel.dart';

/**
 * Created by Suman Prasad Neupane on 6/11/2021.
 */

class HomeApiRequest extends ApiRequest {
  // Get home page banners list
  Future<List<HomepageBannerModel>> getBanner(
      {String url, List<String> arguments}) async {
    List<HomepageBannerModel> result = new List<HomepageBannerModel>();

    await this.getData(url: url).then((Map<String, dynamic> value) => {
          print("HomepageBannerModel"),
          if (value != null)
            {
              result = value["data"]
                  .map((i) => HomepageBannerModel.fromJson(i))
                  .toList()
                  .cast<HomepageBannerModel>(),
            }
          else
            {result = null}
        });
    return result;
  }

  // Get category list
  Future<List<CategoryModel>> getCategory(
      {String url, List<String> arguments}) async {
    List<CategoryModel> result = new List<CategoryModel>();

    await this.getData(url: url).then((Map<String, dynamic> value) => {
          print("CategoryModel"),
          if (value != null)
            {
              result = value["data"]
                  .map((i) => CategoryModel.fromJson(i))
                  .toList()
                  .cast<CategoryModel>(),
            }
          else
            {result = null}
        });
    return result;
  }

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

  // Get brand list
  Future<List<BrandModel>> getBrand(
      {String url, List<String> arguments}) async {
    List<BrandModel> result = new List<BrandModel>();

    await this.getData(url: url).then((Map<String, dynamic> value) => {
          print("BrandModel"),
          if (value != null)
            {
              result = value["data"]
                  .map((i) => BrandModel.fromJson(i))
                  .toList()
                  .cast<BrandModel>(),
            }
          else
            {result = null}
        });
    return result;
  }
}
