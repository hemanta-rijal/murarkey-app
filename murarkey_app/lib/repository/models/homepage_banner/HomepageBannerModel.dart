import 'package:json_annotation/json_annotation.dart';

part 'HomepageBannerModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/12/2021.
 * https://stackoverflow.com/questions/53503644/map-a-json-string-into-an-item-model-in-flutter
 * flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
 */

@JsonSerializable(nullable: false)
class HomepageBannerModel {
  final int id;
  final String position;
  final String name;
  final String image;
  final String imageUrl;
  final String link;

  HomepageBannerModel(
      {this.id,
      this.position,
      this.name,
      this.image,
      this.imageUrl,
      this.link});

  factory HomepageBannerModel.fromJson(Map<String, dynamic> json) =>
      _$HomepageBannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomepageBannerModelToJson(this);
}
