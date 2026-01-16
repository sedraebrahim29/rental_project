import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/booking_cubit/booking_cubit.dart';
import 'package:rent/cubit/language_cubit/language_cubit.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/models/property_model.dart';
import 'package:rent/widgets/details_widgets/booking_bottom_sheet.dart';

class DetailsInfo extends StatelessWidget {
  final PropertyModel apartment;

  const DetailsInfo({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;//للترجمة
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //owner + heart
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  apartment.ownerName,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const Icon(Icons.favorite_border, color: Colors.red),
              ],
            ),

            const SizedBox(height: 6),

            // type + rating
            Row(
              children: [
                Text(
                  apartment.category,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.star, color: Colors.amber, size: 20),
                Text(
                  apartment.rating.toString(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            //location
            Row(
              children: [
                Icon(Icons.location_on,
                    size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 4),
                Text(
                  '${apartment.city ?? ''} - ${apartment.governorate ?? ''}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 5),

// ADDRESS DETAILS
            Text(
              '${t.address_details} : ${apartment.address}',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 11),

            //price
            Text(
              '\$${apartment.price}  ${t.per_night}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(height: 11),

            //bed + bath + area
            Row(
              children: [
                Text(
                  '${t.beds} : ${apartment.beds}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  '${t.baths} : ${apartment.baths}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  '${t.area} : ${apartment.area}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            //amenities
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Text(
                    t.amenities,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    height: 120,
                    width: 150,
                    padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 9,
                        ),
                      ],
                    ),
                    child: Scrollbar(
                      //thumbVisibility: false
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: apartment.amenities.length ,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5,top: 7),
                            child: Row(
                              children: [
                                Icon(Icons.circle,
                                    size: 6,
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
                                const SizedBox(width: 8),
                                Text(
                                  apartment.amenities[index],
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // BOOK BUTTON
            Center(
              child: SizedBox(
                width: 270,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,

                      // provide cubit & trigger cubit
                      //get request(loadInitialData)
                      builder: (context){
                        final lang = context.read<LanguageCubit>().state.languageCode;
                        return BlocProvider(
                          create: (context) => BookingCubit()
                            ..loadInitialData(int.parse(apartment.id!),lang),
                          child: BookingBottomSheet(
                            apartmentId: int.parse(apartment.id!),
                            pricePerNight: apartment.price,
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    t.book,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),

          ] ),
    );
  }
}
