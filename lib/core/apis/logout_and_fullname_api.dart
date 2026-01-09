import 'dart:convert';

import 'package:http/http.dart' as http;
import '../constant.dart';

class LogoutApi {
  Future<void> logout(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/logout"),
        headers: {
          "authorization": "Bearer $token",
          "accept": "application/json",
        },
      );


      if (response.statusCode != 200 && response.statusCode != 401) {
        throw Exception("Logout failed: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }
}

class UserApi {
  Future<String> getUserName(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/users/fullName"), // Endpoint from your screenshot
        headers: {
          "authorization": "Bearer $token",
          "accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // Based on your screenshot, the name is directly in 'data'
        return data['data'].toString();
      } else {
        throw Exception("Failed to get name: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }
}