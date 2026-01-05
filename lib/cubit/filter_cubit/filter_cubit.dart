import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/filter_cubit/filter_state.dart';
import 'package:rent/service/filter_service.dart';

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
      final result = await FilterService().filterProperties(
        categoryId: categoryId,
        minPrice: minPrice,
        maxPrice: maxPrice,
        governorateId: governorateId,
        cityId: cityId,
        amenities: amenities,
      );

      if (result.isEmpty) {
        emit(FilterEmpty());
      } else {
        emit(FilterLoaded(result));
      }
    } catch (e) {
      emit(FilterError(e.toString()));
    }
  }
}
