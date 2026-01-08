import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/booking_model.dart';
import '../core/repos/my_booking_repo.dart';

// 1. Provider for the Repository
final bookingRepoProvider = Provider<BookingRepo>((ref) => BookingRepo());

// 2. Provider to track the currently selected Tab (Pending, Current, etc.)
final selectedBookingStatusProvider = StateProvider<BookingStatus>((ref) {
  return BookingStatus.pending; // Default tab
});

// 3. FutureProvider that watches the Tab and fetches data automatically
// When 'selectedBookingStatusProvider' changes, this provider re-runs!
final bookingListProvider = FutureProvider.autoDispose<List<BookingModel>>((ref) async {
  // Watch the status - if it changes, this function executes again
  final status = ref.watch(selectedBookingStatusProvider);
  final repo = ref.read(bookingRepoProvider);

  // Call the repo
  return await repo.getBookingsByStatus(status);
});