import '../models/property_model.dart';

abstract class PropertyState {}

class PropertyInitial extends PropertyState {}

//  جلب البيانات أو رفعها
class PropertyLoading extends PropertyState {}

class PropertyUpdated extends PropertyState {
  final List<PropertyModel> properties;
  PropertyUpdated(this.properties);
}

//  عند حدوث خطأ
class PropertyError extends PropertyState {
  final String message;
  PropertyError(this.message);
}