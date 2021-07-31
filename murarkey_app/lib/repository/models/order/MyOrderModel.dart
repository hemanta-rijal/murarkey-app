import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/order/MyOrderItemModel.dart';

part 'MyOrderModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 7/23/2021.
 * flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 */

@JsonSerializable(nullable: false)
class MyOrderModel {
  final int id;
  final int user_id;
  final String code;
  final String status;
  final String order_date;
  final String updated_at;
  final String payment_method;
  final String remarks;
  var shipping_charge;
  var sub_total;
  var tax;
  var total;
  OrderItem items;

  MyOrderModel(
      {this.id,
      this.user_id,
      this.code,
      this.status,
      this.order_date,
      this.updated_at,
      this.payment_method,
      this.remarks,
      this.shipping_charge,
      this.sub_total,
      this.tax,
      this.total,
      this.items});

  factory MyOrderModel.fromJson(Map<String, dynamic> json) =>
      _$MyOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderModelToJson(this);
}

@JsonSerializable(nullable: false)
class OrderItem {
  List<MyOrderItemModel> products;
  List<MyOrderItemModel> services;

  OrderItem({this.products, this.services});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
