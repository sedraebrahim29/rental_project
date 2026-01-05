import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rent/models/signup_model.dart';

class SignupService {
  Future<void> signup({
    required String firstName,
    required String lastName,
    required String birthDate,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required File image,
    required File idImage,
  }) async {
    final uri = Uri.parse('http://192.168.2.187:8000/api/register');
    final request = http.MultipartRequest('POST', uri);

    request.fields.addAll({
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthDate,
      'phone': phone,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });

    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.files.add(await http.MultipartFile.fromPath('ID_image', idImage.path));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(responseBody);
    }
  }
}

