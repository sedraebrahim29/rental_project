import 'dart:convert';


import 'package:rent/helper/api.dart';
import 'package:rent/models/login_model.dart';

class LoginService{

  Future<LoginModel> loginService({required String phone , required String password}) async {
    final response = await Api().post(url: 'http://192.168.2.187:8000/api/login',
        body:
        {'phone': phone,
        'password': password},
        );
    if (response.statusCode == 200) {
      return LoginModel.fromjson(jsonDecode(response.body));
    } else if (response.statusCode == 403) {
      throw Exception('Invalid credentials');
    } else {
      throw Exception('Server error');
    }
  }

  }
