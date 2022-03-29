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
    brand: json['brand'] == null
        ? null
        : BrandModel.fromJson(json['brand'] as Map<String, dynamic>),
    price: json['price'] as int,
    price_after_discount: json['price_after_discount'] as int,
    images: (json['images'] as List)
        ?.map((e) => e == null
            ? null
            : HomepageBannerModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    sku: json['sku'] as String,
    category: json['category'] == null
        ? null
        : CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
    tags_array: json['tags_array'],
    sub_category_array: json['sub_category_array'],
    skin_type: (json['skin_type'] as List)?.map((e) => e as String)?.toList(),
    skin_concern:
        (json['skin_concern'] as List)?.map((e) => e as String)?.toList(),
    product_type:
        (json['product_type'] as List)?.map((e) => e as String)?.toList(),
    attribute: json['attribute'] as Map<String, dynamic>,
    reviewable: json['reviewable'] as bool,
    reviews: (json['reviews'] as List)
        ?.map((e) =>
            e == null ? null : ReviewModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'details': instance.details,
      'unit_type': instance.unit_type,
      'brand': instance.brand,
      'price': instance.price,
      'price_after_discount': instance.price_after_discount,
      'images': instance.images,
      'sku': instance.sku,
      'tags_array': instance.tags_array,
      'sub_category_array': instance.sub_category_array,
      'category': instance.category,
      'skin_type': instance.skin_type,
      'skin_concern': instance.skin_concern,
      'product_type': instance.product_type,
      'attribute': instance.attribute,
      'reviewable': instance.reviewable,
      'reviews': instance.reviews,
    };
