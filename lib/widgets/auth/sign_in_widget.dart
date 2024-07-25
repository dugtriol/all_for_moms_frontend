import 'package:all_for_moms_frontend/widgets/auth/sign_in_model.dart';
import 'package:all_for_moms_frontend/widgets/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<SignInModel>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _ErrorMessageWidget(),
            SizedBox(
              width: 250,
              child: TextField(
                controller: model.loginController,
                decoration: const InputDecoration(labelText: 'Логин'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 250,
              child: TextField(
                obscureText: true,
                controller: model.passwordController,
                decoration: const InputDecoration(labelText: 'Пароль'),
              ),
            ),
            const SizedBox(height: 32),
            const _AuthButtonWidget(),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, MainNavigationRoutes.signUp);
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
    final model = context.read<SignInModel>();
    final child = model.isAuthProgress == true
        ? const SizedBox(
            child: CircularProgressIndicator(),
            height: 15,
            width: 15,
          )
        : const Text('Войти');
    return ElevatedButton(
      onPressed: () {
        if (model.canStartAuth == true) {
          model.auth(context);
        } else {
          return;
        }
      },
      child: child,
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.watch<SignInModel>().errorMessage;
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
