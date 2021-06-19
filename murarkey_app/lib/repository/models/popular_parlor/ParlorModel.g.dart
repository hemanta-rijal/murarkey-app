// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParlorModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParlorModel _$ParlorModelFromJson(Map<String, dynamic> json) {
  return ParlorModel(
    id: json['id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String,
    address: json['address'] as String,
    about: json['about'] as String,
    category_id: json['category_id'] as String,
    featureImageUrl: json['featureImageUrl'] as String,
    featured: json['featured'] as int,
    status: json['status'] as int,
    phone: json['phone'] as String,
    mobile: json['mobile'] as String,
    email: json['email'] as String,
    website: json['website'] as String,
    facebook: json['facebook'] as String,
    instagram: json['instagram'] as String,
    twitter: json['twitter'] as String,
    youtube: json['youtube'] as String,
    deleted_at: json['deleted_at'] as String,
  );
}

Map<String, dynamic> _$ParlorModelToJson(ParlorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'address': instance.address,
      'about': instance.about,
      'category_id': instance.category_id,
      'featureImageUrl': instance.featureImageUrl,
      'featured': instance.featured,
      'status': instance.status,
      'phone': instance.phone,
      'mobile': instance.mobile,
      'email': instance.email,
      'website': instance.website,
      'facebook': instance.facebook,
      'instagram': instance.instagram,
      'twitter': instance.twitter,
      'youtube': instance.youtube,
      'deleted_at': instance.deleted_at,
    };
