import 'package:json_annotation/json_annotation.dart';

part 'CategoryModel.g.dart';
/**
 * Created by Suman Prasad Neupane on 6/13/2021.
 */

@JsonSerializable(nullable: false)
class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String icon_url;
  final String image_url;

  CategoryModel({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.icon_url,
    this.image_url,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  CategoryModel forDrpDown() {
    return CategoryModel(
      id: id,
      name: name,
      slug: slug,
      description: null,
      icon_url: null,
      image_url: null,
    );
  }
}
