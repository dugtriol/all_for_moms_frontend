import 'package:all_for_moms_frontend/domain/entity/family_member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_family_request.g.dart';

@JsonSerializable(explicitToJson: true)
class FamilyUpdateRequest {
  @JsonKey(name: "members_id")
  final List<FamilyMember> members;

  @JsonKey(name: "hosts_id")
  final List<FamilyMember> hosts;

  FamilyUpdateRequest({
    required this.hosts,
    required this.members,
  });

  factory FamilyUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$FamilyUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyUpdateRequestToJson(this);
}
