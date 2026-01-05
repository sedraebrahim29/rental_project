
import 'package:rent/models/conflict_booking_model.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingLoaded extends BookingState {
  final List<BookingDateModel> bookedDates;
  BookingLoaded(this.bookedDates);
}

class BookingSubmitting extends BookingState {}

class BookingSuccess extends BookingState {}

class BookingError extends BookingState {
  final String message;
  BookingError(this.message);
}
