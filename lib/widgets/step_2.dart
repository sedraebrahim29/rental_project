import 'package:flutter/material.dart';
import 'package:rent/models/textfield_model.dart';
import 'package:rent/widgets/step_3.dart';
import 'package:rent/widgets/textfieldwidget.dart';
import 'package:rent/views/signup_view.dart';

class Step2 extends StatelessWidget {
   Step2({required this.onNext});


  final phone = TextFieldModel(
    text: 'Phone Number',
    hintText: 'Enter your phone number',
  );

  final password = TextFieldModel(
    text: 'Your password',
    hintText: 'Enter your password',
    isPassword: true,
  );

  final confirmPassword = TextFieldModel(
    text: 'Password confirmation',
    hintText: 'Enter your password again',
    isPassword: true,
  );

  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Textfieldwidget(phone),
        SizedBox(height: 25),
        Textfieldwidget(password),
        SizedBox(height: 25),
        Textfieldwidget(confirmPassword),

        SizedBox(height: 155,),
        Container(
          height: 60,
          width: 250,

          decoration: BoxDecoration(
            color: Color(0xff011963),
            borderRadius: BorderRadius.circular(28),

          ),
          child: Center(
              child:GestureDetector(
                onTap: onNext,

                child: Text(
                  'Next' ,
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontFamily: 'DM Serif Display',
                  ),
                ),
              )
          ),
        ),


      ],
    );
  }
}
