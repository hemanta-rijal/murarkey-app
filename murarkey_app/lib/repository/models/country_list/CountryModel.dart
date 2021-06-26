import 'package:json_annotation/json_annotation.dart';

part 'CountryModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/26/2021.
 * flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 */

@JsonSerializable(nullable: false)
class CountryModel {
  final int id;
  final String sortname;
  final String name;
  var phonecode;

  CountryModel({
    this.id,
    this.sortname,
    this.name,
    this.phonecode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
