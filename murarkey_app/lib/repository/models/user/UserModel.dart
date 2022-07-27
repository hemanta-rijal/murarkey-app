import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/payment_card_address/PaymentCardAddresModel.dart';

part 'UserModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 */

@JsonSerializable(nullable: false)
class UserModel{
  int id;
  String name;
  String first_name;
  String last_name;
  String role;
  String email;
  String phone;
  String profileImage;
  String joined_on;
  PaymentCardAddresModel billing_details;
  PaymentCardAddresModel shipment_details;
  var emailVerification;
  var phoneVerification;

  UserModel({
    this.id,
    this.name,
    this.first_name,
    this.last_name,
    this.role,
    this.email,
    this.phone,
    this.profileImage,
    this.joined_on,
    this.emailVerification,
    this.phoneVerification,
    this.billing_details,
    this.shipment_details
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}