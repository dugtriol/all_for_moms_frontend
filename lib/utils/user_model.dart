import 'package:all_for_moms_frontend/domain/entity/user.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
