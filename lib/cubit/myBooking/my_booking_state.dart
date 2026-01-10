import '../../models/booking_model.dart';

abstract class MyBookingState {}

class MyBookingInitial extends MyBookingState {}

class MyBookingLoading extends MyBookingState {
  // We keep track of the selected status even during loading to keep the tab highlighted
  final BookingStatus selectedStatus;
  MyBookingLoading(this.selectedStatus);
}

class MyBookingLoaded extends MyBookingState {
  final List<BookingModel> bookings;
  final BookingStatus selectedStatus;

  MyBookingLoaded({required this.bookings, required this.selectedStatus});
}

class MyBookingError extends MyBookingState {
  final String message;
  final BookingStatus selectedStatus;

  MyBookingError(this.message, this.selectedStatus);
}
