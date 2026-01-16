import 'dart:convert';
import 'dart:developer';
import 'package:rent/helper/api.dart';
import 'package:rent/models/property_model.dart';

class DetailsService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  Future<PropertyModel> getDetails({
    required int id,
    required String token,

    required String lang,
  }) async {
    final response = await Api(
      languageCode: lang,
    ).get(url: '$baseUrl/properties/$id', token: token);

    final decoded = jsonDecode(response.body);
    bool isf = decoded['data']['is_favorite'];
    log(isf.toString());
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      //log(decoded['data']['is_favorite']);
      return PropertyModel.fromJson(decoded['data']);
    } else {
      throw Exception('Failed to load property details,please try later');
    }
  }
}
