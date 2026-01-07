import 'dart:convert';

import 'package:rent/helper/api.dart';
import 'package:rent/models/login_model.dart';

class LoginService {
  Future<String> loginService({
    required String phone,
    required String password,
  }) async {
    final response = await Api().post(
      url: 'http://127.0.0.1:8000/api/login',
      body: {'phone': phone, 'password': password},
    );
    final decoded = jsonDecode(response.body);
    String message = decoded['message'];
    if (response.statusCode == 200) {
      String token = decoded['data'];
      print('Token from login=> $token');
      return token;
    } else if (response.statusCode == 500) {
      throw Exception('Server error');
    } else {
      throw Exception(message);
    }
  }
}
