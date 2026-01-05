import 'dart:convert';

import 'package:rent/helper/api.dart';
import 'package:rent/models/property_model.dart';

class FilterService {
  Future<List<PropertyModel>> filterProperties({
    int? categoryId,
    int? minPrice,
    int? maxPrice,
    int? governorateId,
    int? cityId,
    List<int>? amenities,
  }) async {
    final body = {
      if (categoryId != null) 'category_id': categoryId,
      if (minPrice != null) 'min_price': minPrice,
      if (maxPrice != null) 'max_price': maxPrice,
      if (governorateId != null) 'governorate_id': governorateId,
      if (cityId != null) 'city_id': cityId,
      if (amenities != null) 'amenities': amenities,
    };

    final response = await Api().post(
      url: 'http://127.0.0.1:8000/api/properties/filter',
      body: body,
    );

    final decoded = jsonDecode(response.body);
    return (decoded['data'] as List)
        .map((e) => PropertyModel.fromJson(e))
        .toList();
  }
}
