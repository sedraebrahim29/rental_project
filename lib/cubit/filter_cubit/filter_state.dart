import 'package:rent/models/filter_model.dart';

abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  final List<FilteredPropertyModel> properties;
  FilterLoaded(this.properties);
}

class FilterEmpty extends FilterState {}

class FilterError extends FilterState {
  final String message;
  FilterError(this.message);
}
