import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/brands/BrandModel.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'package:murarkey_app/repository/models/review/ReviewModel.dart';

part 'ProductDetailModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 */

@JsonSerializable(nullable: true)
class ProductDetailModel {
  final int id;
  final String name;
  final String slug;
  final String details;
  final String unit_type;
  BrandModel brand;
  final int price;
  final int price_after_discount;
  var discount_rate;
  final List<HomepageBannerModel> images;
  final String sku;
  var tags_array;
  var sub_category_array;
  final CategoryModel category;
  List<String> skin_type;
  List<String> skin_concern;
  List<String> product_type;
  Map<String, dynamic> attribute;
  bool reviewable;
  List<ReviewModel> reviews;

  //final List<dynamic> tags;
  //final List<dynamic> sub_category;

  ProductDetailModel({
    this.id,
    this.name,
    this.slug,
    this.details,
    this.unit_type,
    this.brand,
    this.price,
    this.price_after_discount,
    this.discount_rate,
    this.images,
    this.sku,
    this.category,
    this.tags_array,
    this.sub_category_array,
    this.skin_type,
    this.skin_concern,
    this.product_type,
    this.attribute,
    this.reviewable,
    this.reviews,
  });

  dynamic getKeyTag(String key) {
    if (key == "skin_type") {
      return skin_type;
    } else if (key == "skin_concern") {
      return skin_concern;
    } else if (key == "product_type") {
      return product_type;
    }

    return [];
  }

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);
}
