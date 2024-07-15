import 'package:all_for_moms_frontend/domain/entity/family_member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'family.g.dart';

@JsonSerializable(explicitToJson: true)
class Family {
  @JsonKey(name: "members_id")
  final List<FamilyMember> membersId;

  @JsonKey(name: "type_id_for_host")
  final int typeIdForHost;

  Family({
    required this.membersId,
    required this.typeIdForHost,
  });

  factory Family.fromJson(Map<String, dynamic> json) => _$FamilyFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyToJson(this);
}
