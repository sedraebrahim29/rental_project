import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../core/repos/add_property_repo.dart';
import 'add_property_state.dart';

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit() : super(AddPropertyInitial());

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

  /// 1. Fetch initial data (Govs, Cats, Amenities)
  Future<void> loadInitialData() async {
    emit(AddPropertyLoading());
    try {
      final results = await Future.wait([
        repo.getGovernorates(),
        repo.getCategories(),
        repo.getAmenities(),
      ]);

      governorates = results[0];
      categories = results[1];
      amenitiesList = results[2];

      emit(AddPropertyInitial());
    } catch (e) {

      emit(AddPropertyError("Failed to load data: $e"));
    }
  }

  /// 2. When Governorate changes, fetch Cities
  Future<void> changeGovernorate(int? govId) async {
    if (govId == null) return;
    selectedGovId = govId;
    selectedCityId = null; // Reset city
    cities = []; // Clear old cities

    //emit(AddPropertyLoading());
    // ADD THIS LINE: 
    emit(AddPropertyImagesUpdated(List.from(images)));
    try {
      cities = await repo.getCities(govId);
      emit(AddPropertyInitial());
    } catch (e) {
      emit(AddPropertyError("Failed to load cities $e"));
    }
  }

  /// 3. Toggle Amenities
  void toggleAmenity(int id) {
    if (selectedAmenitiesIds.contains(id)) {
      selectedAmenitiesIds.remove(id);
    } else {
      selectedAmenitiesIds.add(id);
    }
    emit(AddPropertyImagesUpdated(List.from(images))); // Refresh UI
  }

  /// 4. Images
  Future<void> pickImage() async {
    if (images.length >= 6) return;
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      images.add(File(picked.path));
      emit(AddPropertyImagesUpdated(List.from(images)));
    }
  }

  void removeImage(File file) {
    images.remove(file);
    emit(AddPropertyImagesUpdated(List.from(images)));
  }

  /// 5. Submit
  void submitProperty() async {
    if (images.isEmpty) {
      emit(AddPropertyError('Please add at least one image'));
      return;
    }

    emit(AddPropertySubmitting());

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
      emit(AddPropertySuccess());
    } catch (e) {
      emit(AddPropertyError(e.toString()));
    }
  }
}