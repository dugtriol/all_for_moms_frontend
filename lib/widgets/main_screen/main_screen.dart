import 'package:all_for_moms_frontend/app/all_for_moms_app_model.dart';
import 'package:all_for_moms_frontend/utils/task_model.dart';
import 'package:all_for_moms_frontend/widgets/calendar_screen/calendar_widget.dart';
import 'package:all_for_moms_frontend/widgets/profile/profile_screen_widget.dart';
import 'package:all_for_moms_frontend/widgets/task_form/task_create_model.dart';
import 'package:all_for_moms_frontend/widgets/task_screen/task_screen_widget.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("All for moms"),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          CalendarWidget(),
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => TaskModel()),
              ChangeNotifierProvider(create: (_) => TaskCreateModel()),
            ],
            child: TaskListWidget(),
          ),
          ProfileWidget(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.settings),
            label: "Профиль",
          )
        ],
        onTap: onSelectTab,
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () => AllForMomsAppModel().changeAuth()),
    );
  }
}
