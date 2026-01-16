import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final String languageCode;
  Api({required this.languageCode});

  Future<http.Response> post({
    required String url,
    required dynamic body,
    String? token,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept-Language': languageCode,};

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return await http.post(
      Uri.parse(url),
      body: jsonEncode(body),
      headers: headers,
    );
  }

  // =ADMIN=
  Future<http.Response> get({required String url, String? token}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept-Language': languageCode,
      if (token != null) 'Authorization': 'Bearer $token',
    };

    return await http.get(Uri.parse(url), headers: headers);
  }

  Future<http.Response> patch({required String url, String? token}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept-Language': languageCode,
      if (token != null) 'Authorization': 'Bearer $token',
    };

    return await http.patch(Uri.parse(url), headers: headers);
  }
}
