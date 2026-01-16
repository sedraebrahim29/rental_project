

import 'package:flutter/material.dart';
import 'package:rent/l10n/app_localizations.dart';

import '../../data/colors.dart';
import '../../models/my_properties_booking_model.dart';
import '../../widgets/my_properties_booking_card.dart';


class MyPropertiesBookingScreen extends StatefulWidget {
  const MyPropertiesBookingScreen({super.key});

  @override
  State<MyPropertiesBookingScreen> createState() => _MyPropertiesBookingScreenState();
}

class _MyPropertiesBookingScreenState extends State<MyPropertiesBookingScreen> {
  // 1. Selection State
  BookingStatus _selectedStatus = BookingStatus.pending;

  // 2. Dummy Data (To Mock API Integration)
  final List<PropertiesBookingModel> _allBookings = [
    PropertiesBookingModel(
      id: '1',
      guestName: 'Ahmad Rahal',
      startDate: '12/5/2024',
      endDate: '15/5/2024',
      pricePerNight: 12,
      totalPrice: 120,
      status: BookingStatus.pending,
    ),
    PropertiesBookingModel(
      id: '2',
      guestName: 'louy ',
      startDate: '10/6/2024',
      endDate: '12/6/2024',
      pricePerNight: 20,
      totalPrice: 40,
      status: BookingStatus.current,
    ),
    PropertiesBookingModel(
      id: '3',
      guestName: 'Sarah ',
      startDate: '01/7/2024',
      endDate: '05/7/2024',
      pricePerNight: 50,
      totalPrice: 200,
      status: BookingStatus.updateRequest,
      newStartDate: '02/7/2024',
      newEndDate: '06/7/2024',
      newTotalPrice: 200,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;//للترجمة
    // Filter list based on selection
    final filteredList = _allBookings.where((b) => b.status == _selectedStatus).toList();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/HomeBackground.png'), // Keeping same bg
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
                  Expanded(
                    child: Center(
                      child: Text(
                        t.my_properties_booking,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Balance back button
                ],
              ),
            ),

            const SizedBox(height: 8),

            /// FILTER BUTTONS
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                // color: Colors.white.withOpacity(0.2), // Optional background for tab bar
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterTab(t.pending, BookingStatus.pending),
                  _buildFilterTab(t.current, BookingStatus.current),
                  _buildFilterTab(t.update_request, BookingStatus.updateRequest),
                ],
              ),
            ),

            const SizedBox(height: 80),

            /// BOOKING LIST
            Expanded(
              child: filteredList.isEmpty
                  ?  Center(child: Text(t.no_bookings_found, style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                padding: const EdgeInsets.only(top: 10, bottom: 80),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return BookingCard(
                    booking: filteredList[index],
                    onAccept: () {
                      // Call API to accept

                    },
                    onReject: () {
                      // Call API to reject

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
          color: isSelected ? MyColor.deepBlue : Colors.white.withOpacity(0.9),
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