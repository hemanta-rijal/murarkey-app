import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/cart/CartModel.dart';
import 'package:murarkey_app/repository/models/product_detail/ProductDetailModel.dart';

/**
 * Created by Suman Prasad Neupane on 6/16/2021.
 */

class ProductRequestApi extends ApiRequest {
  //Product List
  Future<List<ProductDetailModel>> getProductList(
      {String url, Map<String, dynamic> queryParams}) async {
    List<ProductDetailModel> result = new List<ProductDetailModel>();
    var links;
    var meta;

    await this
        .getData(url: url, queryParams: queryParams)
        .then((Map<String, dynamic> value) => {
              print("ProductDetailModel list"),
              if (value != null)
                {
                  result = value["data"]
                      .map((i) => ProductDetailModel.fromJson(i))
                      .toList()
                      .cast<ProductDetailModel>(),
                }
              else
                {result = null}
            });
    return result;
  }

  //Product Detail
  Future<ProductDetailModel> getProductDetail({String url}) async {
    // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});
    ProductDetailModel result = new ProductDetailModel();

    await this.getData(url: url).then((Map<String, dynamic> value) => {
          print("ProductDetailModel"),
          if (value != null)
            {
              result = ProductDetailModel.fromJson(value["data"]),
            }
          else
            {result = null}
        });
    return result;
  }

  //Add to Card
  Future<dynamic> addToCard({String url, Map<String, dynamic> params}) async {
    // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});
    var result;

    try {
      await this
          .postData(url: url, params: params, useToken: true)
          .then((Map<String, dynamic> value) =>
      {
        print("addToCard"),
        if (value != null)
          {
            result = value,
          }
        else
          {result = null}
      });
    }catch(e){
      result = null;
    }
    return result;
  }

  //Add to Card
  Future<dynamic> proceedAllToCard({String url}) async {
    var result;

    await this
        .postData(url: url, useToken: true)
        .then((Map<String, dynamic> value) => {
              print("proceedAllToCard"),
              if (value != null)
                {
                  result = value,
                }
              else
                {result = null}
            });
    return result;
  }

  //Update to Card
  Future<dynamic> updateToCard(
      {String url, Map<String, dynamic> params}) async {
    // var body = json.encode({"IsActive": true, "IsDelete": false, "CompanyId": 18});
    var result;

    await this
        .putData(url: url, params: params, useToken: true)
        .then((Map<String, dynamic> value) => {
              print("updateToCard"),
              if (value != null)
                {
                  result = value,
                }
              else
                {result = null}
            });
    return result;
  }

  //Product List
  Future<CartModel> getCartList({String url}) async {
    CartModel result = new CartModel();

    try {
      var value = await this.getData(url: url, useToken: true);
      if (value != null) {
        result = CartModel.fromJson(value["data"]);
      } else {
        result = null;
      }
    } catch (e) {
      print(e);
    }
    return result;
  }

  //Product List
  Future<CartModel> getCartListAndApplyCoupon({
    String url,
    Map<String, dynamic> params,
  }) async {
    CartModel result = new CartModel();

    //try {
    var value =
        await this.getData(url: url, queryParams: params, useToken: true);
    if (value != null) {
      result = CartModel.fromJson(value["data"]);
    } else {
      result = null;
    }
    // } catch (e) {
    //   print(e);
    // }
    return result;
  }
}
