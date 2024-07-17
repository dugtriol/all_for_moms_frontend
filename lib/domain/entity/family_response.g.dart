// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyResponse _$FamilyResponseFromJson(Map<String, dynamic> json) =>
    FamilyResponse(
      id: (json['id'] as num).toInt(),
      hosts: (json['hosts'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      members: (json['members'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FamilyResponseToJson(FamilyResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'members': instance.members.map((e) => e.toJson()).toList(),
      'hosts': instance.hosts.map((e) => e.toJson()).toList(),
    };
