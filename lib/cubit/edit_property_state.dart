import 'dart:io';

abstract class EditPropertyState {}

class EditPropertyInitial extends EditPropertyState {}

class EditPropertyLoading extends EditPropertyState {}

// This state holds the data needed for the UI to render
class EditPropertyLoaded extends EditPropertyState {
  final List<File> newImages;
  final List<int> selectedAmenityIds;
  final int? selectedCategoryId;

  // We pass these so the UI knows what to show in Dropdowns/Chips
  final List<Map<String, dynamic>> allCategories;
  final List<Map<String, dynamic>> allAmenities;

  EditPropertyLoaded({
    this.newImages = const [],
    this.selectedAmenityIds = const [],
    this.selectedCategoryId,
    this.allCategories = const [],
    this.allAmenities = const [],
  });

  // Helper to copy state easily
  EditPropertyLoaded copyWith({
    List<File>? newImages,
    List<int>? selectedAmenityIds,
    int? selectedCategoryId,
    List<Map<String, dynamic>>? allCategories,
    List<Map<String, dynamic>>? allAmenities,
  }) {
    return EditPropertyLoaded(
      newImages: newImages ?? this.newImages,
      selectedAmenityIds: selectedAmenityIds ?? this.selectedAmenityIds,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      allCategories: allCategories ?? this.allCategories,
      allAmenities: allAmenities ?? this.allAmenities,
    );
  }
}

class EditPropertyUpdating extends EditPropertyState {}

class EditPropertySuccess extends EditPropertyState {}

class EditPropertyError extends EditPropertyState {
  final String message;
  EditPropertyError(this.message);
}