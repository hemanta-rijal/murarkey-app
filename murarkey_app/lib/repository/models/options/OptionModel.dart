import 'package:json_annotation/json_annotation.dart';

part 'OptionModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/20/2021.
 * https://stackoverflow.com/questions/53503644/map-a-json-string-into-an-item-model-in-flutter
 * flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 */

@JsonSerializable(nullable: false)
class OptionModel {
  final String image;

  OptionModel({this.image});

  factory OptionModel.fromJson(Map<String, dynamic> json) =>
      _$OptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionModelToJson(this);
}
