import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';

class DropDown extends StatelessWidget {
  const DropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 65),
        child: Container(
          height: 45,
      
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: MyColor.deepBlue),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(''),
              Center(child: Icon(Icons.keyboard_arrow_down)),
            ],
          ),
        ),
      ),
    );
  }
}
