import 'package:all_for_moms_frontend/domain/entity/family_member.dart';
import 'package:all_for_moms_frontend/domain/entity/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'family_response.g.dart';

@JsonSerializable(explicitToJson: true)
class FamilyResponse {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "members")
  final List<User> members;

  @JsonKey(name: "hosts")
  final List<User> hosts;

  FamilyResponse({
    required this.id,
    required this.hosts,
    required this.members,
  });

  factory FamilyResponse.fromJson(Map<String, dynamic> json) =>
      _$FamilyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FamilyResponseToJson(this);
}
