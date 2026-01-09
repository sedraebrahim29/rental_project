import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/filter_cubit/filter_state.dart';
import 'package:rent/helper/secure_storage_service.dart';
import 'package:rent/service/filter_service.dart';
//هاد مشان نبعت كلشي للباك post
class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterInitial());

  Future<void> applyFilter({
    int? categoryId,
    int? minPrice,
    int? maxPrice,
    int? governorateId,
    int? cityId,
    List<int>? amenities,
  }) async {
    emit(FilterLoading());
    try {
      final token = await SecureStorage.getToken();

      final Map<String, dynamic> body = {
        if (categoryId != null) 'category_id': categoryId,
        if (minPrice != null) 'min_price': minPrice,
        if (maxPrice != null) 'max_price': maxPrice,
        if (governorateId != null) 'governorate_id': governorateId,
        if (cityId != null) 'city_id': cityId,
        if (amenities != null && amenities.isNotEmpty)
          'amenities': amenities,
      };

      final result = await FilterService().filterProperties(
        body: body,
        token: token,
      );

      if (result.isEmpty) {
        emit(FilterEmpty());
      } else {
        emit(FilterLoaded(result));
      }
    } catch (e) {
      emit(FilterError(e.toString()));
    }
  }}
