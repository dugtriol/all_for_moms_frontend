import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/task.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:flutter/material.dart';

class TaskModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  List<Task>? _tasks;

  List<Task>? get tasks => _tasks;

  void setTask(List<Task> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  void clearTask() {
    _tasks?.clear();
    notifyListeners();
  }

  Future<void> updateTasks({required int userId}) async {
    print('updateTasks');
    final tasks = await _apiClient.getTasksByTaskSetterId(userId: userId);
    print(tasks.length);
    setTask(tasks);
  }
}
