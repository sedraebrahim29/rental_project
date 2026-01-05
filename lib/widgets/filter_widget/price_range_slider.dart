import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';

class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({super.key});

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  RangeValues priceRange = const RangeValues(10, 90);

  final double min = 10;
  final double max = 90;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final sliderWidth = constraints.maxWidth;

          // حساب موقع كل دائرة
          double startX =
              ((priceRange.start - min) / (max - min)) * sliderWidth;
          double endX =
              ((priceRange.end - min) / (max - min)) * sliderWidth;

          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  //  Slider
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 1,
                      rangeThumbShape: const RoundRangeSliderThumbShape(
                        enabledThumbRadius: 7,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 12,
                      ),
                    ),
                    child: RangeSlider(
                      activeColor: MyColor.deepBlue,
                      values: priceRange,
                      min: min,
                      max: max,
                      onChanged: (v) {
                        setState(() {
                          priceRange = v;
                        });
                      },
                    ),
                  ),

                  //  الرقم تحت thumb اليسار
                  Positioned(
                    left: startX - 10,
                    top: 24,
                    child: Text(
                      '\$${priceRange.start.toInt()}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: MyColor.deepBlue
                      ),
                    ),
                  ),

                  //  الرقم تحت thumb اليمين
                  Positioned(
                    left: endX - 10,
                    top: 24,
                    child: Text(
                      '\$${priceRange.end.toInt()}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                          color: MyColor.deepBlue
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
