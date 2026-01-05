import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';

class TypeCategoryp extends StatelessWidget {
  final VoidCallback onTap;

  const TypeCategoryp({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 105,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: MyColor.deepBlue,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
