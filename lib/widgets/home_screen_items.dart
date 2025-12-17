import 'package:flutter/material.dart';

import '../data/colors.dart';
import '../models/apartment.dart';

class HomeScreenItems extends StatelessWidget {
  const HomeScreenItems({super.key, required this.apartment});

  final Apartment apartment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                child: Image.asset(
                  apartment.image,
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
                      apartment.owner,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // LOCATION
                    Text(
                      apartment.location,
                      style: TextStyle(color: MyColor.deepBlue),
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // INFO ROW
                    Row(
                      children: [
                        InfoItem(icon: Icons.home, label: apartment.type),
                        SizedBox(width: 12),
                        InfoItem(
                          icon: Icons.square_foot_sharp,
                          label: apartment.size,
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // PRICE
                    Text(
                      '\$${apartment.price} / per mon',
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
