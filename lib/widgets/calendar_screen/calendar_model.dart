import 'package:all_for_moms_frontend/domain/entity/event.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarModel extends ChangeNotifier {
  TaskModel taskModel;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  CalendarFormat get calendarFormat => _calendarFormat;
  DateTime _focusedDay = DateTime.now();
  DateTime get focusedDay => _focusedDay;

  DateTime? _selectedDay;
  DateTime? get selectedDay => _selectedDay;

  Map<DateTime, List<Event>> events = {};

  late ValueNotifier<List<Event>> _selectedEvents;
  ValueNotifier<List<Event>> get selectedEvents => _selectedEvents;
  List<Event>? lista;

  final eventController = TextEditingController();

  CalendarModel({required this.taskModel}) {
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(getEventsForDay(_selectedDay!));
  }

  void changeCalendarFormat(CalendarFormat format) {
    _calendarFormat = format;
    notifyListeners();
  }

  void onPageChangedFocusedDay(DateTime focusedDay) {
    _focusedDay = focusedDay;
    notifyListeners();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _selectedEvents.value = getEventsForDay(selectedDay);
    }
    notifyListeners();
  }

  List<Event> getEventsForDay(DateTime day) {
    // if (taskModel.tasks.isNotEmpty) {

    // }
    // for (TaskResponse item in taskModel.tasks) {

    // }
    return events[day] ?? [];
  }

  // void _updateEventsFromTaskModel() {
  //   print('_updateEventsFromTaskModel');
  //   if (taskModel.tasks != null) {
  //     events.clear();
  //     for (var task in taskModel.tasks!) {
  //       if (task.endDate != null) {
  //         final date = DateTime(
  //             task.endDate!.year, task.endDate!.month, task.endDate!.day);
  //         if (events[date] != null) {
  //           events[date]!.add(task);
  //         } else {
  //           events[date] = [task];
  //         }
  //       }
  //     }

  //     notifyListeners(); // Notify listeners that events have changed
  //   }
  // }

  void AddEventButton(BuildContext context) {
    if (events[_selectedDay] != null) {
      lista = events[_selectedDay]!;
      events.addAll({
        _selectedDay!: [
          ...lista!,
          ...[Event(eventController.text)]
        ],
      });
    } else {
      events.addAll({
        _selectedDay!: [Event(eventController.text)]
      });
    }
    eventController.text = "";
    Navigator.of(context).pop();
    _selectedEvents.value = getEventsForDay(_selectedDay!);
    print(events.entries);
    notifyListeners();
  }
}

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
// import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';

// class CalendarModel extends ChangeNotifier {
//   final TaskModel taskModel;
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   CalendarFormat get calendarFormat => _calendarFormat;
//   DateTime _focusedDay = DateTime.now();
//   DateTime get focusedDay => _focusedDay;

//   DateTime? _selectedDay;
//   DateTime? get selectedDay => _selectedDay;

//   Map<DateTime, List<TaskResponse>> events = {};

//   late ValueNotifier<List<TaskResponse>> _selectedEvents;
//   ValueNotifier<List<TaskResponse>> get selectedEvents => _selectedEvents;
//   List<TaskResponse>? lista;

//   final eventController = TextEditingController();

//   CalendarModel({required this.taskModel}) {
//     _selectedDay = _focusedDay;
//     _selectedEvents = ValueNotifier(getEventsForDay(_selectedDay!));

//     // Listen to changes in TaskModel
//     taskModel.addListener(_updateEventsFromTaskModel);
//     _initializeEvents();
//   }

//   @override
//   void dispose() {
//     // Clean up the listener when CalendarModel is disposed
//     taskModel.removeListener(_updateEventsFromTaskModel);
//     super.dispose();
//   }

//   void _initializeEvents() {
//     _updateEventsFromTaskModel(); // Populate events initially
//   }

//   void _updateEventsFromTaskModel() {
//     print('_updateEventsFromTaskModel');
//     if (taskModel.tasks != null) {
//       events.clear();
//       for (var task in taskModel.tasks!) {
//         if (task.endDate != null) {
//           final date = DateTime(
//               task.endDate!.year, task.endDate!.month, task.endDate!.day);
//           if (events[date] != null) {
//             events[date]!.add(task);
//           } else {
//             events[date] = [task];
//           }
//         }
//       }

//       notifyListeners(); // Notify listeners that events have changed
//     }
//   }

//   void changeCalendarFormat(CalendarFormat format) {
//     _calendarFormat = format;
//     notifyListeners();
//   }

//   void onPageChangedFocusedDay(DateTime focusedDay) {
//     _focusedDay = focusedDay;
//     notifyListeners();
//   }

//   void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     if (!isSameDay(_selectedDay, selectedDay)) {
//       _selectedDay = selectedDay;
//       _focusedDay = focusedDay;
//       _selectedEvents.value = getEventsForDay(selectedDay);
//     }
//     notifyListeners();
//   }

//   List<TaskResponse> getEventsForDay(DateTime day) {
//     //print(events[day]?.length);
//     return events[day] ?? [];
//   }
// }
