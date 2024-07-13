import 'package:all_for_moms_frontend/widgets/main_screen/main_screen_model.dart';
import 'package:flutter/material.dart';

import '../../utils/provider.dart';
import '../auth/auth_model.dart';
import '../auth/sign_in_widget.dart';
import '../calendar_screen/calendar_widget.dart';
import '../main_screen/main_screen.dart';

abstract class MainNavigationRoutes {
  static const auth = '/auth';
  static const mainScreen = '/home';
  static const calendar = '/home/calendar';
}

class MainNavigation {
  String initialRoute(bool isAuth) =>
      isAuth ? MainNavigationRoutes.mainScreen : MainNavigationRoutes.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutes.auth: (context) => NotifierProvider(
          model: AuthModel(),
          child: const SignInScreen(),
        ),
    MainNavigationRoutes.mainScreen: (context) =>
        NotifierProvider(model: MainScreenModel(), child: const MainScreen()),
    MainNavigationRoutes.calendar: (context) => const CalendarWidget(),
    // '/home/list_task': (context) => const TaskFormWidget(),
    // '/home/list_task/detail_task': (context) => TaskListWidget(),
  };
}
