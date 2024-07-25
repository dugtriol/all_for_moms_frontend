import 'package:all_for_moms_frontend/app/all_for_moms_app_model.dart';
import 'package:all_for_moms_frontend/widgets/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class AllForMomsApp extends StatelessWidget {
  final AllForMomsAppModel appModel;
  const AllForMomsApp({super.key, required this.appModel});
  static final mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: mainNavigation.initialRoute(appModel.isAuth),
      routes: mainNavigation.routes,
    );
  }
}
