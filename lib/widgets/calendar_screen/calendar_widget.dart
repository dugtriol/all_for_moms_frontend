import 'package:all_for_moms_frontend/domain/entity/event.dart';
import 'package:all_for_moms_frontend/domain/entity/task_response.dart';
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
              TableCalendarWidget(modelCalendar: modelCalendar),
              const SizedBox(height: 20.0),
              Expanded(
                child: ValueListenableBuilderWidgetCalndar(
                    modelCalendar: modelCalendar),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "btn1",
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text("Описание"),
                    content: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: modelCalendar.eventController,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          modelCalendar.AddEventButton(context);
                        },
                        child: const Text("Сохранить"),
                      ),
                    ],
                  );
                });
          },
        ));
  }
}

class TableCalendarWidget extends StatelessWidget {
  const TableCalendarWidget({
    super.key,
    required this.modelCalendar,
  });

  final CalendarModel modelCalendar;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarFormat: modelCalendar.calendarFormat,
      availableGestures: AvailableGestures.all,
      selectedDayPredicate: (day) => isSameDay(modelCalendar.selectedDay, day),
      focusedDay: DateTime.now(),
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

class ValueListenableBuilderWidgetCalndar extends StatelessWidget {
  const ValueListenableBuilderWidgetCalndar({
    super.key,
    required this.modelCalendar,
  });

  final CalendarModel modelCalendar;

  @override
  Widget build(BuildContext context) {
    final modelTask = context.read<TaskModel>();
    return ValueListenableBuilder<List<Event>>(
      valueListenable: modelCalendar.selectedEvents,
      builder: (context, value, _) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: 12, right: 12, bottom: 5),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                onTap: () => print(""),
                title: Text(
                  '${value[index].title}',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
