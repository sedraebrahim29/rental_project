import 'dart:convert';
import 'package:http/http.dart';
import 'package:rent/helper/api.dart';
import 'package:rent/models/signup_model.dart';

class SignupService {
  Future<SignupModel> signup({
    required String firstName,
    required String lastName,
    required String birthday,
    required String phone,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await Api().post(
      url: 'http://192.168.2.187:8000/api/register',
      body: {
        'first_name': firstName,
        'last_name': lastName,
        'birthday': birthday,
        'phone': phone,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return SignupModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Signup failed');
    }
  }
}
