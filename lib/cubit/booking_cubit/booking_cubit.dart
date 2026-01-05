import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/booking_cubit/booking_state.dart';
import 'package:rent/helper/token_storage.dart';
import 'package:rent/service/booking_service.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());
// get
  Future<void> loadBookings(int propertyId) async {
    emit(BookingLoading());
    try {
      final token = await TokenStorage.getToken();
      if (token == null) throw Exception('No token');

      final bookings = await BookingService().getPropertyBookings(
        propertyId: propertyId,
        token: token,
      );

      emit(BookingLoaded(bookings));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
// post
  Future<void> submitBooking({
    required String startDate,
    required String endDate,
    required String pricePerNight,
    required String totalPrice,
    required int propertyId,
    required int governorateId,
    required int cityId,
  }) async {
    emit(BookingLoading());
    try {
      final token = await TokenStorage.getToken();
      if (token == null) throw Exception('No token');

      await BookingService().createBooking(
        startDate: startDate,
        endDate: endDate,
        pricePerNight: pricePerNight,
        totalPrice: totalPrice,
        propertyId: propertyId,
        governorateId: governorateId,
        cityId: cityId,
        token: token,
      );

      emit(BookingSuccess());
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
