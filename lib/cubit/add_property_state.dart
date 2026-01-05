import 'dart:io';

abstract class AddPropertyState {}

class AddPropertyInitial extends AddPropertyState {}

// VERIFY THIS LINE CAREFULLY:
class AddPropertyLoading extends AddPropertyState {}

class AddPropertyImagesUpdated extends AddPropertyState {
  final List<File> images;
  AddPropertyImagesUpdated(this.images);
}

class AddPropertySubmitting extends AddPropertyState {}

class AddPropertySuccess extends AddPropertyState {}

class AddPropertyError extends AddPropertyState {
  final String message;
  AddPropertyError(this.message);
}