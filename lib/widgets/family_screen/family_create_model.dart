import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/family_create.dart';
import 'package:all_for_moms_frontend/domain/entity/family_member.dart';
import 'package:flutter/material.dart';

class FamilyCreateModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final listTypes = ['MOTHER', 'FATHER', 'BROTHER', 'EMPTY'];
  final typeIdForHostController = TextEditingController();
  final typeIdForMemberController = TextEditingController();
  final idMemberController = TextEditingController();
  final List<FamilyMember> familyMembers = [];
  String? _errorMessage = null;
  String? get errorMessage => _errorMessage;

  int returnTypeId(String str) {
    switch (str) {
      case 'MOTHER' || 'Мама':
        return 2;
      case 'FATHER' || 'Папа':
        return 3;
      case 'BROTHER' || 'Брат':
        return 4;
      default:
        return 1;
    }
  }

  Future<void> createFamily(BuildContext context) async {
    final typeHostId = returnTypeId(typeIdForHostController.text);
    final family = FamilyCreate(
      membersId: familyMembers,
      typeIdForHost: typeHostId,
    );
    await _apiClient.createFamily(familyOld: family);
    familyMembers.clear();
    notifyListeners();
    Navigator.of(context).pop();
  }

  void addFamilyMember(BuildContext context) {
    final int userId;

    try {
      userId = int.parse(idMemberController.text);
    } catch (e) {
      _errorMessage = 'Введите число';
      notifyListeners();
      return;
    }

    final typeId = returnTypeId(typeIdForMemberController.text);

    FamilyMember member = FamilyMember(userId: userId, typeId: typeId);
    familyMembers.add(member);
    clearFileds();
    _errorMessage = null;
    notifyListeners();
    Navigator.of(context).pop();
  }

  void clearFileds() {
    idMemberController.clear();
  }

  String returnTypeStringById(int id) {
    switch (id) {
      case 2:
        return 'Мама';
      case 3:
        return 'Папа';
      case 4:
        return 'Брат';
      default:
        return 'Нет роли';
    }
  }
}
