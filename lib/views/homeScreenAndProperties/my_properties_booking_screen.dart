import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// IMPORTANT: Hide 'State' to avoid conflict with Flutter's State class
import '../../cubit/properties/properties_cubit.dart' hide State;
import '../../cubit/properties/properties_cubit.dart' as cubit_state show State; // Optional if you need the enum

import '../../data/colors.dart';
import '../../models/my_properties_booking_model.dart';
import '../../widgets/my_properties_booking_card.dart';

class MyPropertiesBookingScreen extends StatefulWidget {
  final String propertyId; // Added ID to fetch specific bookings

  const MyPropertiesBookingScreen({
    super.key,
    required this.propertyId,
  });

  @override
  State<MyPropertiesBookingScreen> createState() => _MyPropertiesBookingScreenState();
}

class _MyPropertiesBookingScreenState extends State<MyPropertiesBookingScreen> {
  // 1. Selection State
  BookingStatus _selectedStatus = BookingStatus.pending;

  @override
  void initState() {
    super.initState();
    // Trigger API call when screen loads
    context.read<PropertiesCubit>().getBookings(widget.propertyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/HomeBackground.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50),

            /// HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'My Properties Booking',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// FILTER BUTTONS
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterTab("pending", BookingStatus.pending),
                  _buildFilterTab("current", BookingStatus.current),
                  _buildFilterTab("update-request", BookingStatus.updateRequest),
                ],
              ),
            ),

            const SizedBox(height: 80),

            /// BOOKING LIST
            Expanded(
              child: BlocBuilder<PropertiesCubit, PropertiesState>(
                builder: (context, state) {
                  // Using the full path if needed, or check state type directly
                  if (state.state == cubit_state.State.loading) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white));
                  }

                  if (state.state == cubit_state.State.error) {
                    return Center(
                        child: Text(state.error,
                            style: const TextStyle(color: Colors.red)));
                  }

                  // Pick the correct list
                  List<PropertiesBookingModel> filteredList = [];
                  switch (_selectedStatus) {
                    case BookingStatus.pending:
                      filteredList = state.pendingBookings;
                      break;
                    case BookingStatus.current:
                      filteredList = state.currentBookings;
                      break;
                    case BookingStatus.updateRequest:
                      filteredList = state.updateRequests;
                      break;
                  }

                  if (filteredList.isEmpty) {
                    return const Center(
                        child: Text("No bookings found",
                            style: TextStyle(color: Colors.white)));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 80),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final booking = filteredList[index];
                      return BookingCard(
                        booking: booking,
                        onAccept: () {
                          // TODO: Implement Accept API
                        },
                        onReject: () {
                          // TODO: Implement Reject API
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
    );
  }

  Widget _buildFilterTab(String title, BookingStatus status) {
    final bool isSelected = _selectedStatus == status;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = status;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // Fixed deprecated withOpacity
          color: isSelected ? MyColor.deepBlue : Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: Colors.white, width: 1) : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : MyColor.deepBlue,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}