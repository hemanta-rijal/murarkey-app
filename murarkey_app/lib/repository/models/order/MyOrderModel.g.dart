// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyOrderModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrderModel _$MyOrderModelFromJson(Map<String, dynamic> json) {
  return MyOrderModel(
    id: json['id'] as int,
    user_id: json['user_id'] as int,
    code: json['code'] as String,
    status: json['status'] as String,
    order_date: json['order_date'] as String,
    updated_at: json['updated_at'] as String,
    payment_method: json['payment_method'] as String,
    remarks: json['remarks'] as String,
    shipping_charge: json['shipping_charge'],
    sub_total: json['sub_total'],
    tax: json['tax'],
    total: json['total'],
    items: OrderItem.fromJson(json['items'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MyOrderModelToJson(MyOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'code': instance.code,
      'status': instance.status,
      'order_date': instance.order_date,
      'updated_at': instance.updated_at,
      'payment_method': instance.payment_method,
      'remarks': instance.remarks,
      'shipping_charge': instance.shipping_charge,
      'sub_total': instance.sub_total,
      'tax': instance.tax,
      'total': instance.total,
      'items': instance.items,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem(
    products: (json['products'] as List)
        .map((e) => MyOrderItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    services: (json['services'] as List)
        .map((e) => MyOrderItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'products': instance.products,
      'services': instance.services,
    };
