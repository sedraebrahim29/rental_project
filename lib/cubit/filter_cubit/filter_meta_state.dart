import 'package:rent/models/amenity_model.dart';
import 'package:rent/models/category_model.dart';
import 'package:rent/models/city_model.dart';
import 'package:rent/models/governorate_model.dart';

abstract class FilterMetaState {}

class FilterMetaInitial extends FilterMetaState {}

class FilterMetaLoading extends FilterMetaState {}

class FilterMetaLoaded extends FilterMetaState {
  final List<CategoryModel> categories;
  final List<AmenityModel> amenities;
  final List<GovernorateModel> governorates;
  final List<CityModel> cities;

  FilterMetaLoaded({
    required this.categories,
    required this.amenities,
    required this.governorates,
    required this.cities,
  });

  FilterMetaLoaded copyWith({
    List<CategoryModel>? categories,
    List<AmenityModel>? amenities,
    List<GovernorateModel>? governorates,
    List<CityModel>? cities,
  }) {
    return FilterMetaLoaded(
      categories: categories ?? this.categories,
      amenities: amenities ?? this.amenities,
      governorates: governorates ?? this.governorates,
      cities: cities ?? this.cities,
    );
  }
}

class FilterMetaError extends FilterMetaState {
  final String message;
  FilterMetaError(this.message);
}
