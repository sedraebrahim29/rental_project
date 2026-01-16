import 'dart:convert';

import 'package:rent/helper/api.dart';

class TopUpService {
  Future<void> topUp({
    required double amount,
    required String token,
    required String lang,
  }) async {
    final response = await Api(languageCode: lang).post(
      url: 'http://127.0.0.1:8000/api/users/topUpBalance',
      token: token,
      body: {
        "amount": amount, // double
      },
    );

    if (response.statusCode != 200) {
      final decoded = jsonDecode(response.body);
      throw Exception(decoded['message'] ?? 'Top up failed');
    }
  }
}
