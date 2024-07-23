import 'package:all_for_moms_frontend/domain/auth/auth_token.dart';
import 'package:all_for_moms_frontend/utils/family_model.dart';
import 'package:all_for_moms_frontend/utils/user_model.dart';
import 'package:all_for_moms_frontend/widgets/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreenWidget extends StatelessWidget {
  const ProfileScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final modelUser = context.read<UserModel>();
    final modelFamily = context.read<FamilyModel>();
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
                      // print('Token: $token');
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
              // TextButton(
              //   onPressed: () {
              //     showDialog(
              //         context: context,
              //         builder: (context) {
              //           return AlertDialog(
              //             title: Text('Удалить аккаунт'),
              //             scrollable: true,
              //             content: Padding(
              //                 padding: EdgeInsets.all(8),
              //                 child: Column(
              //                   children: [
              //                     Text(
              //                       'Вы уверены, что хотите удалить аккаунт?',
              //                       style: TextStyle(fontSize: 16),
              //                     )
              //                   ],
              //                 )),
              //             actions: [
              //               ElevatedButton(
              //                 onPressed: () async {
              //                   try {
              //                     // await modelFamily.deleteFamilyMember(
              //                     //   context,
              //                     //   modelUser.id,
              //                     //   modelFamily
              //                     //       .returnTypeString(modelUser.type!),
              //                     // );
              //                     await modelUser.deleteUserById(modelUser.id);
              //                     final tokenModel = Token();
              //                     await tokenModel.deleteToken();
              //                   } on Exception catch (e) {
              //                     print(e.toString());
              //                   }
              //                   Navigator.of(context).pushReplacementNamed(
              //                       MainNavigationRoutes.auth);
              //                 },
              //                 child: Text(
              //                   'Удалить',
              //                   style: TextStyle(
              //                     color: Colors.red,
              //                   ),
              //                 ),
              //               ),
              //               TextButton(
              //                   onPressed: () => Navigator.of(context).pop(),
              //                   child: const Text("Отмена"))
              //             ],
              //           );
              //         });
              //   },
              //   child: Text(
              //     'Удалить аккаунт',
              //     style: TextStyle(
              //       color: Colors.red,
              //       fontSize: 16,
              //     ),
              //   ),
              // )
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
