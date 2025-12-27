import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';

class HelperChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const HelperChip({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: MyColor.blueGray),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
