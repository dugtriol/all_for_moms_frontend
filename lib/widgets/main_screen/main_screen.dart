import 'package:all_for_moms_frontend/models/task.dart';
import 'package:all_for_moms_frontend/widgets/task_form/task_form_widget.dart';
import 'package:all_for_moms_frontend/widgets/calendar_screen/calendar_widget.dart';
import 'package:all_for_moms_frontend/widgets/task_screen/task_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selecteTab = 0;

  void onSelectTab(int index) {
    if (_selecteTab == index) return;
    setState(() {
      _selecteTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("all for moms"),
      ),
      body: IndexedStack(
        index: _selecteTab,
        children: [
          CalendarWidget(),
          TaskListWidget(),
          // ProfileWidget(),
          Text("Profile"),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selecteTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Календарь",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Список",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Профиль",
          )
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
