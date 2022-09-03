// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) {
  return CartModel(
    total: json['total'],
    tax: json['tax'],
    subTotal: json['subTotal'],
    shippingAmount: json['shippingAmount'],
    content: (json['content'] as Map<String, dynamic>).map(
      (k, e) =>
          MapEntry(k, ContentCartModel.fromJson(e as Map<String, dynamic>)),
    ),
    couponDetail: CouponDetail.fromJson(json['couponDetail']),
    couponDiscountPrice: json['couponDiscountPrice'],
  );
}

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'total': instance.total,
      'tax': instance.tax,
      'subTotal': instance.subTotal,
      'shippingAmount': instance.shippingAmount,
      'content': instance.content,
      'couponDetail': instance.couponDetail,
      'couponDiscountPrice': instance.couponDiscountPrice,
    };
