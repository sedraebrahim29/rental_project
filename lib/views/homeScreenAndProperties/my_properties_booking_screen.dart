import 'package:flutter/material.dart';
import 'package:rent/l10n/app_localizations.dart';

import '../../data/colors.dart';
import '../../models/my_properties_booking_model.dart';
import '../../widgets/my_properties_booking_card.dart';

class MyPropertiesBookingScreen extends StatefulWidget {
  const MyPropertiesBookingScreen({super.key});

  @override
  State<MyPropertiesBookingScreen> createState() =>
      _MyPropertiesBookingScreenState();
}

class _MyPropertiesBookingScreenState extends State<MyPropertiesBookingScreen> {
  BookingStatus _selectedStatus = BookingStatus.pending;

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
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filteredList =
    _allBookings.where((b) => b.status == _selectedStatus).toList();

    return Scaffold(
      body: Stack(
        children: [
          // Background
          const Positioned.fill(
            child: Image(
              image: AssetImage('assets/HomeBackground.png'),
              fit: BoxFit.cover,
            ),
          ),

          // Overlay
          Positioned.fill(
            child: Container(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.65)
                  : Colors.black.withValues(alpha: 0.25),
            ),
          ),

          // Content
          Column(
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
                          style: theme.textTheme.titleMedium?.copyWith(
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
                    _buildFilterTab(context, t.pending, BookingStatus.pending),
                    _buildFilterTab(context, t.current, BookingStatus.current),
                    _buildFilterTab(
                        context, t.update_request, BookingStatus.updateRequest),
                  ],
                ),
              ),

              const SizedBox(height: 80),

              /// LIST
              Expanded(
                child: filteredList.isEmpty
                    ? Center(
                  child: Text(
                    t.no_bookings_found,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                )
                    : ListView.builder(
                  padding:
                  const EdgeInsets.only(top: 10, bottom: 80),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return BookingCard(
                      booking: filteredList[index],
                      onAccept: () {},
                      onReject: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTab(
      BuildContext context,
      String title,
      BookingStatus status,
      ) {
    final theme = Theme.of(context);
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
          color: isSelected
              ? MyColor.deepBlue
              : theme.cardColor.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: Colors.white, width: 1)
              : null,
        ),
        child: Text(
          title,
          style: theme.textTheme.bodySmall?.copyWith(
            color: isSelected
                ? Colors.white
                : theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
