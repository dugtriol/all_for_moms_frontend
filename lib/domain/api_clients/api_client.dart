import 'dart:convert';
import 'dart:io';

import 'package:all_for_moms_frontend/domain/entity/user.dart';
import 'package:dio/dio.dart';

import '../auth/auth_token.dart';

class ApiClient {
  final client = Dio();
  final tokenModel = Token();
  static const _host = 'http://localhost:8080/api';
  // Map<String, String> get headers => {
  //       "Content-Type": "application/json",
  //       "Accept": "application/json",
  //       "Authorization": "Bearer ${Token().getToken()}",
  //     };

  Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
    final uri = Uri.parse('$_host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    } else {
      return uri;
    }
  }

  // Future<User> getUser() async {
  //   final json = await get('http://localhost:8080/api/user');

  //   final user = json
  //       .map((dynamic e) => User.fromJson(e as Map<String, dynamic>))
  //       .toList();

  //   return user;
  // }

  // Future<dynamic> get(String url_string) async {
  //   final url = Uri.parse(url_string);
  //   final request = await client.getUrl(url);
  //   final response = await request.close();

  //   final jsonStrings = await response.transform(utf8.decoder).toList();
  //   final jsonString = jsonStrings.join();
  //   final json = jsonDecode(jsonString);
  //   return json;
  // }

  Future<User> getCurrentUser() async {
    String token = "";
    try {
      token = await tokenModel.getToken();
      print('Token: $token');
    } catch (e) {
      print(e);
    }

    print('getCurrentUser');
    final url = _makeUri('/user/get-current-user');
    final response = await client.get(url.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        }));
    //request.write(headers);
    // request.headers.set(HttpHeaders.contentTypeHeader, "application/json");
    // request.headers.set(HttpHeaders.authorizationHeader, token);

    // final response = await request.close();

    // final json = (await response.jsonDecode()) as Map<String, dynamic>;
    final user = User.fromJson(response.data);
    print(user.email);
    print(user.dateOfBirth);
    print(user.username);
    return user;
  }

  // Future<User> getUserByUsername({required String username}) async {
  //   print('getUserByUsername');
  //   final url = _makeUri('/user');
  //   final parameters = <String, dynamic>{
  //     'username': username,
  //   };
  //   final request = await client.postUrl(url);
  //   request.headers.contentType = ContentType.json;
  //   request.write(jsonEncode(parameters));
  //   final response = await request.close();

  //   final json = (await response.jsonDecode()) as Map<String, dynamic>;
  //   final user = User.fromJson(json);
  //   print(user.email);
  //   print(user.dateOfBirth);
  //   print(user.username);
  //   return user;
  // }

  Future<String> signIn(
      {required String username, required String password}) async {
    final url = _makeUri('/auth/sign-in');
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
    };
    // final request = await client.postUrl(url);
    // request.headers.contentType = ContentType.json;
    // request.write(jsonEncode(parameters));
    // final response = await request.close();

    final response = await client.post(url.toString(),
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: jsonEncode(parameters));
    // final json = (await response.data.jsonDecode()) as Map<String, dynamic>;

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
    // request.headers.contentType = ContentType.json;
    // request.write(jsonEncode(parameters));
    // final response = await request.close();

    // final json = (await response.data.jsonDecode()) as Map<String, dynamic>;

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
