import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/api_clients/api_client.dart';

class SignUpModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  String? _errorMessage = null;

  String? get errorMessage => _errorMessage;
  bool _isSignUpProgress = false;
  bool get canStartSignUp => !_isSignUpProgress;
  bool get isSignUpProgress => _isSignUpProgress;

  Future<void> signup(BuildContext context) async {
    final login = loginController.text;
    final password = passwordController.text;
    final name = nameController.text;
    final email = emailController.text;
    final dateOfBirth = dateOfBirthController.text;

    if (login.isEmpty || password.isEmpty || name.isEmpty || email.isEmpty) {
      _errorMessage = 'Не все поля заполнены';
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _isSignUpProgress = true;
    notifyListeners();
    String? jwtToken;
    try {
      jwtToken = await _apiClient.signUp(
        username: login,
        password: password,
        name: name,
        email: email,
        dateOfBirth: dateOfBirth,
      );
    } catch (e) {
      _errorMessage = 'Неправильный логин или пароль';
    }

    _isSignUpProgress = false;
    if (_errorMessage != null || jwtToken == null) {
      notifyListeners();
      return;
    }
    Navigator.of(context).pop();
  }
}
