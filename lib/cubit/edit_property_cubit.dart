import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/repos/add_property_repo.dart'; // Reusing AddRepo for lists
import '../../core/repos/edit_property_repo.dart';
import '../../models/property_model.dart';
import 'edit_property_state.dart';

class EditPropertyCubit extends Cubit<EditPropertyState> {
  EditPropertyCubit() : super(EditPropertyInitial());

  final EditPropertyRepo _editRepo = EditPropertyRepo();
  final AddPropertyRepo _addRepo = AddPropertyRepo(); // Reusing for categories/amenities
  final ImagePicker _picker = ImagePicker();

  // Controllers (Managed by Cubit just like AddPropertyCubit)
  final areaCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final bedsCtrl = TextEditingController();
  final bathsCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  // Local Data Store
  List<Map<String, dynamic>> _categories = [];
  List<Map<String, dynamic>> _amenities = [];
  List<int> _selectedAmenityIds = [];
  int? _selectedCategoryId;
  List<File> _newImages = [];

  // We need to keep the original property to check IDs
  late PropertyModel _currentProperty;

  // 1. Initialize and Fetch Data
  Future<void> init(String propertyId) async {
    emit(EditPropertyLoading());
    try {
      // Fetch Everything in Parallel
      final results = await Future.wait([
        _editRepo.getPropertyById(propertyId), // 0: Property Details
        _addRepo.getCategories(),              // 1: Categories
        _addRepo.getAmenities(),               // 2: Amenities
      ]);

      _currentProperty = results[0] as PropertyModel;
      _categories = results[1] as List<Map<String, dynamic>>;
      _amenities = results[2] as List<Map<String, dynamic>>;

      // --- Map Data to Controllers ---
      areaCtrl.text = _currentProperty.area;
      priceCtrl.text = _currentProperty.price;
      bedsCtrl.text = _currentProperty.beds;
      bathsCtrl.text = _currentProperty.baths;
      addressCtrl.text = _currentProperty.address;

      // --- Map Categories (String to ID) ---
      // We look for the category name in the list and get its ID
      final catIndex = _categories.indexWhere((element) => element['name'] == _currentProperty.category);
      if (catIndex != -1) {
        _selectedCategoryId = _categories[catIndex]['id'];
      }

      // --- Map Amenities (Strings to IDs) ---
      _selectedAmenityIds = [];
      for (var amenityName in _currentProperty.amenities) {
        final amIndex = _amenities.indexWhere((element) => element['name'] == amenityName);
        if (amIndex != -1) {
          _selectedAmenityIds.add(_amenities[amIndex]['id']);
        }
      }

      emit(_buildLoadedState());
    } catch (e) {
      emit(EditPropertyError("Failed to load data: $e"));
    }
  }

  // 2. Handle Inputs
  void changeCategory(int? id) {
    _selectedCategoryId = id;
    emit(_buildLoadedState());
  }

  void toggleAmenity(int id) {
    if (_selectedAmenityIds.contains(id)) {
      _selectedAmenityIds.remove(id);
    } else {
      _selectedAmenityIds.add(id);
    }
    emit(_buildLoadedState());
  }

  // 3. Handle Images
  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      _newImages.add(File(picked.path));
      emit(_buildLoadedState());
    }
  }

  void removeNewImage(File file) {
    _newImages.remove(file);
    emit(_buildLoadedState());
  }

  // Helper to build the loaded state with current data
  EditPropertyLoaded _buildLoadedState() {
    return EditPropertyLoaded(
      newImages: List.from(_newImages),
      selectedAmenityIds: List.from(_selectedAmenityIds),
      selectedCategoryId: _selectedCategoryId,
      allCategories: _categories,
      allAmenities: _amenities,
    );
  }

  // 4. Submit Update
  Future<void> updateProperty() async {
    emit(EditPropertyUpdating());
    try {
      Map<String, dynamic> body = {
        'price': priceCtrl.text,
        'area': areaCtrl.text,
        'bedrooms': bedsCtrl.text,
        'bathrooms': bathsCtrl.text,
        'address': addressCtrl.text,
        'category_id': _selectedCategoryId.toString(),
        // Note: Governorate/City are not updated as per requirements
      };

      // Add amenities
      for (int i = 0; i < _selectedAmenityIds.length; i++) {
        body['amenities[$i]'] = _selectedAmenityIds[i].toString();
      }

      await _editRepo.updateProperty(_currentProperty.id!, body, _newImages);
      emit(EditPropertySuccess());
    } catch (e) {
      emit(EditPropertyError(e.toString()));
    }
  }

  // 5. Delete Property
  Future<void> deleteProperty() async {
    // Usually we want to show a loading indicator for delete too
    try {
      await _editRepo.deleteProperty(_currentProperty.id!);
      emit(EditPropertySuccess()); // Success closes the screen
    } catch (e) {
      emit(EditPropertyError(e.toString()));
    }
  }
}