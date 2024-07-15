import 'package:json_annotation/json_annotation.dart';

part 'family_member.g.dart';

@JsonSerializable()
class FamilyMember {
  @JsonKey(name: "user_id")
  final int userId;

  @JsonKey(name: "member_type_id")
  final int typeId;

  FamilyMember({
    required this.userId,
    required this.typeId,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyMemberToJson(this);
}
