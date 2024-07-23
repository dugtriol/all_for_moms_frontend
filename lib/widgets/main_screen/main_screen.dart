import 'package:all_for_moms_frontend/widgets/profile/profile_screen.dart';
import 'package:all_for_moms_frontend/widgets/calendar_screen/calendar_model.dart';
import 'package:all_for_moms_frontend/widgets/family_screen/family_create_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/task_model.dart';
import 'package:all_for_moms_frontend/widgets/calendar_screen/calendar_widget.dart';
import 'package:all_for_moms_frontend/widgets/family_screen/family_list_screen_widget.dart';
import 'package:all_for_moms_frontend/widgets/task/task_form/task_create_model.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/tasks_list_widget.dart';
import 'package:all_for_moms_frontend/widgets/task/task_screen/tasks_setter_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskModel = context.read<TaskModel>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: _selectedTab,
        children: [
          ChangeNotifierProvider(
            create: (context) => CalendarModel(taskModel: taskModel),
            child: CalendarWidget(),
          ),
          TasksListWidget(),
          FamilyListWidget(),
          ProfileScreenWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.transparent,
        currentIndex: _selectedTab,
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
            icon: Icon(Icons.family_restroom),
            label: "Семья",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Профиль",
          ),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
