import 'dart:convert';
import 'dart:io';

import 'package:all_for_moms_frontend/domain/entity/family_create.dart';
import 'package:all_for_moms_frontend/domain/entity/family_response.dart';
import 'package:all_for_moms_frontend/domain/entity/task_request.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:all_for_moms_frontend/domain/entity/update_family_request.dart';
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
      // print('Token: $token');
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

  Future<User> getUserById({required int id}) async {
    print("getUserIdByName");
    final Map<String, dynamic> datajson = {'id': id};
    final url = _makeUri('/user');
    final response = await client.post(
      url.toString(),
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(datajson),
    );
    User user = User.fromJson(response.data);
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
    String jwt = response.data['jwt'] as String;
    print(jwt);
    return jwt;
  }

  Future<String> signUp({
    required String username,
    required String password,
    required String name,
    required String email,
    required String dateOfBirth,
  }) async {
    final url = _makeUri('/auth/sign-up');
    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'date_of_birth': dateOfBirth,
    };
    final response = await client.post(url.toString(),
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: jsonEncode(parameters));

    return response.data['jwt'] as String;
  }

  Future<FamilyResponse> createFamily({required FamilyCreate familyOld}) async {
    print('createFamily');
    String token = "";
    try {
      token = await tokenModel.getToken();
      // print('Token: $token');
    } catch (e) {
      print(e);
    }
    final url = _makeUri('/family/create-family');
    print(familyOld.toJson());
    final response = await client.post(url.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        }),
        data: familyOld.toJson());
    print(response.data);
    FamilyResponse family = FamilyResponse.fromJson(response.data);
    return family;
  }

  Future<bool> isExistFamily() async {
    String token = "";
    try {
      token = await tokenModel.getToken();
      // print('Token: $token');
    } catch (e) {
      print(e);
    }
    final url = _makeUri('/family/is-exist-family');
    final response = await client.get(url.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        }));
    final bool isExist = response.data['exist'] as bool;
    print('isExist $isExist');
    return isExist;
  }

  Future<FamilyResponse> getFamilyByUserId() async {
    String token = "";
    try {
      token = await tokenModel.getToken();
      // print('Token: $token');
    } catch (e) {
      print(e);
    }
    final url = _makeUri('/family/get-family-by-user-id');
    final response = await client.get(url.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        }));
    FamilyResponse family = FamilyResponse.fromJson(response.data);
    return family;
  }

  Future<void> completeTask({required taskId}) async {
    String token = "";
    try {
      token = await tokenModel.getToken();
      // print('Token: $token');
    } catch (e) {
      print(e);
    }
    print(taskId);
    final url = _makeUri('/task/complete/$taskId');
    final response = await client.put(url.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        }));
  }

  Future<List<TaskResponse>> getTasksByTaskSetterId(
      {required int userId}) async {
    String token = "";
    try {
      token = await tokenModel.getToken();
      // print('Token: $token');
    } catch (e) {
      print(e);
    }

    print('getTasksByTaskSetterId');
    final url = _makeUri('/task/setter/$userId');

    final response = await client.get(url.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        }));
    final List<TaskResponse> tasks = List<TaskResponse>.from(
        response.data.map((e) => TaskResponse.fromJson(e)));

    return tasks;
  }

  Future<List<TaskResponse>> getTasksByTaskGetterId(
      {required int userId}) async {
    String token = "";
    try {
      token = await tokenModel.getToken();
      // print('Token: $token');
    } catch (e) {
      print(e);
    }

    print('getTasksByTaskGetterId');
    final url = _makeUri('/task/getter/$userId');

    final response = await client.get(url.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        }));
    final List<TaskResponse> tasks = List<TaskResponse>.from(
        response.data.map((e) => TaskResponse.fromJson(e)));

    return tasks;
  }

  Future<void> createTask({required TaskRequest task}) async {
    String token = "";
    try {
      token = await tokenModel.getToken();
      // print('Token: $token');
    } catch (e) {
      print(e);
    }
    final url = _makeUri('/task');
    final response = await client.post(
      url.toString(),
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token",
      }),
      data: task.toJson(),
    );
  }

  Future<int> getUserIdByName({required String name}) async {
    print("getUserIdByName");
    final Map<String, dynamic> datajson = {'username': name};
    final url = _makeUri('/user');
    final response = await client.post(
      url.toString(),
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      data: jsonEncode(datajson),
    );
    int id = response.data['id'];
    return id;
  }

  Future<FamilyResponse> addMemberOrHostToFamily(
      {required FamilyUpdateRequest family}) async {
    print('AddMemberOrHostToFamily');
    String token = "";
    try {
      token = await tokenModel.getToken();
      // print('Token: $token');
    } catch (e) {
      print(e);
    }
    final url = _makeUri('/family/update-family');
    print(family.toJson());
    final response = await client.put(url.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        }),
        data: family.toJson());
    print(response.data);
    FamilyResponse familyResp = FamilyResponse.fromJson(response.data);
    return familyResp;
  }

  Future<FamilyResponse> deleteMemberOrHostToFamily(
      {required FamilyUpdateRequest family}) async {
    print('DeleteMemberOrHostToFamily');
    String token = "";
    try {
      token = await tokenModel.getToken();
      // print('Token: $token');
    } catch (e) {
      print(e);
    }
    final url = _makeUri('/family/delete-host');
    print(family.toJson());
    final response = await client.delete(url.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $token",
        }),
        data: family.toJson());
    print(response.data);
    FamilyResponse familyResp = FamilyResponse.fromJson(response.data);
    return familyResp;
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
