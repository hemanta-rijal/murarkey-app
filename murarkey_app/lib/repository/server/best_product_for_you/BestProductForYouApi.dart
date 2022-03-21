import 'package:flutter/material.dart';
import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/best_product_for_you/SkinVarientModel.dart';

/**
 * Created by Suman Prasad Neupane on 3/21/2022.
 */
class BestProductForYouApi extends ApiRequest {
  // Get home page banners list
  Future<List<SkinVarientModel>> getSkinVarient({
    String url,
  }) async {
    List<SkinVarientModel> result = [];

    await this.getData(url: url).then((Map<String, dynamic> value) {
      print("SkinVarientModel");
      if (value != null) {
        result = value["data"]
            .map((i) => SkinVarientModel.fromJson(i))
            .toList()
            .cast<SkinVarientModel>();
      } else {
        result = null;
      }

      print("SkinVarientModel-------> ${result}");
    });
    return result;
  }
}
