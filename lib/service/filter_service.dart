import 'dart:convert';
import 'package:rent/helper/api.dart';
import 'package:rent/models/amenity_model.dart';
import 'package:rent/models/category_model.dart';
import 'package:rent/models/city_model.dart';
import 'package:rent/models/filter_model.dart';
import 'package:rent/models/governorate_model.dart';

class FilterService {
  static const baseUrl = 'http://127.0.0.1:8000/api/properties';

  Future<List<CategoryModel>> getCategories() async {
    final res = await Api().get(url: '$baseUrl/allCategories');
    final decoded = jsonDecode(res.body);
    return (decoded['data'] as List)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }

  Future<List<AmenityModel>> getAmenities() async {
    final res = await Api().get(url: '$baseUrl/allAmenities');
    final decoded = jsonDecode(res.body);
    return (decoded['data'] as List)
        .map((e) => AmenityModel.fromJson(e))
        .toList();
  }

  Future<List<GovernorateModel>> getGovernorates() async {
    final res = await Api().get(url: '$baseUrl/allGovernorates');
    final decoded = jsonDecode(res.body);
    return (decoded['data'] as List)
        .map((e) => GovernorateModel.fromJson(e))
        .toList();
  }

  Future<List<CityModel>> getCities(int governorateId) async {
    final res = await Api().get(url: '$baseUrl/allCities/$governorateId');
    final decoded = jsonDecode(res.body);
    return (decoded['data'] as List).map((e) => CityModel.fromJson(e)).toList();
  }

  Future<List<FilteredPropertyModel>> filterProperties({
    required Map<String, dynamic> body,
    required String token,
  }) async {
    final res = await Api().post(
      url: '$baseUrl/filter',
      body: body,
      token: token,
    );

    final decoded = jsonDecode(res.body);
    return FilteredPropertyModel.fromList(decoded['data']);
  }
}
