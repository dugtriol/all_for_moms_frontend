import 'package:all_for_moms_frontend/widgets/screens.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? _loginController;
  TextEditingController? _passwordController;

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              child: TextField(
                controller: _loginController,
                decoration: InputDecoration(labelText: 'Login'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 250,
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _completeLogin();
                print(_loginController?.text);
                print(_passwordController?.text);
              },
              child: const Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }

  void _completeLogin() {
    Navigator.pushReplacement<void, void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const HomeScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _loginController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }
}
