import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent/data/colors.dart';
import 'package:rent/models/booking_model.dart';
import 'package:rent/providers/booking_provider.dart';
import 'package:rent/widgets/booking_card.dart';



class MyBooking extends ConsumerWidget {
  const MyBooking({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the selected tab state
    final selectedStatus = ref.watch(selectedBookingStatusProvider);
    // Watch the API data state (Loading / Data / Error)
    final bookingsAsyncValue = ref.watch(bookingListProvider);

    return Scaffold(
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
                      color: Colors.white // White to match background
                  ),
                ),
              ),

              // --- 5 Buttons Navigation ---
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: BookingStatus.values.map((status) {
                    final isSelected = selectedStatus == status;
                    return GestureDetector(
                      onTap: () {
                        // Update the provider state -> triggers API fetch
                        ref.read(selectedBookingStatusProvider.notifier).state = status;
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? MyColor.deepBlue : Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected
                              ? Border.all(color: Colors.white, width: 1.5)
                              : null,
                        ),
                        child: Text(
                          status.name.toUpperCase() ,
                          style: TextStyle(
                            color: isSelected ? Colors.white : MyColor.deepBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // --- List Area (Handles Loading, Error, Data) ---
              Expanded(
                child: bookingsAsyncValue.when(
                  // 1. Loading State
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: MyColor.deepBlue),
                  ),

                  // 2. Error State
                  error: (error, stack) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 40),
                        const SizedBox(height: 10),
                        Text(
                          "Error loading bookings:\n$error",
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: MyColor.deepBlue),
                        ),
                        TextButton(
                          onPressed: () {
                            // Retry logic: Refresh the provider
                            ref.refresh(bookingListProvider);
                          },
                          child: const Text("Try Again"),
                        )
                      ],
                    ),
                  ),

                  // 3. Success State
                  data: (bookings) {
                    if (bookings.isEmpty) {
                      return const Center(
                        child: Text("No bookings found.", style: TextStyle(color: MyColor.deepBlue)),
                      );
                    }
                    return ListView.builder(
                      itemCount: bookings.length,
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        return BookingCard(
                          booking: bookings[index],
                          onAction: () {
                            // Handle Edit/Cancel/Rate clicks here later
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
