import 'package:json_annotation/json_annotation.dart';

part 'MyOrderItemModel.g.dart';

/**
 * Created by Suman Prasad Neupane on7/24/2021.
 * flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 */


@JsonSerializable(nullable: false)
class MyOrderItemModel {
  final int id;
  final int qty;
  final String image;
  final String caption;
  final String name;
  var price;
  var product_id;

  MyOrderItemModel(
      {this.id,
        this.qty,
        this.image,
        this.caption,
        this.name,
        this.price,
        this.product_id});

  factory MyOrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$MyOrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyOrderItemModelToJson(this);
}