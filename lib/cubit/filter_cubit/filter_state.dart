import 'package:rent/models/property_model.dart';

abstract class FilterState {}
class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  final List<PropertyModel> properties;
  FilterLoaded(this.properties);
}

class FilterEmpty extends FilterState {}


class FilterError extends FilterState {
  final String message;
  FilterError(this.message);
}
