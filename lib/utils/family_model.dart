import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/family_member.dart';
import 'package:all_for_moms_frontend/domain/entity/family_response.dart';
import 'package:all_for_moms_frontend/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FamilyModel extends ChangeNotifier {
  @override
  void dispose() {
    super.dispose();
  }

  final _apiClient = ApiClient();
  FamilyResponse? _family;
  bool familyIsExist = false;

  FamilyResponse? get family => _family;

  List<User>? get members {
    if (_family == null || _family!.members.isEmpty) {
      return null;
    }
    return _family?.members;
  }

  List<String>? get listUsernameMembers {
    List<String> list = [];
    for (User user in _family!.members) {
      list.add(user.username);
    }
    return list;
  }

  String? getType(int index) {
    if (_family!.members[index].type!.type.isEmpty ||
        _family?.members[index].type == null) {
      return "Нет данных";
    }
    return returnTypeString(_family!.members[index].type!.type);
  }

  String returnTypeString(String str) {
    switch (str) {
      case 'MOTHER':
        return 'Мама';
      case 'FATHER':
        return 'Папа';
      case 'BROTHER':
        return 'Брат';
      default:
        return 'Нет роли';
    }
  }

  String? getName(int index) {
    if (_family!.members[index].name.isEmpty ||
        _family?.members[index].name == null) {
      return "Нет данных";
    }
    return _family!.members[index].name;
  }

  List<User>? get hosts {
    if (_family == null || _family!.hosts.isEmpty) {
      return null;
    }
    return _family?.hosts;
  }

  String getNameById(int id) {
    for (User user in _family!.members) {
      if (user.id == id) {
        return user.name;
      }
    }
    return 'Нет данных';
  }

  String getDateOfBirth(int index) {
    if (_family == null ||
        _family!.members.isEmpty ||
        _family!.members[index].dateOfBirth == null) {
      return 'Нет данных';
    }
    return DateFormat('yyyy-MM-dd')
        .format(_family!.members[index].dateOfBirth!);
  }

  Future<void> updateFamily() async {
    // print('updateFamily');
    final FamilyResponse family = await _apiClient.getFamilyByUserId();
    setFamily(family);
    notifyListeners();
  }

  void setFamily(FamilyResponse family) {
    if (family != null ||
        family.hosts.isNotEmpty ||
        family.members.isNotEmpty) {
      // print('isExist');
      familyIsExist = true;
      _family = family;
    } else {
      print('Not Exist');
      familyIsExist = false;
    }
    notifyListeners();
  }

  void clearFamily() {
    _family = null;
    notifyListeners();
  }

  // void addFamilyMember(
  //   BuildContext context,
  //   String idMemberText,
  // ) {
  //   final int userId;

  //   try {
  //     userId = int.parse(idMemberController.text);
  //   } catch (e) {
  //     _errorMessage = 'Введите число';
  //     notifyListeners();
  //     return;
  //   }

  //   final typeId = returnTypeId(typeIdForMemberController.text);

  //   FamilyMember member = FamilyMember(userId: userId, typeId: typeId);
  //   members.add(member);
  //   clearFileds();
  //   _errorMessage = null;
  //   notifyListeners();
  //   Navigator.of(context).pop();
  // }
}
