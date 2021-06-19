// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BrandModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandModel _$BrandModelFromJson(Map<String, dynamic> json) {
  return BrandModel(
    id: json['id'] as int,
    name: json['name'] as String,
    imageUrl: json['imageUrl'] as String,
    caption: json['caption'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$BrandModelToJson(BrandModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'caption': instance.caption,
      'description': instance.description,
    };
