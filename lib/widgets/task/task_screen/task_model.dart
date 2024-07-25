import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:all_for_moms_frontend/utils/family_model.dart';
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
  Map<DateTime, List<TaskResponse>> get mapListGetter => _getMapGetterTasks();
  Map<DateTime, List<TaskResponse>> get mapListSetter => _getMapSetterTasks();

  void setTaskSetter(List<TaskResponse> tasks) {
    tasks.sort((a, b) => compare(a, b));
    _tasksSetter = tasks;
    notifyListeners();
  }

  void setTaskGetter(List<TaskResponse> tasks) {
    tasks.sort((a, b) => compare(a, b));
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
    final List<TaskResponse> tasks =
        await _apiClient.getTasksByTaskSetterId(userId: userId);
    setTaskSetter(tasks);
  }

  Future<void> updateTasksGetter({required int userId}) async {
    final List<TaskResponse> tasks =
        await _apiClient.getTasksByTaskGetterId(userId: userId);
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

  int compare(TaskResponse first, TaskResponse second) {
    return first.endDate!.compareTo(second.endDate!);
  }

  Map<DateTime, List<TaskResponse>> _getMapGetterTasks() {
    Map<DateTime, List<TaskResponse>> events = {};
    if (tasksGetter != null) {
      for (var task in tasksGetter!) {
        if (task.endDate != null) {
          final date = DateTime(
            task.endDate!.year,
            task.endDate!.month,
            task.endDate!.day,
          );
          if (events[date] != null) {
            events[date]!.add(task);
          } else {
            events[date] = [task];
          }
        }
      }
    }
    return events;
  }

  Map<DateTime, List<TaskResponse>> _getMapSetterTasks() {
    Map<DateTime, List<TaskResponse>> events = {};
    if (tasksSetter != null) {
      events.clear();
      for (var task in tasksSetter!) {
        if (task.endDate != null) {
          final date = DateTime(
            task.endDate!.year,
            task.endDate!.month,
            task.endDate!.day,
          );
          if (events[date] != null) {
            events[date]!.add(task);
          } else {
            events[date] = [task];
          }
        }
      }
    }
    return events;
  }

  bool isSameTask(TaskResponse task) {
    for (var u in tasksGetter!) {
      if (u == task) {
        return true;
      }
    }
    return false;
  }

  Map<int, String> monthsInYear = {
    1: "января",
    2: "февраля",
    3: "марта",
    4: 'апреля',
    5: 'мая',
    6: 'июня',
    7: 'июля',
    8: 'августа',
    9: 'сентября',
    10: 'октября',
    11: 'ноября',
    12: 'декабря',
  };

  String returnDateString(DateTime date) {
    DateTime now = DateTime.now();
    int diff = DateTime(date.year, date.month, date.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;

    if (diff == 0) {
      return 'Сегодня';
    } else if (diff == 1) {
      return 'Завтра';
    } else if (diff == -1) {
      return 'Вчера';
    } else {
      return "${date.day} ${monthsInYear[date.month]}";
    }
  }

  String returnGetterString(
      int getterIndex, int userIndex, FamilyModel familyModel, bool isDone) {
    if (getterIndex == userIndex) {
      return 'Cобственное задание ${isDone ? ' - Выполнено' : ''}';
    }
    return 'Выполняет:  ${familyModel.getNameById(getterIndex)}${isDone ? ' - Выполнено' : ''}';
  }
}
