// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ServiceCategoryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceCategoryModel _$ServiceCategoryModelFromJson(Map<String, dynamic> json) {
  return ServiceCategoryModel(
    id: json['id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String,
    icon: json['icon'] as String,
  );
}

Map<String, dynamic> _$ServiceCategoryModelToJson(
        ServiceCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'icon': instance.icon,
    };
