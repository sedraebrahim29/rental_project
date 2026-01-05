import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';

class Input extends StatelessWidget {
  const Input({this.hint = ''});
  final String hint ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        //border: Border.all(color: Colors.grey.shade400),
      ),
      child: TextField(
        cursorColor: MyColor.deepBlue,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,

        ),
      ),
    );
  }
}
