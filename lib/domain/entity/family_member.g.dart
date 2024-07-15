// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FamilyMember _$FamilyMemberFromJson(Map<String, dynamic> json) => FamilyMember(
      userId: (json['user_id'] as num).toInt(),
      typeId: (json['member_type_id'] as num).toInt(),
    );

Map<String, dynamic> _$FamilyMemberToJson(FamilyMember instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'member_type_id': instance.typeId,
    };
