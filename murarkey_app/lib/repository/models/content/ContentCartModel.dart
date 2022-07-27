import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/options/OptionModel.dart';

part 'ContentCartModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/20/2021.
 * https://stackoverflow.com/questions/53503644/map-a-json-string-into-an-item-model-in-flutter
 * flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 */

//  "rowId": "67b16f2c87d1aa39840273cdef46e20f",
//                 "id": 3,
//                 "name": "Natural Glow Kesar Face Cream",
//                 "qty": 49,
//                 "price": 150,
//                 "options": {
//                     "image": "http://newweb.murarkey.com/image/cache/200X200/smJNmiHvfNbwaHQxa91fEVB7TsC16y5jGzEKqGul.jpg"
//                 },
//                 "tax": 19.5,
//                 "subtotal": 7350,
//                 "doDiscount": null

@JsonSerializable(nullable: false)
class ContentCartModel {
  final String rowId;
  final int id;
  final String name;
  var qty;
  var price;
  final double tax;
  var subtotal;
  var doDiscount;
  var options;

  ContentCartModel({
    this.rowId,
    this.id,
    this.name,
    this.qty,
    this.price,
    this.tax,
    this.subtotal,
    this.doDiscount,
    this.options,
  });

  factory ContentCartModel.fromJson(Map<String, dynamic> json) =>
      _$ContentCartModelFromJson(json);

  Map<String, dynamic> toJson() => _$ContentCartModelToJson(this);
}
