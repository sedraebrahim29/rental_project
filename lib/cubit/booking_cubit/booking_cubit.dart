import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/booking_cubit/booking_state.dart';
import 'package:rent/helper/secure_storage_service.dart';

import 'package:rent/service/booking_service.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());
// get هي دالة للتاريخ المحجوز والمحافظات
  Future<void> loadInitialData(int propertyId) async {

    emit(BookingLoading());
    try {
      final String token = await SecureStorage.getToken();
      final bookings = await BookingService().getPropertyBookings(
        propertyId: propertyId,
        token: token,
      );

      final governorates =
      await BookingService().getAllGovernorates(token);

      emit(BookingLoaded( bookedDates: bookings,
        governorates: governorates,
        cities: [],));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
  // get هي دالة للمدن لحال بجبلي ياهن بعد ما اختار المحافظة
  Future<void> loadCities(int governorateId) async {
    if (state is! BookingLoaded) return;

    final current = state as BookingLoaded;
    final token = await SecureStorage.getToken();

    final cities = await BookingService().getCitiesByGovernorate(
      governorateId: governorateId,
      token: token,
    );

    emit(BookingLoaded(
      bookedDates: current.bookedDates,
      governorates: current.governorates,
      cities: cities,
    ));
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
    print("SUBMIT BOOKING CALLED");////////////////
    emit(BookingLoading());
    try {
      final token = await SecureStorage.getToken();

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
