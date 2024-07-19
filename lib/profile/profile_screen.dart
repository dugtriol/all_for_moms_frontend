import 'package:flutter/material.dart';

class ProfileScreenWaidget extends StatelessWidget {
  const ProfileScreenWaidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            iconSize: 20,
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
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
                  // Text("${userModel.user?.name}"),
                  // Text("${userModel.user?.email}"),
                  // Text("${userModel.user?.dateOfBirth}"),
                  // Text("${userModel.user?.id}"),
                  // Text("${userModel.type}"),
                ],
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
