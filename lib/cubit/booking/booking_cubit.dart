// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../core/repos/booking_repo.dart';
// import '../../models/booking_model.dart';
//
// import 'booking_state.dart';
//
// class BookingCubit extends Cubit<BookingState> {
//   final BookingRepo _repo = BookingRepo();
//
//   BookingCubit() : super(BookingState.init()) {
//     fetchBookings(BookingStatus.pending);
//   }
//
//   Future<void> fetchBookings(BookingStatus status) async {
//     emit(state.copyWith(state: BookingStatusState.loading, currentTab: status));
//     try {
//       List<BookingModel> result;
//       switch (status) {
//         case BookingStatus.pending: result = await _repo.getPending(); break;
//         case BookingStatus.current: result = await _repo.getCurrent(); break;
//         case BookingStatus.canceled: result = await _repo.getCanceled(); break;
//         case BookingStatus.updateRequest: result = await _repo.getUpdateRequests(); break;
//       }
//       emit(state.copyWith(state: BookingStatusState.success, bookings: result));
//     } catch (e) {
//       emit(state.copyWith(state: BookingStatusState.error, error: e.toString()));
//     }
//   }
// }