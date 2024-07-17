import 'package:all_for_moms_frontend/domain/entity/user.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  String? get type {
    if (_user!.type!.type.toString().isEmpty ||
        _user!.type!.type.toString() == null) {
      return "Нет данных";
    }
    return _user!.type!.type;
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
