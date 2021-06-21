// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContentCartModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentCartModel _$ContentCartModelFromJson(Map<String, dynamic> json) {
  return ContentCartModel(
    rowId: json['rowId'] as String,
    id: json['id'] as int,
    name: json['name'] as String,
    qty: json['qty'],
    price: json['price'] as int,
    tax: (json['tax'] as num).toDouble(),
    subtotal: json['subtotal'] as int,
    doDiscount: json['doDiscount'],
    options: json['options'],
  );
}

Map<String, dynamic> _$ContentCartModelToJson(ContentCartModel instance) =>
    <String, dynamic>{
      'rowId': instance.rowId,
      'id': instance.id,
      'name': instance.name,
      'qty': instance.qty,
      'price': instance.price,
      'tax': instance.tax,
      'subtotal': instance.subtotal,
      'doDiscount': instance.doDiscount,
      'options': instance.options,
    };
