import 'package:all_for_moms_frontend/app/all_for_moms_app.dart';
import 'package:all_for_moms_frontend/app/all_for_moms_app_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final appModel = AllForMomsAppModel();
  runApp(AllForMomsApp(appModel: appModel));
}
