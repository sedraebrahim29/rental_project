import 'dart:io';

abstract class AddPropertyState {}

class AddPropertyInitial extends AddPropertyState {}


class AddPropertyLoading extends AddPropertyState {}

//  refresh UI when dropdowns change
class AddPropertyUpdated extends AddPropertyState {}

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