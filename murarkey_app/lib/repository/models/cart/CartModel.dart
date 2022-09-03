import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/content/ContentCartModel.dart';

part 'CartModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/20/2021.
 * https://stackoverflow.com/questions/53503644/map-a-json-string-into-an-item-model-in-flutter
 * flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 */

@JsonSerializable(nullable: false)
class CartModel {
  var total;
  var tax;
  var subTotal;
  var shippingAmount;
  final Map<String, ContentCartModel> content;
  CouponDetail couponDetail;
  var couponDiscountPrice;

  CartModel({
    this.total,
    this.tax,
    this.subTotal,
    this.shippingAmount,
    this.content,
    this.couponDetail,
    this.couponDiscountPrice,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);

  List<ContentCartModel> getContent() {
    var list = new List<ContentCartModel>();
    if (content != null) {
      Map data = content;

      data.forEach((key, value) {
        list.add(value);
      });
    }

    return list;
  }
}

//@JsonSerializable(nullable: false)
class CouponDetail {
  String coupon;
  List<String> couponFor;
  String discountType;
  String discount;

  CouponDetail({
    this.coupon,
    this.couponFor,
    this.discountType,
    this.discount,
  });

  // factory CouponDetail.fromJson(Map<String, dynamic> json) =>
  //     _$CouponDetailFromJson(json);
  //
  // Map<String, dynamic> toJson() => _$CouponDetailToJson(this);

  CouponDetail.fromJson(json) {
    if (json != null) {
      print("CouponDetail-----> ${json}");
      // coupon = json['coupon'];
      // couponFor = json['coupon_for'].cast<String>();
      // discountType = json['discount_type'];
      // discount = json['discount'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon'] = this.coupon;
    data['coupon_for'] = this.couponFor;
    data['discount_type'] = this.discountType;
    data['discount'] = this.discount;
    return data;
  }
}
