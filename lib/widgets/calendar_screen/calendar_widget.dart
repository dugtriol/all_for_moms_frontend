import 'package:all_for_moms_frontend/domain/entity/event.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/home/add_task');
  }

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> events = {};
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late final ValueNotifier<List<Event>> _selectedEvents;
  List<Event>? lista;

  final _eventController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TableCalendar(
              calendarFormat: _calendarFormat,
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 10, 16),
              onDaySelected: _onDaySelected,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
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
              ),
            )

            // _TaskListWidget(length: 3)
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => showForm(context),
      //   backgroundColor: Colors.purple[400],
      //   child: const Icon(Icons.add),
      // ));
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
                      controller: _eventController,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        if (events[_selectedDay] != null) {
                          lista = events[_selectedDay]!;
                          events.addAll({
                            _selectedDay!: [
                              ...lista!,
                              ...[Event(_eventController.text)]
                            ],
                          });
                        } else {
                          events.addAll({
                            _selectedDay!: [Event(_eventController.text)]
                          });
                        }
                        _eventController.text = "";
                        Navigator.of(context).pop();
                        _selectedEvents.value = _getEventsForDay(_selectedDay!);
                      },
                      child: const Text("Сохранить"),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
