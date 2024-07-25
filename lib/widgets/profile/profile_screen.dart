import 'package:all_for_moms_frontend/domain/auth/auth_token.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:all_for_moms_frontend/widgets/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreenWidget extends StatelessWidget {
  const ProfileScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final modelUser = context.read<UserModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 4,
                      color: Theme.of(context).scaffoldBackgroundColor),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: 2,
                        blurRadius: 10,
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 10))
                  ],
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    // fit: BoxFit.cover,
                    image: AssetImage('assets/image.png'),
                  ),
                ),
              ),
              buildTextField('Идентификатор', modelUser.id.toString(), false),
              buildTextField('Имя', modelUser.name, false),
              buildTextField('Имя', modelUser.username, false),
              buildTextField('Электронная почта', modelUser.email, false),
              buildTextField('Дата рождения', modelUser.dateOfBirth, false),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    final tokenModel = Token();
                    try {
                      tokenModel.deleteToken();
                    } catch (e) {
                      print(e);
                    }
                    Navigator.of(context)
                        .pushReplacementNamed(MainNavigationRoutes.auth);
                  },
                  child: const Text(
                    'Выйти из аккаунта',
                    style: TextStyle(fontSize: 16),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
