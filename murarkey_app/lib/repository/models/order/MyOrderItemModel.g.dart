// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyOrderItemModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrderItemModel _$MyOrderItemModelFromJson(Map<String, dynamic> json) {
  return MyOrderItemModel(
    id: json['id'] as int,
    qty: json['qty'] as int,
    image: json['image'] as String,
    caption: json['caption'] as String,
    name: json['name'] as String,
    price: json['price'],
    product_id: json['product_id'],
  );
}

Map<String, dynamic> _$MyOrderItemModelToJson(MyOrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'qty': instance.qty,
      'image': instance.image,
      'caption': instance.caption,
      'name': instance.name,
      'price': instance.price,
      'product_id': instance.product_id,
    };
