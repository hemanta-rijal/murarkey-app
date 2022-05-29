import 'package:json_annotation/json_annotation.dart';

part 'ServiceCategoryModel.g.dart';
/**
 * Created by Suman Prasad Neupane on 6/13/2021.
 */

@JsonSerializable(nullable: false)
class ServiceCategoryModel {
  final int id;
  final String name;
  final String slug;
  final String icon;

  ServiceCategoryModel({
    this.id,
    this.name,
    this.slug,
    this.icon,
  });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceCategoryModelToJson(this);

  ServiceCategoryModel forDrpDown() {
    return ServiceCategoryModel(
      id: id,
      name: name,
      slug: slug,
      icon: null,
    );
  }
}
