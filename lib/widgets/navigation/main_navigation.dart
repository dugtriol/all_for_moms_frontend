import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:all_for_moms_frontend/widgets/auth/sign_up_model.dart';
import 'package:all_for_moms_frontend/widgets/auth/sign_up_widget.dart';
import 'package:all_for_moms_frontend/widgets/main_screen/main_screen_model.dart';
import 'package:all_for_moms_frontend/widgets/task_form/task_create_model.dart';
import 'package:all_for_moms_frontend/widgets/task_form/task_form_widget.dart';
import 'package:all_for_moms_frontend/widgets/task_screen/task_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/sign_in_model.dart';
import '../auth/sign_in_widget.dart';
import '../calendar_screen/calendar_widget.dart';
import '../main_screen/main_screen.dart';

abstract class MainNavigationRoutes {
  static const auth = '/auth';
  static const mainScreen = '/home';
  static const calendar = '/home/calendar';
  static const signUp = '/auth/signup';
  static const taskList = '/home/task_list';
  static const taskForm = '/home/task_list/task_create';
}

class MainNavigation {
  String initialRoute(bool isAuth) =>
      isAuth ? MainNavigationRoutes.mainScreen : MainNavigationRoutes.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutes.auth: (context) => ChangeNotifierProvider(
          create: (context) => SignInModel(),
          child: const SignInScreen(),
        ),
    MainNavigationRoutes.mainScreen: (context) => ChangeNotifierProvider(
          create: (context) => MainScreenModel(),
          child: const MainScreen(),
        ),
    MainNavigationRoutes.calendar: (context) => const CalendarWidget(),
    MainNavigationRoutes.signUp: (context) => ChangeNotifierProvider(
          create: (context) => SignUpModel(),
          child: const SignUpWidget(),
        ),
  };
}
