import 'package:rent/models/property_model.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsSuccess extends DetailsState {
  final PropertyModel apartment;

  DetailsSuccess(this.apartment);
}

class DetailsError extends DetailsState {
  final String message;
  DetailsError(this.message);
}
