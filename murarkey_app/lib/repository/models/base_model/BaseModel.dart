import 'package:json_annotation/json_annotation.dart';

part 'BaseModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/18/2021.
 */

@JsonSerializable(nullable: false)
class BaseModel {
  final int status;
  final bool success;
  final String message;

  BaseModel({
    this.status,
    this.success,
    this.message,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}
