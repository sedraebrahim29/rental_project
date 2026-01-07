import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../core/repos/add_property_repo.dart';
import '../core/repos/property_repo.dart';
import '../models/property_model.dart';
import '../core/repos/edit_property_repo.dart'; // Update/Delete
import 'property_state.dart';

class PropertyCubit extends Cubit<PropertyState> {
  PropertyCubit() : super(PropertyInitial());

  // Use the Repo to talk to APIdq
  final EditPropertyRepo editRepo = EditPropertyRepo();
  final PropertyRepo propertyRepo = PropertyRepo();
  final AddPropertyRepo repo = AddPropertyRepo();
  final ImagePicker _picker = ImagePicker();

  List<File> images = [];

  // Data Lists from API
  List<Map<String, dynamic>> governorates = [];
  List<Map<String, dynamic>> cities = [];
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> amenitiesList = [];

  // Selected Values (We store IDs now, not Names)
  int? selectedGovId;
  int? selectedCityId;
  int? selectedCatId;
  List<int> selectedAmenitiesIds = [];

  // Controllers
  final areaCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final bedsCtrl = TextEditingController();
  final bathsCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

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

  void toggleAmenity(int id) {
    if (selectedAmenitiesIds.contains(id)) {
      selectedAmenitiesIds.remove(id);
    } else {
      selectedAmenitiesIds.add(id);
    }
    emit(PropertyImagesUpdated(List.from(images))); // Refresh UI
  }

  /// 4. Images
  Future<void> pickImage() async {
    if (images.length >= 6) return;
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      images.add(File(picked.path));
      emit(PropertyImagesUpdated(List.from(images)));
    }
  }

  void removeImage(File file) {
    images.remove(file);
    emit(PropertyImagesUpdated(List.from(images)));
  }

  /// 5. Submit
  void submitProperty() async {
    if (images.isEmpty) {
      emit(PropertyError('Please add at least one image'));
      return;
    }

    emit(PropertySubmitting());

    try {
      Map<String, String> body = {
        'governorate_id': selectedGovId.toString(),
        'city_id': selectedCityId.toString(),
        'category_id': selectedCatId.toString(),
        'area': areaCtrl.text,
        'price': priceCtrl.text,
        'bedrooms': bedsCtrl.text,
        'bathrooms': bathsCtrl.text,
        'address': addressCtrl.text,
      };

      // Add amenities as array
      for (int i = 0; i < selectedAmenitiesIds.length; i++) {
        body['amenities[$i]'] = selectedAmenitiesIds[i].toString();
      }

      await repo.submitProperty(body, images);
      emit(PropertySuccess());
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  /// 2. Edit Property
  Future<void> editProperty(
    String id,
    PropertyModel updated,
    Map<String, dynamic> body,
    List<dynamic> newImages,
  ) async {
    emit(PropertyLoading());
    try {
      // Call the API via Repo
      await editRepo.updateProperty(id, body, newImages.cast());
      // Refresh list from server to ensure data is 100% correct
      await getAllProperties();



      emit(PropertySuccess());
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


// Update local list for immediate UI change
// final index = _properties.indexWhere((p) => p.id == id);
// if (index != -1) {
//   _properties[index] = updated;
// }