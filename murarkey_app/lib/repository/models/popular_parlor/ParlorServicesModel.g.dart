// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParlorServicesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParlorServicesModel _$ParlorServicesModelFromJson(Map<String, dynamic> json) {
  return ParlorServicesModel(
    id: json['id'] as int,
    title: json['title'] as String,
    slug: json['slug'] as String,
    duration: json['duration'] as String,
    icon_image: json['icon_image'] as String,
    featured_image: json['featured_image'] as String,
    short_description: json['short_description'] as String,
    description: json['description'] as String,
    service_charge: json['service_charge'] as int,
  );
}

Map<String, dynamic> _$ParlorServicesModelToJson(
        ParlorServicesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'duration': instance.duration,
      'icon_image': instance.icon_image,
      'featured_image': instance.featured_image,
      'short_description': instance.short_description,
      'description': instance.description,
      'service_charge': instance.service_charge,
    };
