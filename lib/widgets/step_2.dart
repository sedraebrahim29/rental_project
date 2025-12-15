import 'package:flutter/material.dart';
import 'package:rent/models/textfield_model.dart';
import 'package:rent/widgets/textfieldwidget.dart';

class Step2 extends StatelessWidget {
   Step2({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Textfieldwidget(phone),
        SizedBox(height: 25),
        Textfieldwidget(password),
        SizedBox(height: 25),
        Textfieldwidget(confirmPassword),
      ],
    );
  }
}
