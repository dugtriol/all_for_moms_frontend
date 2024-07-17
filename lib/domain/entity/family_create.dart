import 'package:all_for_moms_frontend/domain/entity/family_member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'family_create.g.dart';

@JsonSerializable(explicitToJson: true)
class FamilyCreate {
  @JsonKey(name: "members_id")
  final List<FamilyMember> membersId;

  @JsonKey(name: "type_id_for_host")
  final int typeIdForHost;

  FamilyCreate({
    required this.membersId,
    required this.typeIdForHost,
  });

  factory FamilyCreate.fromJson(Map<String, dynamic> json) =>
      _$FamilyCreateFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyCreateToJson(this);
}
