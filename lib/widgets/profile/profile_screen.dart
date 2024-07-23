import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreenWidget extends StatelessWidget {
  const ProfileScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final modelUser = context.read<UserModel>();
    return Scaffold(
      appBar: AppBar(title: Text('Профиль')),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
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
                        offset: Offset(0, 10))
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
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
        // obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      // setState(() {
                      //   showPassword = !showPassword;
                      // });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
