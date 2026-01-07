import 'dart:io';

import '../models/property_model.dart';

abstract class PropertyState {}

class PropertyInitial extends PropertyState {}

//  جلب البيانات أو رفعها
class PropertyLoading extends PropertyState {}

class PropertyImagesUpdated extends PropertyState {
  final List<File> images;
  PropertyImagesUpdated(this.images);
}

class PropertyUpdated extends PropertyState {
  final List<PropertyModel> properties;
  PropertyUpdated(this.properties);
}

class PropertySubmitting extends PropertyState {}

class PropertySuccess extends PropertyState {}
//  عند حدوث خطأ
class PropertyError extends PropertyState {
  final String message;
  PropertyError(this.message);
}