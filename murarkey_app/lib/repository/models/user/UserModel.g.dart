// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'] as int,
    name: json['name'] as String,
    role: json['role'] as String,
    email: json['email'] as String,
    phone: json['phone'] as String,
    profileImage: json['profileImage'] as String,
    joined_on: json['joined_on'] as String,
    billing_details: PaymentCardAddresModel.fromJson(
        json['billing_details'] as Map<String, dynamic>),
    shipment_details: PaymentCardAddresModel.fromJson(
        json['shipment_details'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'role': instance.role,
      'email': instance.email,
      'phone': instance.phone,
      'profileImage': instance.profileImage,
      'joined_on': instance.joined_on,
      'billing_details': instance.billing_details,
      'shipment_details': instance.shipment_details,
    };
