// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ServicesCategoryListsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServicesCategoryListsModel _$ServicesCategoryListsModelFromJson(
    Map<String, dynamic> json) {
  return ServicesCategoryListsModel(
    id: json['id'],
    title: json['title'],
    slug: json['slug'],
    duration: json['duration'],
    icon_image: json['icon_image'],
    featured_image: json['featured_image'],
    short_description: json['short_description'],
    description: json['description'],
    price: json['price'],
    discount_rates: json['discount_rates'],
    discount_type: json['discount_type'],
    price_after_discount: json['price_after_discount'],
    labels: json['labels'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$ServicesCategoryListsModelToJson(
        ServicesCategoryListsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'duration': instance.duration,
      'icon_image': instance.icon_image,
      'featured_image': instance.featured_image,
      'short_description': instance.short_description,
      'description': instance.description,
      'price': instance.price,
      'discount_rates': instance.discount_rates,
      'discount_type': instance.discount_type,
      'price_after_discount': instance.price_after_discount,
      'labels': instance.labels,
    };
