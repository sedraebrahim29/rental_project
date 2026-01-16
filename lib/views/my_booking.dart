import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';

import '../../models/booking_model.dart';
import '../../widgets/booking_card.dart';
import '../../data/colors.dart';
import '../cubit/myBooking/my_booking_cubit.dart';
import '../cubit/myBooking/my_booking_state.dart';

class MyBooking extends ConsumerWidget {
  const MyBooking({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocProvider(
      create: (context) => MyBookingCubit()..getBookings(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/HomeBackground.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "My Bookings",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White to match background
                    ),
                  ),
                ),

                //  Content Area
                Expanded(
                  child: BlocConsumer<MyBookingCubit, MyBookingState>(
                    listener: (context, state) {
                      if (state is MyBookingError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      // Default values if state is initial
                      var currentStatus = BookingStatus.pending;
                      List<BookingModel> bookings = [];
                      bool isLoading = state is MyBookingLoading;

                      if (state is MyBookingLoaded) {
                        currentStatus = state.selectedStatus;
                        bookings = state.bookings;
                      } else if (state is MyBookingLoading) {
                        currentStatus = state.selectedStatus;
                      } else if (state is MyBookingError) {
                        currentStatus = state.selectedStatus;
                      }

                      return Column(
                        children: [
                          // --- 5 Buttons Navigation ---
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            child: Row(
                              children: BookingStatus.values.map((status) {
                                final isSelected = currentStatus == status;
                                return GestureDetector(
                                  onTap: () {
                                    context.read<MyBookingCubit>().changeTab(
                                      status,
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? MyColor.deepBlue
                                          : Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(20),
                                      border: isSelected
                                          ? Border.all(
                                              color: Colors.white,
                                              width: 1.5,
                                            )
                                          : null,
                                    ),
                                    child: Text(
                                      status.name,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : MyColor.deepBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          const SizedBox(height: 125),

                          // --- List Area ---
                          Expanded(
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: MyColor.deepBlue,
                                    ),
                                  )
                                : bookings.isEmpty
                                ? const Center(
                                    child: Text(
                                      "No bookings found.",
                                      style: TextStyle(color: MyColor.deepBlue),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: bookings.length,
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
                                      top: 10,
                                    ),
                                    itemBuilder: (context, index) {
                                      final booking = bookings[index];
                                      return BookingCard(
                                        booking: booking,
                                        onEdit: () =>
                                            _showEditSheet(context, booking),
                                        onCancel: () =>
                                            _handleCancel(context, booking.id),
                                        onRate: () => _showRateDialog(
                                          context,
                                          booking.property.id!,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- 1. EDIT LOGIC (Bottom Sheet) ---
  void _showEditSheet(BuildContext context, BookingModel booking) {
    final cubit = context.read<MyBookingCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        DateTime selectedStart = booking.fromDate;
        DateTime selectedEnd = booking.toDate;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Edit Booking Dates",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyColor.deepBlue,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Date Pickers
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "From:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () async {
                                final d = await showDatePicker(
                                  context: context,
                                  initialDate: selectedStart,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030),
                                );
                                if (d != null) {
                                  setModalState(() => selectedStart = d);
                                }
                              },
                              child: Text(
                                DateFormat('yyyy-MM-dd').format(selectedStart),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "To:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                              onPressed: () async {
                                final d = await showDatePicker(
                                  context: context,
                                  initialDate: selectedEnd,
                                  firstDate: selectedStart,
                                  lastDate: DateTime(2030),
                                );
                                if (d != null) {
                                  setModalState(() => selectedEnd = d);
                                }
                              },
                              child: Text(
                                DateFormat('yyyy-MM-dd').format(selectedEnd),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColor.deepBlue,
                      ),
                      onPressed: () {
                        cubit.updateBookingDates(
                          booking.id,
                          selectedStart,
                          selectedEnd,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Confirm Changes",
                        style: TextStyle(color: MyColor.offWhite),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // --- 2. CANCEL LOGIC (SnackBar) ---
  void _handleCancel(BuildContext context, String bookingId) {
    context.read<MyBookingCubit>().cancelBooking(bookingId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Booking canceled successfully"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // --- 3. RATE LOGIC (Dialog) ---
  void _showRateDialog(BuildContext context, String bookingId) {
    final cubit = context.read<MyBookingCubit>();
    double rating = 3.0;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Rate your property ",
            style: TextStyle(color: MyColor.deepBlue),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: MyColor.warmGold),
                onRatingUpdate: (r) {
                  rating = r;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColor.deepBlue,
              ),
              onPressed: () {
                cubit.rateBooking(bookingId, rating.toInt());

                Navigator.pop(context);
              },
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
