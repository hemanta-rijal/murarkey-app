import 'package:murarkey_app/repository/api_call/ApiRequest.dart';
import 'package:murarkey_app/repository/models/cart/CartModel.dart';

/**
 * Created by Suman Prasad Neupane on 7/4/2021.
 */

class WishlistRequestApi extends ApiRequest{

  //Add to Wishlis
  Future<dynamic> addToWishlist({String url, Map<String, dynamic> params}) async {
    var result;

    await this
        .postData(url: url, params: params, useToken: true)
        .then((Map<String, dynamic> value) => {
      print("addToWishlist"),
      if (value != null)
        {
          result = value,
        }
      else
        {result = null}
    });
    return result;
  }

  //GET All Wishlist
  Future<CartModel> getAllWishList({String url}) async {
    CartModel result = new CartModel();

    await this
        .getData(url: url, useToken: true)
        .then((Map<String, dynamic> value) => {
      print("CartModel list"),
      print(value),
      if (value != null)
        {
          result = CartModel.fromJson(value["data"]),
        }
      else
        {result = null}
    });
    return result;
  }
}