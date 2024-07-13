import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String email;
  final String name;
  final String username;
  final String password;
  @JsonKey(name: 'date_of_birth')
  final DateTime dateOfBirth;

  User(
      {required this.dateOfBirth,
      required this.email,
      required this.name,
      required this.password,
      required this.username});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
