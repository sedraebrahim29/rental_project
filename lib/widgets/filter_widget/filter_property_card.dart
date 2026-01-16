import 'package:flutter/material.dart';
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
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: colors.primary, width: 1.2),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: _buildImage(colors),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.ownerName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),
                  _buildInfoItem(context, Icons.home, property.category),
                  const SizedBox(height: 2),
                  _buildInfoItem(context, Icons.square_foot_sharp, "${property.area} m²"),

                  const SizedBox(height: 6),

                  Text(
                    '\$${property.price} /${t.per_mon}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),

                  Text(
                    "${property.city} - ${property.governorate}",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.onSurface.withAlpha(150),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text(
                        property.rating.toString(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.primary,
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
    final colors = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, size: 16, color: colors.onSurface.withAlpha(150)),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colors.primary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildImage(ColorScheme colors) {
    if (property.image.isNotEmpty) {
      return Image.network(
        property.image,
        width: 110,
        height: 130,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Container(width: 110, height: 130, color: colors.surfaceContainerHighest),
      );
    }

    return Container(
      width: 110,
      height: 130,
      color: colors.surfaceContainerHighest,
      child: Icon(Icons.image, color: colors.onSurface.withAlpha(120)),
    );
  }
}
