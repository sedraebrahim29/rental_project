
import 'package:rent/models/city_model.dart';
import 'package:rent/models/conflict_booking_model.dart';
import 'package:rent/models/governorate_model.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<BookingDateModel> bookedDates;
  final List<GovernorateModel> governorates;
  final List<CityModel> cities;

  BookingLoaded({required this.bookedDates,
    required this.governorates,
    required this.cities});
}

class BookingSubmitting extends BookingState {}

class BookingSuccess extends BookingState {}

class BookingError extends BookingState {
  final String message;
  BookingError(this.message);
}
