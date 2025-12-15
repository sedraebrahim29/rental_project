import 'package:flutter/material.dart';
import 'package:rent/models/textfield_model.dart';

import 'package:rent/widgets/textfieldwidget.dart';

class Step1 extends StatelessWidget {
   Step1({super.key});

   final firstName = TextFieldModel(text: 'Your first name', hintText: 'Enter your first name');
   final lastNmae = TextFieldModel(text: 'Your last name', hintText: 'Enter your last name');

   final TextEditingController birthdayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Textfieldwidget(firstName),
      SizedBox(height: 25),
      Textfieldwidget(lastNmae),
      SizedBox(height: 25),


      Padding(
        padding: const EdgeInsets.only(right: 200,bottom: 5),
        child: Text('Your birthday',

          style: TextStyle(
              fontSize: 17,
              fontFamily:'DM Serif Display',
              color: Colors.white
          ),),
      ),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: TextField(
          controller: birthdayController,
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: 'Day / Month / Year',
            hintStyle: TextStyle(
                fontFamily: 'DM Serif Display',
                fontSize: 17,
                color: Color(0xff5B7CA9)
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              birthdayController.text =
              '${date.day}/${date.month}/${date.year}';
            }
          },
        ),
      ),
      ],
    );



    }}