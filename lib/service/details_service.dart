import 'dart:convert';
import 'package:rent/helper/api.dart';
import 'package:rent/models/property_model.dart';

class DetailsService {

  static const String baseUrl = 'http://127.0.0.1:8000/api';

  Future<PropertyModel> getDetails({required int id,required String token,}) async {
    final response = await Api().get(
      url: '$baseUrl/properties/$id',
      token: token,
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return PropertyModel.fromJson(decoded['data']);
    } else {
      throw Exception('Failed to load property details,please try later');
    }
  }
}
