import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';

class FilterInfoRow extends StatelessWidget {
  const FilterInfoRow({super.key,
    required this.label,
    required this.field,});

final  String label;
final  Widget field;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(
            '$label :',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color:  MyColor.deepBlue,
            ),
          ),
        ),
        Expanded(child: field),
      ],
    );
  }
}
