import 'package:json_annotation/json_annotation.dart';

part 'BrandModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 */

@JsonSerializable(nullable: false)
class BrandModel{
  final int id;
  final String name;
  final String image;
  final String caption;
  final String description;

  BrandModel({
    this.id,
    this.name,
    this.image,
    this.caption,
    this.description
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandModelToJson(this);
}