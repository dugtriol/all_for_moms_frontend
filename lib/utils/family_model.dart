import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/family_response.dart';
import 'package:all_for_moms_frontend/domain/entity/user.dart';
import 'package:flutter/material.dart';

class FamilyModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  FamilyResponse? _family;

  FamilyResponse? get family => _family;

  List<User>? get members {
    if (_family == null || _family!.members.isEmpty) {
      return null;
    }
    return _family?.members;
  }

  List<String>? get listNameMembers {
    List<String> list = [];
    for (User user in _family!.members) {
      list.add(user.name);
    }
    return list;
  }

  List<User>? get hosts {
    if (_family == null || _family!.hosts.isEmpty) {
      return null;
    }
    return _family?.hosts;
  }

  Future<void> updateFamily() async {
    final FamilyResponse family = await _apiClient.getFamilyByUserId();
    setFamily(family);
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
