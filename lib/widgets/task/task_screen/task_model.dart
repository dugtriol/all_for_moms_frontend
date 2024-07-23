import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:all_for_moms_frontend/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskModel extends ChangeNotifier {
  TaskModel._internal();

  @override
  void dispose() {
    super.dispose();
  }

  static final TaskModel _instance = TaskModel._internal();

  factory TaskModel() {
    return _instance;
  }
  final _apiClient = ApiClient();
  List<TaskResponse>? _tasksSetter;
  List<TaskResponse>? get tasksSetter => _tasksSetter;

  List<TaskResponse>? _tasksGetter;
  List<TaskResponse>? get tasksGetter => _tasksGetter;

  void setTaskSetter(List<TaskResponse> tasks) {
    _tasksSetter = tasks;
    notifyListeners();
  }

  void setTaskGetter(List<TaskResponse> tasks) {
    _tasksGetter = tasks;
    notifyListeners();
  }

  void clearTask() {
    _tasksSetter?.clear();
    _tasksGetter?.clear();
    notifyListeners();
  }

  bool isListSetterNotEmpty() {
    if (_tasksSetter == null) {
      return false;
    }
    return _tasksSetter!.isNotEmpty;
  }

  bool isListGetterNotEmpty() {
    if (_tasksGetter == null) {
      return false;
    }
    return _tasksGetter!.isNotEmpty;
  }

  Future<void> updateTasksSetter({required int userId}) async {
    print('updateTasksSetter');
    final List<TaskResponse> tasks =
        await _apiClient.getTasksByTaskSetterId(userId: userId);
    // print(tasks.length);
    setTaskSetter(tasks);
  }

  Future<void> updateTasksGetter({required int userId}) async {
    print('updateTasksGetter');
    final List<TaskResponse> tasks =
        await _apiClient.getTasksByTaskGetterId(userId: userId);
    // print(tasks.length);
    setTaskGetter(tasks);
  }

  Future<void> IsCompletedTask(int taskId) async {
    await _apiClient.completeTask(taskId: taskId);
  }

  String getDeadline(DateTime? deadline) {
    if (deadline == null) {
      return 'Нет данных';
    }
    return DateFormat('yyyy-MM-dd').format(deadline);
  }
}
