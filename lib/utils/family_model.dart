import 'package:all_for_moms_frontend/domain/entity/family_response.dart';
import 'package:all_for_moms_frontend/domain/entity/user.dart';
import 'package:flutter/material.dart';

class FamilyModel extends ChangeNotifier {
  FamilyResponse? _family;

  FamilyResponse? get family => _family;

  List<User>? get members {
    if (_family == null || _family!.members.isEmpty) {
      return null;
    }
    return _family?.members;
  }

  List<User>? get hosts {
    if (_family == null || _family!.hosts.isEmpty) {
      return null;
    }
    return _family?.hosts;
  }

  void setFamily(FamilyResponse family) {
    _family = family;
    notifyListeners();
  }

  void clearFamily() {
    _family = null;
    notifyListeners();
  }
}
