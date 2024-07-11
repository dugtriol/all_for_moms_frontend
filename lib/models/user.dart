import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  String name;
  String email;
  String username;
  String password;

  User(this.name, this.email, this.password, this.username);
}
