import 'package:json_annotation/json_annotation.dart';
import 'package:murarkey_app/repository/models/base_model/BaseModel.dart';

part 'JoinProfessionalModel.g.dart';

/**
 * Created by Suman Prasad Neupane on 6/18/2021.
 */

@JsonSerializable(nullable: false)
class JoinProfessionalModel extends BaseModel{


  JoinProfessionalModel(){}

  factory JoinProfessionalModel.fromJson(Map<String, dynamic> json) =>
      _$JoinProfessionalModelFromJson(json);

  Map<String, dynamic> toJson() => _$JoinProfessionalModelToJson(this);

}