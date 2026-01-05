import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';

class BookingDatePicker extends StatelessWidget {
   BookingDatePicker({ required this.controller, required this.onPicked,});

  final TextEditingController controller;
   final VoidCallback onPicked;

   @override
  Widget build(BuildContext context) {
    return Container(
width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: MyColor.deepBlue),
      ),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Day :    Mon :    Year : ',
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),),

        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );

          if (date != null) {
            controller.text =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
            onPicked(); //عم اربط ديت بيكر مع حساب السعر
          }
        },
      ),
    );
  }
}
