import 'package:all_for_moms_frontend/app/all_for_moms_app.dart';
import 'package:all_for_moms_frontend/app/all_for_moms_app_model.dart';
import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/utils/task_model.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:all_for_moms_frontend/widgets/task_form/task_create_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final appModel = AllForMomsAppModel();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserModel()),
      ChangeNotifierProvider(create: (_) => FamilyModel()),
      // ChangeNotifierProvider(create: (_) => TaskModel()),
      ChangeNotifierProvider(create: (_) => TaskCreateModel()),
    ],
    child: AllForMomsApp(appModel: appModel),
  ));
}
