import 'package:json_annotation/json_annotation.dart';

part 'PaymentCardAddresModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 */

@JsonSerializable(nullable: true)
class PaymentCardAddresModel{
  final String state;
  final String city;
  final String specific_address;
  final String country;
  final String zip;

  PaymentCardAddresModel({
    this.state,
    this.city,
    this.specific_address,
    this.country,
    this.zip,
  });

  factory PaymentCardAddresModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentCardAddresModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentCardAddresModelToJson(this);
}