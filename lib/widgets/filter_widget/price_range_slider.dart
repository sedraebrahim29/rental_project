import 'package:flutter/material.dart';

class PriceRangeSlider extends StatefulWidget {
  final Function(int min, int max) onChanged;

  const PriceRangeSlider({super.key, required this.onChanged});

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  RangeValues priceRange = const RangeValues(10, 90);

  final double min = 10;
  final double max = 90;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final sliderWidth = constraints.maxWidth;

          double startX =
              ((priceRange.start - min) / (max - min)) * sliderWidth;
          double endX =
              ((priceRange.end - min) / (max - min)) * sliderWidth;

          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 1,
                      activeTrackColor: colors.primary,
                      inactiveTrackColor: colors.primary.withAlpha(80),
                      rangeThumbShape: const RoundRangeSliderThumbShape(
                        enabledThumbRadius: 7,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 12,
                      ),
                    ),
                    child: RangeSlider(
                      values: priceRange,
                      min: min,
                      max: max,
                      onChanged: (v) {
                        setState(() {
                          priceRange = v;
                        });

                        widget.onChanged(
                          v.start.toInt(),
                          v.end.toInt(),
                        );
                      },
                    ),
                  ),

                  Positioned(
                    left: startX - 10,
                    top: 24,
                    child: Text(
                      '\$${priceRange.start.toInt()}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                  ),

                  Positioned(
                    left: endX - 10,
                    top: 24,
                    child: Text(
                      '\$${priceRange.end.toInt()}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: colors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
