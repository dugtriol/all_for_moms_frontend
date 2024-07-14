import 'package:all_for_moms_frontend/app/all_for_moms_app.dart';
import 'package:all_for_moms_frontend/app/all_for_moms_app_model.dart';
import 'package:all_for_moms_frontend/utils/provider_old.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';

import 'package:flutter/material.dart';

void main() {
  final appModel = AllForMomsAppModel();
  runApp(NotifierProvider(
    model: UserModel(),
    child: AllForMomsApp(appModel: appModel),
  ));
}
