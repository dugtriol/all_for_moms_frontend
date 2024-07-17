// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyCreate _$FamilyCreateFromJson(Map<String, dynamic> json) => FamilyCreate(
      membersId: (json['members_id'] as List<dynamic>)
          .map((e) => FamilyMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      typeIdForHost: (json['type_id_for_host'] as num).toInt(),
    );

Map<String, dynamic> _$FamilyCreateToJson(FamilyCreate instance) =>
    <String, dynamic>{
      'members_id': instance.membersId.map((e) => e.toJson()).toList(),
      'type_id_for_host': instance.typeIdForHost,
    };
