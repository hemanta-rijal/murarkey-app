import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 */

@JsonSerializable(nullable: false)
class UserModel{
  final int id;
  final String name;
  final String role;
  final String email;
  final String phone;
  final String profileImage;
  final String joined_on;

  UserModel({
    this.id,
    this.name,
    this.role,
    this.email,
    this.phone,
    this.profileImage,
    this.joined_on
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}