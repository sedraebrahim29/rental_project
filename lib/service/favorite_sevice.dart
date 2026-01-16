import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:rent/core/constant.dart';

class FavoriteService {
  FavoriteService();

  Future<bool> toggleFavorite({
    required int propertyId,
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/properties/favorite/$propertyId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );
    log(response.statusCode.toString());
    //final decod = jsonDecode(response.body);
    log(response.body.toString());
    if (response.statusCode != 200) {
      print('STATUS CODE: ${response.statusCode}');
      print('RAW RESPONSE: ${response.body}');
      log('RAW RESPONSE: ${response.body}');
      throw Exception("${response.statusCode},${response.body}");
    }

    final decoded = jsonDecode(response.body);
    return decoded['data'] as bool;
  }
}
