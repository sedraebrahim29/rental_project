import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/repos/property_repo.dart';
import '../models/property_model.dart';
import '../core/repos/edit_property_repo.dart'; // Update/Delete
import 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  // Use the Repo to talk to API
  final EditPropertyRepo editRepo = EditPropertyRepo();
  final PropertyRepo propertyRepo = PropertyRepo();

  PropertyCubit() : super(PropertyInitial()) {
    getAllProperties();
  }

  List<PropertyModel> _properties = [];

  /// 1. Fetch All Properties for Home Screen
  Future<void> getAllProperties() async {
    emit(PropertyLoading());
    try {
      // FIX: Changed from getProperties() to getHomeProperties()
      // This ensures we get the list of ALL properties, not just the user's own.
      _properties = await propertyRepo.getHomeProperties();
      emit(PropertyUpdated(List.from(_properties)));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  /// 2. Edit Property
  Future<void> editProperty(
    String id,
    PropertyModel updated,
    Map<String, String> body,
    List<dynamic> newImages,
  ) async {
    emit(PropertyLoading());
    try {
      // Call the API via Repo
      await editRepo.updateProperty(id, body, newImages.cast());
      // Refresh list from server to ensure data is 100% correct
      await getAllProperties();

      // Update local list for immediate UI change
      // final index = _properties.indexWhere((p) => p.id == id);
      // if (index != -1) {
      //   _properties[index] = updated;
      // }

      emit(PropertyUpdated(List.from(_properties)));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  /// 3. Delete Property
  Future<void> deleteProperty(String id) async {
    emit(PropertyLoading());
    try {
      await editRepo.deleteProperty(id);

      // Remove from local list
      _properties.removeWhere((p) => p.id == id);

      emit(PropertyUpdated(List.from(_properties)));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }
}


