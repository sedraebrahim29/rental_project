import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/models/booking_model.dart';
import 'package:rent/providers/booking_provider.dart';
import 'package:rent/widgets/booking_card.dart';

class MyBooking extends ConsumerWidget {
  const MyBooking({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final selectedStatus = ref.watch(selectedBookingStatusProvider);
    final bookingsAsyncValue = ref.watch(bookingListProvider);

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              image: AssetImage('assets/HomeBackground.png'),
              fit: BoxFit.cover,
            ),
          ),

          // ✅ withValues بدل withOpacity
          Positioned.fill(
            child: Container(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.65)
                  : Colors.black.withValues(alpha: 0.25),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    t.my_booking,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: BookingStatus.values.map((status) {
                      final isSelected = selectedStatus == status;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ChoiceChip(
                          label: Text(
                            status.name.toUpperCase(),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              // ✅ onSurface بدل onBackground
                              color: isSelected
                                  ? Colors.white
                                  : theme.colorScheme.onSurface,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              ref.read(selectedBookingStatusProvider.notifier).state = status;
                            }
                          },
                          selectedColor: theme.colorScheme.primary,
                          // ✅ withValues بدل withOpacity
                          backgroundColor: theme.cardColor.withValues(alpha: 0.9),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                Expanded(
                  child: bookingsAsyncValue.when(
                    loading: () => const Center(child: CircularProgressIndicator()),

                    error: (error, stack) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 40),
                          const SizedBox(height: 10),
                          Text(
                            "${t.error_loading_bookings}\n$error",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              // ✅ استخدم قيمة refresh
                              final _ = ref.refresh(bookingListProvider);
                            },
                            child: Text(t.try_again),
                          )
                        ],
                      ),
                    ),

                    data: (bookings) {
                      if (bookings.isEmpty) {
                        return Center(
                          child: Text(
                            t.no_bookings,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: bookings.length,
                        padding: const EdgeInsets.only(bottom: 20),
                        itemBuilder: (context, index) {
                          return BookingCard(
                            booking: bookings[index],
                            onAction: () {},
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
