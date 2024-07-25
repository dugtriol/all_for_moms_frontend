import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
import 'package:all_for_moms_frontend/utils/alert_dialog_task_info_widget.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Календарь'),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            TableCalendarWidget(),
            SizedBox(height: 20.0),
            Expanded(
              child: ValueListenableBuilderWidgetCalendar(),
            )
          ],
        ),
      ),
    );
  }
}

class TableCalendarWidget extends StatelessWidget {
  const TableCalendarWidget({
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
  const ValueListenableBuilderWidgetCalendar({
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
        final _apiClient = ApiClient();
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
                onTap: () {
                  alertDialogTaskInfoWidget(
                    context,
                    familyModel,
                    _apiClient,
                    value[index],
                    // index,
                    value[index].taskGetter == userModel.id,
                    modelTask,
                  );
                },
                title: Text(
                  '${value[index].title}\n${modelTask.returnGetterString(
                    value[index].taskGetter,
                    userModel.id,
                    familyModel,
                    value[index].isCompleted,
                  )}',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
