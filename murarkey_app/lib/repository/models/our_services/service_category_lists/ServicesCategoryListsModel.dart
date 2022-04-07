import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/homepage_banner/HomepageBannerModel.dart';
import 'package:murarkey_app/repository/models/review/ReviewModel.dart';

part 'ServicesCategoryListsModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 7/14/2021.
 * https://stackoverflow.com/questions/53503644/map-a-json-string-into-an-item-model-in-flutter
 * flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 */

@JsonSerializable(nullable: false)
class ServicesCategoryListsModel {
  var id;
  var title;
  var slug;
  var duration;
  var icon_image;
  var featured_image;
  var short_description;
  var description;
  var price;
  var discount_rates;
  var discount_type;
  var price_after_discount;
  Map<String, dynamic> labels;
  bool reviewable;
  List<ReviewModel> reviews;
  List<HomepageBannerModel> images;

  ServicesCategoryListsModel({
    this.id,
    this.title,
    this.slug,
    this.duration,
    this.icon_image,
    this.featured_image,
    this.short_description,
    this.description,
    this.price,
    this.discount_rates,
    this.discount_type,
    this.price_after_discount,
    this.labels,
    this.reviewable,
    this.reviews,
    this.images,
  });

  factory ServicesCategoryListsModel.fromJson(Map<String, dynamic> json) =>
      _$ServicesCategoryListsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesCategoryListsModelToJson(this);
}
