import 'package:json_annotation/json_annotation.dart';

part 'OurServicesSubSubModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 7/8/2021.
 * https://stackoverflow.com/questions/53503644/map-a-json-string-into-an-item-model-in-flutter
 * flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 */

@JsonSerializable(nullable: false)
class OurServicesSubSubModel{
  var id;
  var name;
  var icon;

  OurServicesSubSubModel({
    this.id,
    this.name,
    this.icon,
  });

  factory OurServicesSubSubModel.fromJson(Map<String, dynamic> json) =>
      _$OurServicesSubSubModelFromJson(json);

  Map<String, dynamic> toJson() => _$OurServicesSubSubModelToJson(this);
}