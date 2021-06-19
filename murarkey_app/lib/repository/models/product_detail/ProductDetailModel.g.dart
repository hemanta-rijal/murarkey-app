// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailModel _$ProductDetailModelFromJson(Map<String, dynamic> json) {
  return ProductDetailModel(
    id: json['id'] as int,
    name: json['name'] as String,
    slug: json['slug'] as String,
    details: json['details'] as String,
    unit_type: json['unit_type'] as String,
    price: json['price'] as int,
    price_after_discount: json['price_after_discount'] as int,
    images: (json['images'] as List)
        .map((e) => HomepageBannerModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'details': instance.details,
      'unit_type': instance.unit_type,
      'price': instance.price,
      'price_after_discount': instance.price_after_discount,
      'images': instance.images,
    };
