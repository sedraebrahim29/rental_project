import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/repos/add_property_repo.dart';
import '../../core/repos/edit_property_repo.dart';
import '../../models/property_model.dart';
import 'edit_property_state.dart';

class EditPropertyCubit extends Cubit<EditPropertyState> {
  EditPropertyCubit() : super(EditPropertyInitial());

  final EditPropertyRepo _editRepo = EditPropertyRepo();
  final AddPropertyRepo _addRepo = AddPropertyRepo();
  final ImagePicker _picker = ImagePicker();

  // Controllers
  final areaCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final bedsCtrl = TextEditingController();
  final bathsCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  // --- PUBLIC DATA (UI reads these directly) ---
  List<Map<String, dynamic>> allCategories = [];
  List<Map<String, dynamic>> allAmenities = [];
  List<File> newImages = [];         // Renamed from _newImages
  List<int> selectedAmenityIds = []; // Renamed from _selectedAmenityIds
  int? selectedCategoryId;// Renamed from _selectedCategoryId
  List<String> existingImages = [];
  late PropertyModel _currentProperty;

  // 1. Initialize
  Future<void> init(String propertyId) async {
    emit(EditPropertyLoading());
    try {
      final results = await Future.wait([
        _editRepo.getPropertyById(propertyId),
        _addRepo.getCategories(),
        _addRepo.getAmenities(),
      ]);

      _currentProperty = results[0] as PropertyModel;
      allCategories = results[1] as List<Map<String, dynamic>>;
      allAmenities = results[2] as List<Map<String, dynamic>>;

      // Map to Controllers
      areaCtrl.text = _currentProperty.area;
      priceCtrl.text = _currentProperty.price;
      bedsCtrl.text = _currentProperty.beds;
      bathsCtrl.text = _currentProperty.baths;
      addressCtrl.text = _currentProperty.address;

      // Map ID selections
      final catIndex = allCategories.indexWhere((e) => e['name'] == _currentProperty.category);
      if (catIndex != -1) selectedCategoryId = allCategories[catIndex]['id'];

      selectedAmenityIds = [];
      for (var amenityName in _currentProperty.amenities) {
        final amIndex = allAmenities.indexWhere((e) => e['name'] == amenityName);
        if (amIndex != -1) selectedAmenityIds.add(allAmenities[amIndex]['id']);
      }
      // Load existing images
      existingImages = List.from(_currentProperty.imageUrls);
      emit(EditPropertyLoaded());
    } catch (e) {
      emit(EditPropertyError("Failed to load: $e"));
    }
  }

  // 2. Methods
  void changeCategory(int? id) {
    selectedCategoryId = id;
    emit(EditPropertyLoaded()); // Trigger rebuild
  }

  void toggleAmenity(int id) {
    if (selectedAmenityIds.contains(id)) {
      selectedAmenityIds.remove(id);
    } else {
      selectedAmenityIds.add(id);
    }
    emit(EditPropertyLoaded());
  }

  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      newImages.add(File(picked.path));
      emit(EditPropertyLoaded());
    }
  }

  void removeNewImage(File file) {
    newImages.remove(file);
    emit(EditPropertyLoaded());
  }
  //to remove old images
  void removeExistingImage(String url) {
    existingImages.remove(url);
    emit(EditPropertyLoaded());
  }

  // 3. Update
  Future<void> updateProperty() async {
    emit(EditPropertyUpdating()); // <--- This state no longer crashes the UI
    try {
      Map<String, dynamic> body = {
        'price': priceCtrl.text,
        'area': areaCtrl.text,
        'bedrooms': bedsCtrl.text,
        'bathrooms': bathsCtrl.text,
        'address': addressCtrl.text,
        'category_id': selectedCategoryId.toString(),
      };
      for (int i = 0; i < selectedAmenityIds.length; i++) {
        body['amenities[$i]'] = selectedAmenityIds[i].toString();
      }
      await _editRepo.updateProperty(_currentProperty.id!, body, newImages);
      emit(EditPropertySuccess());
    } catch (e) {
      emit(EditPropertyError(e.toString()));
    }
  }

  Future<void> deleteProperty() async {
    try {
      await _editRepo.deleteProperty(_currentProperty.id!);
      emit(EditPropertySuccess());
    } catch (e) {
      emit(EditPropertyError(e.toString()));
    }
  }
}