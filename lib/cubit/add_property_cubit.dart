import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'add_property_state.dart';

class AddPropertyCubit extends Cubit<AddPropertyState> {
  AddPropertyCubit() : super(AddPropertyInitial());

  final ImagePicker _picker = ImagePicker();

  final List<File> images = [];

  String? city, governorate, category ;
  List<String> selectedAmenities = [];

  final List<String> cities = ['Damascus', 'Aleppo', 'Homs', 'Latakia', 'Tortuous'];
  final List<String> governorates = ['Maze', 'Dummar', 'Shahbaa', 'Medan'];
  final List<String> categories = ['House', 'Apartment', 'Villa', 'Studio', 'Chalet'];
  final List<String> amenitiesList = ['WiFi', 'Pool', 'Garden', 'Parking', 'Gym', 'Elevator', 'Balcony'];

  /// controllers
  final areaCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final bedsCtrl = TextEditingController();
  final bathsCtrl = TextEditingController();
  final addressCtrl = TextEditingController();



  void toggleAmenity(String amenity) {
    if (selectedAmenities.contains(amenity)) {
      selectedAmenities.remove(amenity);
    } else {
      selectedAmenities.add(amenity);
    }
    emit(AddPropertyImagesUpdated(List.from(images))); // تحديث الواجهة
  }

  /// IMAGES
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

  ///  SUBMIT
  void submitProperty() async {
    if (images.isEmpty) {
      emit(AddPropertyError('Please add at least one image'));
      return;
    }

    emit(AddPropertySubmitting());

    // هنا نرسل البيانات للـ API

    await Future.delayed(const Duration(seconds: 1));

    emit(AddPropertySuccess());
  }
}
