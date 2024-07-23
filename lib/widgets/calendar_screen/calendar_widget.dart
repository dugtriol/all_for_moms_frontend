import 'package:all_for_moms_frontend/domain/entity/event.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:all_for_moms_frontend/widgets/calendar_screen/calendar_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final modelCalendar = context.watch<CalendarModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Календарь'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            TableCalendarWidget(),
            const SizedBox(height: 20.0),
            Expanded(
              child: ValueListenableBuilderWidgetCalendar(),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: "btn1",
      //   child: const Icon(Icons.add),
      //   onPressed: () {
      //     showDialog(
      //         context: context,
      //         builder: (context) {
      //           return AlertDialog(
      //             scrollable: true,
      //             title: const Text("Описание"),
      //             content: Padding(
      //               padding: const EdgeInsets.all(8),
      //               child: TextField(
      //                 controller: modelCalendar.eventController,
      //               ),
      //             ),
      //             actions: [
      //               ElevatedButton(
      //                 onPressed: () {
      //                   // modelCalendar.AddEventButton(
      //                   //   context,

      //                   // );
      //                 },
      //                 child: const Text("Сохранить"),
      //               ),
      //             ],
      //           );
      //         });
      //   },
      // )
    );
  }
}

class TableCalendarWidget extends StatelessWidget {
  TableCalendarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final modelCalendar = context.watch<CalendarModel>();
    return TableCalendar(
      calendarFormat: modelCalendar.calendarFormat,
      availableGestures: AvailableGestures.all,
      selectedDayPredicate: (day) => isSameDay(modelCalendar.selectedDay, day),
      focusedDay: modelCalendar.focusedDay,
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 10, 16),
      onDaySelected: (selectedDay, focusedDay) =>
          modelCalendar.onDaySelected(selectedDay, focusedDay),
      eventLoader: (day) => modelCalendar.getEventsForDay(day),
      startingDayOfWeek: StartingDayOfWeek.monday,
      onPageChanged: (focusedDay) {
        modelCalendar.onPageChangedFocusedDay(focusedDay);
      },
      onFormatChanged: (format) {
        if (modelCalendar.calendarFormat != format) {
          modelCalendar.changeCalendarFormat(format);
        }
      },
    );
  }
}

class ValueListenableBuilderWidgetCalendar extends StatelessWidget {
  ValueListenableBuilderWidgetCalendar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final modelCalendar = context.watch<CalendarModel>();
    final userModel = context.read<UserModel>();
    final modelTask = context.read<TaskModel>();
    final familyModel = context.read<FamilyModel>();
    return ValueListenableBuilder<List<TaskResponse>>(
      valueListenable: modelCalendar.selectedEvents,
      builder: (context, value, _) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: value[index].taskGetter == userModel.id
                      ? Colors.blue
                      : Colors.green,
                ),
                borderRadius: BorderRadius.circular(12),
                color: value[index].taskGetter == userModel.id
                    ? Colors.lightBlue[100]
                    : Colors.greenAccent[100],
              ),
              child: ListTile(
                onTap: () => print(""),
                title: Text(
                  '${value[index].title}\n${returnGetterString(
                    value[index].taskGetter,
                    userModel.id,
                    familyModel,
                  )}',
                ),
              ),
            );
          },
        );
      },
    );
  }

  String returnGetterString(
      int getterIndex, int userIndex, FamilyModel familyModel) {
    if (getterIndex == userIndex) {
      return 'Cобственное задание';
    }
    return 'Выполняет:  ${familyModel.getNameById(getterIndex)}';
  }
}
