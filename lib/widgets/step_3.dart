import 'package:flutter/material.dart';
import 'package:rent/models/textfield_model.dart';
import 'package:rent/widgets/textfieldwidget.dart';

class Step3 extends StatelessWidget {
   Step3({super.key});

  final id = TextFieldModel(text: 'Your id', hintText: 'Enter your id');

  @override
  Widget build(BuildContext context) {
    return Textfieldwidget(id);
  }
}
