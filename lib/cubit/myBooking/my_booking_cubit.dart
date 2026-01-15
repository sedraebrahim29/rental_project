import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/repos/my_booking_repo.dart';
import '../../models/booking_model.dart';
import 'my_booking_state.dart';

class MyBookingCubit extends Cubit<MyBookingState> {
  MyBookingCubit() : super(MyBookingInitial());

  final BookingRepo _repo = BookingRepo();

  // 1. Fetch Bookings (Main Method)
  Future<void> getBookings({
    BookingStatus status = BookingStatus.pending,
  }) async {
    emit(MyBookingLoading(status));
    try {
      final bookings = await _repo.getBookingsByStatus(status);
      emit(MyBookingLoaded(bookings: bookings, selectedStatus: status));
    } catch (e) {
      emit(MyBookingError(e.toString(), status));
    }
  }

  // 2. Change Tab
  void changeTab(BookingStatus status) {
    getBookings(status: status);
  }

  // 3. Cancel Booking
  Future<void> cancelBooking(String bookingId) async {
    // We need the current status to refresh the correct list after cancelling
    final currentStatus = _getCurrentStatus();

    try {
      await _repo.cancelBooking(bookingId);
      // Refresh the list to remove the canceled cards
      getBookings(status: currentStatus);
    } catch (e) {
      emit(MyBookingError("Cancel failed: ${e.toString()}", currentStatus));
    }
  }

  // 4. Update Booking Dates
  Future<void> updateBookingDates(
    String bookingId,
    DateTime newStart,
    DateTime newEnd,
  ) async {
    final currentStatus = _getCurrentStatus();
    try {
      await _repo.updateBooking(bookingId, newStart, newEnd);
      getBookings(status: currentStatus);
    } catch (e) {
      emit(MyBookingError("Update failed: ${e.toString()}", currentStatus));
    }
  }

  // 5. Rate Booking
  Future<void> rateBooking(String prpId, int rating) async {
    final currentStatus = _getCurrentStatus();
    try {
      await _repo.rateBooking(prpId, rating);
      getBookings(status: currentStatus);
    } catch (e) {
      emit(MyBookingError("Rating failed: ${e.toString()}", currentStatus));
    }
  }

  // Helper to get current tab status from state
  BookingStatus _getCurrentStatus() {
    if (state is MyBookingLoaded) {
      return (state as MyBookingLoaded).selectedStatus;
    }
    if (state is MyBookingLoading) {
      return (state as MyBookingLoading).selectedStatus;
    }
    if (state is MyBookingError) {
      return (state as MyBookingError).selectedStatus;
    }
    return BookingStatus.pending; // Default
  }
}
