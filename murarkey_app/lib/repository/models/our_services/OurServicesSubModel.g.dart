// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OurServicesSubModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OurServicesSubModel _$OurServicesSubModelFromJson(Map<String, dynamic> json) {
  return OurServicesSubModel(
    id: json['id'],
    name: json['name'],
    icon: json['icon'],
    child: (json['child'] as List)
        .map((e) => OurServicesSubSubModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OurServicesSubModelToJson(
        OurServicesSubModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'child': instance.child,
    };
