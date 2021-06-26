// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CountryModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) {
  return CountryModel(
    id: json['id'] as int,
    sortname: json['sortname'] as String,
    name: json['name'] as String,
    phonecode: json['phonecode'],
  );
}

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sortname': instance.sortname,
      'name': instance.name,
      'phonecode': instance.phonecode,
    };
