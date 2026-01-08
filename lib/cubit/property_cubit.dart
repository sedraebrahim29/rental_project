import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/repos/property_repo.dart';
import 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit() : super(PropertyInitial());

  final PropertyRepo propertyRepo = PropertyRepo();

  /// Fetch All Properties for Home Screen
  Future<void> getAllProperties() async {
    emit(PropertyLoading());
    try {
      // Fetch data from Repo
      final properties = await propertyRepo.getHomeProperties();

      // Emit the Loaded state with the list
      emit(PropertyLoaded(properties));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }
}