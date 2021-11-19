import 'package:json_annotation/json_annotation.dart';

part 'ParlorServicesModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 */

@JsonSerializable(nullable: false)
class ParlorServicesModel {
  final int id;
  final String title;
  final String slug;
  final String duration;
  final String icon_image;
  final String featured_image;
  final String short_description;
  final String description;
  final int service_charge;

  ParlorServicesModel({
    this.id,
    this.title,
    this.slug,
    this.duration,
    this.icon_image,
    this.featured_image,
    this.short_description,
    this.description,
    this.service_charge,
  });


  factory ParlorServicesModel.fromJson(Map<String, dynamic> json) =>
      _$ParlorServicesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParlorServicesModelToJson(this);
}