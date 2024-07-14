import 'package:json_annotation/json_annotation.dart';
import 'type.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final int? id;
  final String email;
  final String name;
  final String username;
  final String? password;
  @JsonKey(name: 'date_of_birth', fromJson: _parseDateFromString)
  final DateTime? dateOfBirth;
  final Type? type;

  User(
      {required this.dateOfBirth,
      required this.email,
      required this.name,
      required this.password,
      required this.username,
      this.id,
      this.type});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  static DateTime? _parseDateFromString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return null;
    return DateTime.tryParse(rawDate);
  }

  // static Type? _parseTypeFromString(String? rawType) {
  //   if (rawType == null || rawType.isEmpty) return null;
  //   return Type(type: rawType);
  // }

  // static String? _parseTypeToJson(Type? rawType) {
  //   if (rawType!.type.isEmpty || rawType.type == null) {
  //     return null;
  //   }
  //   return rawType.type;
  // }
}
