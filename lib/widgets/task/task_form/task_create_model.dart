import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/task_request.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskCreateModel extends ChangeNotifier {
  List<String> list = [
    'Не повторять',
    'Ежедневно',
    'Еженедельно',
    'Ежемесячно',
    'Ежегодно'
  ];
  final _apiClient = ApiClient();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final endDateController = TextEditingController();
  final reccuranceController = TextEditingController();
  final membersController = TextEditingController();
  bool isChecked = true;
  final int rewardPoint = 0;

  void changeCheckBox(bool value) {
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
    String title = titleController.text;
    String description = descriptionController.text;
    DateTime endDate = DateFormat("yyyy-MM-dd").parse(endDateController.text);
    int? reccuranceInterval;

    switch (reccuranceController.text) {
      case 'Ежедневно':
        reccuranceInterval = 0;
        break;
      case 'Еженедельно':
        reccuranceInterval = 1;
        break;
      case 'Ежемесячно':
        reccuranceInterval = 2;
        break;
      case 'Ежегодно':
        reccuranceInterval = 3;
        break;
      default:
        reccuranceInterval = null;
        isChecked = false;
    }

    int id = await _apiClient.getUserIdByName(name: membersController.text);
    DateTime startDate = DateTime.now();
    TaskRequest task = TaskRequest(
      title: title,
      description: description,
      endDate: endDate,
      isRecurring: isChecked,
      recurrenceInterval: reccuranceInterval,
      rewardPoint: rewardPoint,
      startDate: startDate,
      taskGetter: id,
    );
    await _apiClient.createTask(task: task);
  }
}
