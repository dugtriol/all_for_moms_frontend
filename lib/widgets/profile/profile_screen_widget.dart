import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/utils/provider_old.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/user_model.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<UserModel>();
    final familyModel = context.read<FamilyModel>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Column(
                  children: [
                    Text("Имя"),
                    Text("Почтовый адрес"),
                    Text("Дата рождения"),
                    Text("Идентификатор"),
                  ],
                ),
                Column(
                  children: [
                    Text("${userModel?.user?.name}"),
                    Text("${userModel?.user?.email}"),
                    Text("${userModel?.user?.dateOfBirth}"),
                    Text("${userModel?.user?.id}"),
                    Text("${userModel?.type}")
                  ],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:
                            Text("${familyModel.family?.members[index].name}"),
                      );
                    },
                    itemCount: familyModel.family?.members.length,
                    shrinkWrap: true,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text("Создать семью"),
      ),
    );
  }
}
