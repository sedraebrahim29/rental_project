import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoriteService {
  FavoriteService();

  Future<bool> toggleFavorite({
    required int propertyId,
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/properties/favorite/$propertyId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Toggle favorite failed');
    }

    final decoded = jsonDecode(response.body);
    return decoded['data'] as bool;
  }
}
