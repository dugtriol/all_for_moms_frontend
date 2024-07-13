import 'dart:async';

import 'package:all_for_moms_frontend/domain/api_clients/api_client.dart';
import 'package:all_for_moms_frontend/widgets/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class SignInModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  String? _errorMessage = null;

  String? get errorMessage => _errorMessage;
  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<void> auth(BuildContext context) async {
    print('auth');
    final login = loginController.text;
    final password = passwordController.text;

    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Заполните логин или пароль';
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? jwtToken;
    try {
      jwtToken = await _apiClient.signIn(
        username: login.toString(),
        password: password.toString(),
      );
    } catch (e) {
      _errorMessage = 'Неправильный логин или пароль';
    }

    _isAuthProgress = false;
    if (_errorMessage != null || jwtToken == null) {
      notifyListeners();
      return;
    }

    unawaited(Navigator.of(context)
        .pushReplacementNamed(MainNavigationRoutes.mainScreen));
  }
}

// class AuthProvider extends InheritedNotifier {
//   final AuthModel model;
//   const AuthProvider({
//     Key? key,
//     required this.model,
//     required Widget child,
//   }) : super(
//           key: key,
//           notifier: model,
//           child: child,
//         );

//   static AuthProvider? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
//   }

//   static AuthProvider? read(BuildContext context) {
//     final widget =
//         context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
//     return widget is AuthProvider ? widget : null;
//   }
// }

