import 'dart:convert';


import 'package:rent/helper/api.dart';
import 'package:rent/models/information_model.dart';

class LoginService{

  Future<InfoModel> loginService({required String phone , required String password}) async {
    final response = await Api().post(url: 'url',
        body:
        {'phone': phone,
        'password': password},
        );
    if (response.statusCode == 200) {
      return InfoModel.fromjson(jsonDecode(response.body));
    } else if (response.statusCode == 403) {
      throw Exception('Invalid credentials');
    } else {
      throw Exception('Server error');
    }
  }

  }
