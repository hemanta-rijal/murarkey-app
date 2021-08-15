import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/content/ContentCartModel.dart';

part 'CartModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/20/2021.
 * https://stackoverflow.com/questions/53503644/map-a-json-string-into-an-item-model-in-flutter
 * flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 */

@JsonSerializable(nullable: false)
class CartModel {
  var total;
  var tax;
  var subTotal;
  var shippingAmount;
  final Map<String, ContentCartModel> content;

  CartModel(
      {this.total, this.tax, this.subTotal, this.shippingAmount, this.content});

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);

  List<ContentCartModel> getContent() {
    var list = new List<ContentCartModel>();
    if (content != null) {
      Map data = content;

      data.forEach((key, value) {
        list.add(value);
      });
    }

    return list;
  }
}
