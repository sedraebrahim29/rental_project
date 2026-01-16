import 'dart:convert';


import 'package:rent/helper/api.dart';
import 'package:rent/models/login_model.dart';

class LoginService{

  Future<String> loginService({
    required String phone ,
    required String password,
    required String lang,}) async {
    final response = await Api(languageCode: lang).post(
      url: 'http://192.168.2.187:8000/api/login',
        body:
        {'phone': phone,
        'password': password},
        );
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return decoded['token'];
    } else if (response.statusCode == 403) {
      throw Exception('Invalid credentials');
    } else {
      throw Exception('Server error');
    }
  }

  }
