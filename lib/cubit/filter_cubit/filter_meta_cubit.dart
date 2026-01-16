import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rent/cubit/filter_cubit/filter_meta_state.dart';
import 'package:rent/service/filter_service.dart';

// هاد بجبلي الكاتيغوري والمحافظات والمدن والميزات
class FilterMetaCubit extends Cubit<FilterMetaState> {
  FilterMetaCubit() : super(FilterMetaInitial());

  final _service = FilterService();

  Future<void> loadInitialData(String lang) async {
    emit(FilterMetaLoading());
    try {
      final categories = await _service.getCategories(lang);
      final amenities = await _service.getAmenities(lang);
      final governorates = await _service.getGovernorates(lang);

      emit(
        FilterMetaLoaded(
          categories: categories,
          amenities: amenities,
          governorates: governorates,
          cities: [],
        ),
      );
    } catch (e) {
      emit(FilterMetaError(e.toString()));
    }
  }

  Future<void> loadCities(int governorateId,String lang) async {
    if (state is! FilterMetaLoaded) return;

    try {
      final cities = await _service.getCities(governorateId ,lang);

      emit((state as FilterMetaLoaded).copyWith(cities: cities));
    } catch (e) {
      emit(FilterMetaError(e.toString()));
    }
  }
}
