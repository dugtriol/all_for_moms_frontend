import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserModel extends ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
  }

  final _apiClient = ApiClient();
  User? _user;

  User? get user => _user;

  String? get type {
    if (_user!.type!.type.toString().isEmpty ||
        _user!.type!.type.toString() == null) {
      return "Нет данных";
    }
    return _user!.type!.type;
  }

  int get id {
    if (_user?.id == null) {
      return -1;
    }
    return _user!.id!;
  }

  String get name {
    if (_user?.name == null) {
      return 'Нет данных';
    }
    return _user!.name;
  }

  String get email {
    if (_user?.email == null) {
      return 'Нет данных';
    }
    return _user!.email;
  }

  String get username {
    if (_user?.username == null) {
      return 'Нет данных';
    }
    return _user!.username;
  }

  String get dateOfBirth {
    if (_user?.dateOfBirth == null) {
      return 'Нет данных';
    }
    return DateFormat('yyyy-MM-dd').format(_user!.dateOfBirth!);
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  Future<void> deleteUserById(int id) async {
    try {
      await _apiClient.deleteUser(id: id);
    } catch (e) {
      print(e.toString());
    }
  }
}
