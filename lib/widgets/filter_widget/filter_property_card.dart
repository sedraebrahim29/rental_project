import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/models/filter_model.dart';

class FilteredPropertyCard extends StatelessWidget {
  final FilteredPropertyModel property;
  final VoidCallback onTap;

  const FilteredPropertyCard({
    super.key,
    required this.property,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;//للترجمة
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: MyColor.offWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: MyColor.deepBlue, width: 1.2),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: _buildImage(),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.ownerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: MyColor.deepBlue,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),
                  _buildInfoItem(Icons.home, property.category),
                  const SizedBox(height: 2),
                  _buildInfoItem(
                    Icons.square_foot_sharp,
                    "${property.area} m²",
                  ),

                  const SizedBox(height: 6),

                  Text(
                    '\$${property.price} /${t.per_mon}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MyColor.deepBlue,
                    ),
                  ),

                  Text(
                    "${property.city} - ${property.governorate}",
                    style: const TextStyle(
                      color: MyColor.blueGray,
                      fontSize: 12,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(Icons.star, color: MyColor.warmGold, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        property.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColor.deepBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: MyColor.blueGray),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(color: MyColor.deepBlue, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (property.image.isNotEmpty) {
      return Image.network(
        property.image,
        width: 110,
        height: 130,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Container(width: 110, height: 130, color: MyColor.blueGray),
      );
    }

    return Container(
      width: 110,
      height: 130,
      color: MyColor.blueGray,
      child: const Icon(Icons.image),
    );
  }
}
