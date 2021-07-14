import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/payment_card_address/PaymentCardAddresModel.dart';

// part 'WalletModel.g.dart';
//
// /**
//  * Created by Suman Prasad Neupane on 7/13/2021.
//  */
//
// @JsonSerializable(nullable: false)
// class WalletModel{
//   final int id;
//   final String name;
//   final String role;
//   final String email;
//   final String phone;
//   final String profileImage;
//   final String joined_on;
//   final PaymentCardAddresModel billing_details;
//   final PaymentCardAddresModel shipment_details;
//
//   WalletModel({
//     this.id,
//     this.name,
//     this.role,
//     this.email,
//     this.phone,
//     this.profileImage,
//     this.joined_on,
//     this.billing_details,
//     this.shipment_details
//   });
//
//   factory WalletModel.fromJson(Map<String, dynamic> json) =>
//       _$WalletModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$WalletModelToJson(this);
// }