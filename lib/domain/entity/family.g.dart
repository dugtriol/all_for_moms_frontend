// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Family _$FamilyFromJson(Map<String, dynamic> json) => Family(
      membersId: (json['members_id'] as List<dynamic>)
          .map((e) => FamilyMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      typeIdForHost: (json['type_id_for_host'] as num).toInt(),
    );

Map<String, dynamic> _$FamilyToJson(Family instance) => <String, dynamic>{
      'members_id': instance.membersId.map((e) => e.toJson()).toList(),
      'type_id_for_host': instance.typeIdForHost,
    };
