import 'dart:convert';
import 'dart:io';

import 'package:all_for_moms_frontend/domain/entity/user.dart';
import 'package:dio/dio.dart';

import '../auth/auth_token.dart';

class ApiClient {
  final client = Dio();
  final tokenModel = Token();
  static const _host = 'http://localhost:8080/api';

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  Future<User> getCurrentUser() async {
    String token = "";
    try {
      token = await tokenModel.getToken();
      print('Token: $token');
    } catch (e) {
      print(e);
    }

    final url = _makeUri('/user/get-current-user');
    final response = await client.get(url.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        }));

    final user = User.fromJson(response.data);
    return user;
  }

  Future<String> signIn(
      {required String username, required String password}) async {
    final url = _makeUri('/auth/sign-in');
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
    };

    final response = await client.post(url.toString(),
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: jsonEncode(parameters));

    return response.data['jwt'] as String;
  }

  Future<String> signUp({
    required String username,
    required String password,
    required String name,
    required String email,
  }) async {
    final url = _makeUri('/auth/sign-up');
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'name': name,
      'email': email
    };
    final response = await client.post(url.toString(),
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: jsonEncode(parameters));

    return response.data['jwt'] as String;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
