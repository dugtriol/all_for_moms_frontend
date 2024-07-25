import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';

class CalendarModel extends ChangeNotifier {
  final TaskModel taskModel;
  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();

  DateTime? selectedDay;
  Map<DateTime, List<TaskResponse>> events = {};

  late ValueNotifier<List<TaskResponse>> _selectedEvents;
  ValueNotifier<List<TaskResponse>> get selectedEvents => _selectedEvents;
  List<TaskResponse>? lista;

  final eventController = TextEditingController();

  CalendarModel({required this.taskModel}) {
    init();
    taskModel.addListener(_updateEventsFromTaskModel);
    _updateEventsFromTaskModel();
  }

  void init() {
    selectedDay = focusedDay;
    _selectedEvents = ValueNotifier(getEventsForDay(selectedDay!));
    notifyListeners();
  }

  @override
  void dispose() {
    taskModel.removeListener(_updateEventsFromTaskModel);
    super.dispose();
  }

  void _updateEventsFromTaskModel() {
    if (taskModel.tasksSetter != null) {
      events.clear();
      for (var task in taskModel.tasksSetter!) {
        if (task.endDate != null) {
          final date = DateTime(
              task.endDate!.year, task.endDate!.month, task.endDate!.day);

          if (events[date] != null) {
            events[date]!.add(task);
          } else {
            events[date] = [task];
          }
        }
      }
    }
    if (taskModel.tasksGetter != null) {
      for (var task in taskModel.tasksGetter!) {
        if (!taskModel.isSameTask(task)) {
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
    }
    notifyListeners();
  }

  void changeCalendarFormat(CalendarFormat format) {
    calendarFormat = format;
    notifyListeners();
  }

  void onPageChangedFocusedDay(DateTime focusedDay_w) {
    focusedDay = focusedDay_w;
    notifyListeners();
  }

  void onDaySelected(DateTime selectedDay_w, DateTime focusedDay_w) {
    if (!isSameDay(selectedDay, selectedDay_w)) {
      selectedDay = selectedDay_w;
      focusedDay = focusedDay_w;
      _selectedEvents.value = getEventsForDay(selectedDay_w);
      notifyListeners();
    }
  }

  List<TaskResponse> getEventsForDay(DateTime day) {
    final date = DateTime(day.year, day.month, day.day);
    return events[date] ?? [];
  }
}
