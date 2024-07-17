import 'package:all_for_moms_frontend/utils/provider_old.dart';
import 'package:all_for_moms_frontend/widgets/auth/sign_up_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sign_in_widget.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final model = NotifierProvider.read<SignUpModel>(context);
    final model = context.read<SignUpModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Регистрация"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ErrorMessageWidget(),
            SizedBox(
              width: 250,
              child: TextField(
                controller: model?.nameController,
                decoration: const InputDecoration(labelText: 'Имя'),
              ),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                controller: model?.emailController,
                decoration: const InputDecoration(labelText: 'Почтовый адрес'),
              ),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                controller: model?.loginController,
                decoration: const InputDecoration(labelText: 'Логин'),
              ),
            ),
            SizedBox(
              width: 250,
              child: TextField(
                obscureText: true,
                controller: model?.passwordController,
                decoration: const InputDecoration(labelText: 'Пароль'),
              ),
            ),
            SizedBox(
              width: 250,
              height: 60,
              child: TextField(
                controller: model?.dateOfBirthController,
                decoration: const InputDecoration(
                  labelText: 'Дата рождения',
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    size: 20.0,
                  ),
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
            ),
            const SizedBox(height: 32),
            const _signUpButton(),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    // final model = NotifierProvider.read<SignUpModel>(context);
    final model = context.read<SignUpModel>();
    DateTime? _picker = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (_picker != null) {
      model?.dateOfBirthController.text = _picker.toString().split(" ")[0];
    }
  }
}

class _signUpButton extends StatelessWidget {
  const _signUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final model = NotifierProvider.watch<SignUpModel>(context);
    final model = context.watch<SignUpModel>();
    final child = model?.isSignUpProgress == true
        ? const SizedBox(
            child: CircularProgressIndicator(),
            height: 15,
            width: 15,
          )
        : const Text('Зарегистрироваться');
    return ElevatedButton(
      onPressed: () {
        print(model?.canStartSignUp.toString());
        if (model?.canStartSignUp == true) {
          model?.signup(context);
        } else {
          return;
        }
        print('onPressed');
      },
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final errorMessage =
    //     NotifierProvider.watch<SignUpModel>(context)?.errorMessage;
    final errorMessage = context.watch<SignUpModel>()?.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();
    return Text(
      errorMessage,
      style: const TextStyle(
        color: Colors.red,
        fontSize: 14,
      ),
    );
  }
}
