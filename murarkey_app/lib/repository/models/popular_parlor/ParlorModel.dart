import 'package:json_annotation/json_annotation.dart';

part 'ParlorModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 */

@JsonSerializable(nullable: false)
class ParlorModel {
  final int id;
  final String name;
  final String slug;
  final String address;
  final String about;

  final String category_id;
  final String featureImageUrl;
  final int featured;
  final int status;

  final String phone;
  final String mobile;
  final String email;
  final String website;

  final String facebook;
  final String instagram;
  final String twitter;
  final String youtube;

  final String deleted_at;

  ParlorModel({
    this.id,
    this.name,
    this.slug,
    this.address,
    this.about,
    this.category_id,
    this.featureImageUrl,
    this.featured,
    this.status,
    this.phone,
    this.mobile,
    this.email,
    this.website,
    this.facebook,
    this.instagram,
    this.twitter,
    this.youtube,
    this.deleted_at,
  });

  factory ParlorModel.fromJson(Map<String, dynamic> json) =>
      _$ParlorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParlorModelToJson(this);
}
