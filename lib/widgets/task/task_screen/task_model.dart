import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:flutter/material.dart';

class TaskModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  List<TaskResponse>? _tasks;

  List<TaskResponse>? get tasks => _tasks;

  void setTask(List<TaskResponse> tasks) {
    _tasks = tasks;
    notifyListeners();
  }

  void clearTask() {
    _tasks?.clear();
    notifyListeners();
  }

  Future<void> updateTasks({required int userId}) async {
    print('updateTasks');
    final List<TaskResponse> tasks =
        await _apiClient.getTasksByTaskSetterId(userId: userId);
    // print(tasks.length);
    setTask(tasks);
  }
}
