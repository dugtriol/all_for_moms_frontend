import 'package:all_for_moms_frontend/utils/provider_old.dart';
import 'package:flutter/material.dart';

import '../../utils/user_model.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<UserModel>(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Имя: ${model?.user?.name}"),
            Text("Почтовый адрес: ${model?.user?.email}"),
            Text("Дата рождения: ${model?.user?.dateOfBirth}"),
            Text("Идентификатор: ${model?.user?.id}"),
          ],
        ),
      ),
    );
  }
}
