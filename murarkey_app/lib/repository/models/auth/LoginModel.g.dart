// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModel _$LoginModelFromJson(Map<String, dynamic> json) {
  return LoginModel(
    success: json['success'] as bool,
    status: json['status'] as int,
    error: json['error'] as String,
    token_type: json['token_type'] as String,
    access_token: json['access_token'] as String,
    user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LoginModelToJson(LoginModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'error': instance.error,
      'token_type': instance.token_type,
      'access_token': instance.access_token,
      'user': instance.user,
    };
