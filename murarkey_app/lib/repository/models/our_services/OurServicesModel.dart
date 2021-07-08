import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/our_services/OurServicesSubModel.dart';

part 'OurServicesModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 7/8/2021.
 * https://stackoverflow.com/questions/53503644/map-a-json-string-into-an-item-model-in-flutter
 * flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 */

@JsonSerializable(nullable: false)
class OurServicesModel{
  var id;
  var name;
  var icon;
  List<OurServicesSubModel> services;

  OurServicesModel({
    this.id,
    this.name,
    this.icon,
    this.services
  });

  factory OurServicesModel.fromJson(Map<String, dynamic> json) =>
      _$OurServicesModelFromJson(json);

  Map<String, dynamic> toJson() => _$OurServicesModelToJson(this);
}