// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) {
  return BaseModel(
    status: json['status'] as int,
    success: json['success'] as bool,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$BaseModelToJson(BaseModel instance) => <String, dynamic>{
      'status': instance.status,
      'success': instance.success,
      'message': instance.message,
    };
