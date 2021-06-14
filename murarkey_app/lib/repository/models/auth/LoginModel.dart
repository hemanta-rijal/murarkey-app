import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/user/UserModel.dart';

part 'LoginModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 */


@JsonSerializable(nullable: false)
class LoginModel{
  final bool success;
  final int status;
  final String token_type;
  final String access_token;
  final UserModel user;

  LoginModel({
    this.success,
    this.status,
    this.token_type,
    this.access_token,
    this.user
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}