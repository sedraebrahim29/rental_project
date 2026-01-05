// import '../../models/booking_model.dart';
//
// enum BookingStatusState { init, loading, success, error }
//
// class BookingState {
//   final BookingStatusState state;
//   final List<BookingModel> bookings;
//   final String error;
//   final BookingStatus currentTab; // Track which button is active
//
//   BookingState({
//     required this.state,
//     this.bookings = const [],
//     this.error = '',
//     this.currentTab = BookingStatus.pending,
//   });
//
//   factory BookingState.init() => BookingState(state: BookingStatusState.init);
//
//   BookingState copyWith({
//     BookingStatusState? state,
//     List<BookingModel>? bookings,
//     String? error,
//     BookingStatus? currentTab,
//   }) {
//     return BookingState(
//       state: state ?? this.state,
//       bookings: bookings ?? this.bookings,
//       error: error ?? this.error,
//       currentTab: currentTab ?? this.currentTab,
//     );
//   }
// }