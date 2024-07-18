import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:flutter/material.dart';

class TaskCreateModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final endDateController = TextEditingController();
  final reccuranceController = TextEditingController();
  final membersController = TextEditingController();
  bool? isChecked = false;

  void changeCheckBox(bool? value) {
    isChecked = value;
    notifyListeners();
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    endDateController.clear();
    isChecked = false;
  }

  Future<void> createTask() async {
    print(titleController.text);
    print(descriptionController.text);
    print(endDateController.text);
    print(isChecked.toString());
    print(reccuranceController.text);
  }
}
