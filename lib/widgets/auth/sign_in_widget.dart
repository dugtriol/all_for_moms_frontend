import 'package:all_for_moms_frontend/utils/provider.dart';
import 'package:all_for_moms_frontend/widgets/auth/auth_model.dart';
import 'package:all_for_moms_frontend/widgets/auth/sign_up_widget.dart';
import 'package:all_for_moms_frontend/widgets/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<AuthModel>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ErrorMessageWidget(),
            SizedBox(
              width: 250,
              child: TextField(
                controller: model?.loginController,
                decoration: const InputDecoration(labelText: 'Логин'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 250,
              child: TextField(
                obscureText: true,
                controller: model?.passwordController,
                decoration: const InputDecoration(labelText: 'Пароль'),
              ),
            ),
            const SizedBox(height: 32),
            const _AuthButtonWidget(),
            TextButton(
              onPressed: () {},
              child: const Text("Забыли пароль?"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const SignUpWidget(),
                    ));
              },
              child: const Text("Зарегистрироваться"),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<AuthModel>(context);
    final child = model?.isAuthProgress == true
        ? const SizedBox(
            child: CircularProgressIndicator(),
            height: 15,
            width: 15,
          )
        : const Text('Войти');
    return ElevatedButton(
      onPressed: () {
        if (model?.canStartAuth == true) {
          model?.auth(context);
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
    final errorMessage =
        NotifierProvider.watch<AuthModel>(context)?.errorMessage;
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
