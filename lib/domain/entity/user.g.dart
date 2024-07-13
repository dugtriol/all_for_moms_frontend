// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
      email: json['email'] as String,
      name: json['name'] as String,
      password: json['password'] as String,
      username: json['username'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'username': instance.username,
      'password': instance.password,
      'date_of_birth': instance.dateOfBirth.toIso8601String(),
    };
