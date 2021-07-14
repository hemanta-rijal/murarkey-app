// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OurServicesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OurServicesModel _$OurServicesModelFromJson(Map<String, dynamic> json) {
  return OurServicesModel(
    id: json['id'],
    name: json['name'],
    icon: json['icon'],
    child: (json['child'] as List)
        .map((e) => OurServicesSubModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OurServicesModelToJson(OurServicesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'child': instance.child,
    };
