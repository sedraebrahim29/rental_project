import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:rent/helper/api.dart';
import 'package:rent/models/user_model.dart';

class LoginService {
  Future<UserModel> loginService({
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
      String token = decoded['data'][1];
      //print('Token from login=> $token');
      await syncFcmToken(token);
      return UserModel.fromJson(decoded['data']);
    } else if (response.statusCode == 500) {
      throw Exception('Server error');
    } else {
      throw Exception(message);
    }
  }
}

Future<void> syncFcmToken(String accessToken) async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  log('hi1');
  log('token => $accessToken');
  if (fcmToken == null) return;
  log('hi');
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/users/fcm_token/'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },
    body: jsonEncode({'fcm_token': fcmToken.toString()}),
  );
  final decoded = jsonDecode(response.body);
  String message = decoded['message'];
  log(message);
}
