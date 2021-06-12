// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomepageBannerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomepageBannerModel _$HomepageBannerModelFromJson(Map<String, dynamic> json) {
  return HomepageBannerModel(
    id: json['id'] as int,
    position: json['position'] as String,
    name: json['name'] as String,
    image: json['image'] as String,
    imageUrl: json['imageUrl'] as String,
    link: json['link'] as String,
  );
}

Map<String, dynamic> _$HomepageBannerModelToJson(
        HomepageBannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'name': instance.name,
      'image': instance.image,
      'imageUrl': instance.imageUrl,
      'link': instance.link,
    };
