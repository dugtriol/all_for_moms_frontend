import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Token {
  static final Token _instance = Token._internal();
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  factory Token() {
    return _instance;
  }

  Token._internal();

  Future<void> saveToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
  }

  Future<String> getToken() async {
    final token = await storage.read(key: 'jwt_token');
    if (token == null) {
      throw Exception('Token not found');
    }
    // Check if token is expired
    return token;
  }
}
