// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WalletModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletModel _$WalletModelFromJson(Map<String, dynamic> json) {
  return WalletModel(
    user_id: json['user_id'],
    transaction_type: json['transaction_type'],
    payment_method: json['payment_method'],
    amount: json['amount'],
    status: json['status'],
    total_amount: json['total_amount'],
    loadedOn: json['loadedOn'],
    remarks: Remarks.fromJson(json['remarks'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WalletModelToJson(WalletModel instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'transaction_type': instance.transaction_type,
      'payment_method': instance.payment_method,
      'amount': instance.amount,
      'status': instance.status,
      'total_amount': instance.total_amount,
      'loadedOn': instance.loadedOn,
      'remarks': instance.remarks,
    };

Remarks _$RemarksFromJson(Map<String, dynamic> json) {
  return Remarks(
    logo: json['logo'],
    text: json['text'],
  );
}

Map<String, dynamic> _$RemarksToJson(Remarks instance) => <String, dynamic>{
      'logo': instance.logo,
      'text': instance.text,
    };
