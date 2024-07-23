// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_family_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyUpdateRequest _$FamilyUpdateRequestFromJson(Map<String, dynamic> json) =>
    FamilyUpdateRequest(
      hosts: (json['hosts_id'] as List<dynamic>)
          .map((e) => FamilyMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      members: (json['members_id'] as List<dynamic>)
          .map((e) => FamilyMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FamilyUpdateRequestToJson(
        FamilyUpdateRequest instance) =>
    <String, dynamic>{
      'members_id': instance.members.map((e) => e.toJson()).toList(),
      'hosts_id': instance.hosts.map((e) => e.toJson()).toList(),
    };
