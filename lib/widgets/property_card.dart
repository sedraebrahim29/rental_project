import 'package:flutter/material.dart';
import 'package:rent/l10n/app_localizations.dart';
import '../data/colors.dart';
import '../models/property_model.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback? onEdit;
  final VoidCallback onTap;

  const PropertyCard({
    super.key,
    required this.property,
    required this.onTap,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.colorScheme.primary, width: 1.2),
        ),
        child: Row(
          children: [
            // قسم الصور
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: _buildImage(),
            ),
            const SizedBox(width: 12),

            // قسم البيانات
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الاسم + زر التعديل
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property.ownerName,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (onEdit != null)
                        GestureDetector(
                          onTap: onEdit,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              t.edit,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  _buildInfoItem(context, Icons.home, property.category),
                  const SizedBox(height: 2),
                  _buildInfoItem(context, Icons.square_foot_sharp, "${property.area} m²"),

                  const SizedBox(height: 6),

                  // السعر
                  Text(
                    '\$${property.price} / ${t.per_mon}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),

                  // الموقع
                  Text(
                    "${property.city} - ${property.governorate}",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // التقييم
                  Row(
                    children: [
                      const Icon(Icons.star, color: MyColor.warmGold, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        property.rating.toString(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
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

  Widget _buildInfoItem(BuildContext context, IconData icon, String label) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    if (property.localImages != null && property.localImages!.isNotEmpty) {
      return Image.file(
        property.localImages!.first,
        width: 110,
        height: 130,
        fit: BoxFit.cover,
      );
    } else if (property.imageUrls.isNotEmpty) {
      return Image.network(
        property.imageUrls.first,
        width: 110,
        height: 130,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
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
