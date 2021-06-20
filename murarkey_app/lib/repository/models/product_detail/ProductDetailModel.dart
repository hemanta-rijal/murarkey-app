import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/category/CategoryModel.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';

part 'ProductDetailModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 */

@JsonSerializable(nullable: false)
class ProductDetailModel {
  final int id;
  final String name;
  final String slug;
  final String details;
  final String unit_type;
  final int price;
  final int price_after_discount;
  final List<HomepageBannerModel> images;
  final int sku;
  final CategoryModel category;

  //final List<dynamic> tags;
  //final List<dynamic> sub_category;

  ProductDetailModel({
    this.id,
    this.name,
    this.slug,
    this.details,
    this.unit_type,
    this.price,
    this.price_after_discount,
    this.images,
    this.sku,
    this.category
    //this.tags,
    //this.sub_category
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);
}
