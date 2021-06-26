// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaymentCardAddresModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentCardAddresModel _$PaymentCardAddresModelFromJson(
    Map<String, dynamic> json) {
  return PaymentCardAddresModel(
    state: json['state'] as String,
    city: json['city'] as String,
    specific_address: json['specific_address'] as String,
    country: json['country'] as String,
    zip: json['zip'] as String,
  );
}

Map<String, dynamic> _$PaymentCardAddresModelToJson(
        PaymentCardAddresModel instance) =>
    <String, dynamic>{
      'state': instance.state,
      'city': instance.city,
      'specific_address': instance.specific_address,
      'country': instance.country,
      'zip': instance.zip,
    };
