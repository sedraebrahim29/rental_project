
import 'package:flutter/cupertino.dart';

class TextFieldModel{
  String text;
  String hintText;
  bool isPassword ;
  TextEditingController? controller;



  TextFieldModel({required this.text,required this.hintText,@ required this.controller,this.isPassword = false});
}