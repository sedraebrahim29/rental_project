import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/properties/properties_cubit.dart' hide State;
import '../../cubit/properties/properties_cubit.dart' as cubit_state show State;

import '../../data/colors.dart';
import '../../models/my_properties_booking_model.dart';
import '../../widgets/my_properties_booking_card.dart';

class MyPropertiesBookingScreen extends StatefulWidget {
  final String propertyId;

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

      body: BlocConsumer<PropertiesCubit, PropertiesState>(
        listener: (context, state) {
          // 1. Show Success Message
          if (state.successMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
          }
          // 2. Show Error Message (if any new error occurs)
          if (state.state == cubit_state.State.error && state.error.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return Container(
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
                  child: Builder(
                    builder: (context) {
                      // Handle Loading State (Only for initial load)
                      if (state.state == cubit_state.State.loading) {
                        return const Center(child: CircularProgressIndicator(color: Colors.white));
                      }

                      // Pick the correct list based on selection
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
                          child: Text(
                            "No bookings found",
                            style: TextStyle(color: Colors.black45),
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 10, bottom: 80),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          final booking = filteredList[index];
                          return BookingCard(
                            booking: booking,
                            // --- IMPLEMENTED ACTIONS ---
                            onAccept: () {
                              context.read<PropertiesCubit>().approveBooking(booking.id.toString());
                            },
                            onReject: () {
                              context.read<PropertiesCubit>().rejectBooking(booking.id.toString());
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
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