import 'package:all_for_moms_frontend/models/task.dart';
import 'package:all_for_moms_frontend/widgets/screens.dart';
import 'package:all_for_moms_frontend/widgets/task_form/task_form_widget.dart';
import 'package:all_for_moms_frontend/widgets/calendar_screen/calendar_widget.dart';
import 'package:all_for_moms_frontend/widgets/task_screen/task_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllForMomsApp extends StatelessWidget {
  const AllForMomsApp({super.key});

  @override
  Widget build(BuildContext context) {
    //   return MultiProvider(
    //     providers: [
    //       ChangeNotifierProvider(
    //         create: (context) => ListOfTasks(),
    //       )
    //     ],
    //     child: MaterialApp(
    //       initialRoute: '/home',
    //       routes: {
    //         // '/': (context) => const LoginPage(),
    //         '/home': (context) => const HomeScreen(),
    //         '/add_task': (context) => const TaskFormWidget(),
    //         '/tasklist': (context) => const TaskWidget(),
    //       },
    //     ),
    //   );
    // }
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        // '/': (context) => const LoginPage(),
        '/home': (context) => const HomeScreen(),
        '/home/calendar': (context) => const CalendarWidget(),
        '/home/list_task': (context) => const TaskFormWidget(),
        '/home/list_task/detail_task': (context) => TaskListWidget(),
      },
    );
  }
}
