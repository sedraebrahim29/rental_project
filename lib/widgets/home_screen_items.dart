import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/categories/details_category.dart';
import 'package:rent/cubit/details_cubit/details_cubit.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/models/property_model.dart';

import '../data/colors.dart';


class HomeScreenItems extends StatelessWidget {
  const HomeScreenItems({super.key, required this.apartment,
    required this.apartmentId,});

  final PropertyModel apartment; //للعرض السريع بالـ Home
  final int apartmentId; //للربط مع صفحة التفاصيل

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;//للترجمة
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => DetailsCubit(),
              child: DetailsCategory(

                apartmentId: apartmentId,
                
                  
              ),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: MyColor.deepBlue, width: 1.5),
        ),
        color: MyColor.offWhite,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: apartment.imageUrls.isNotEmpty
                    ? Image.network(
                  apartment.imageUrls.first,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  'assets/apartment1.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NAME
                    Text(
                      apartment.ownerName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // LOCATION
                    Text(
                      apartment.address,
                      style: TextStyle(color: MyColor.deepBlue),
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // INFO ROW
                    Row(
                      children: [
                        InfoItem(icon: Icons.home, label: apartment.category),
                        SizedBox(width: 12),
                        InfoItem(
                          icon: Icons.square_foot_sharp,
                          label: apartment.area,
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // PRICE
                    Text(
                      '\$${apartment.price} / ${t.per_mon}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: MyColor.deepBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: MyColor.blueGray),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: MyColor.deepBlue)),
      ],
    );
  }
}
