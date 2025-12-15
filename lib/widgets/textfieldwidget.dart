import 'package:flutter/material.dart';
import 'package:rent/models/textfield_model.dart';



class Textfieldwidget extends StatefulWidget {
   Textfieldwidget(this.tx);

final TextFieldModel tx;

  @override
  State<Textfieldwidget> createState() => _TextfieldwidgetState();
}

class _TextfieldwidgetState extends State<Textfieldwidget> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
    Padding(
    padding: const EdgeInsets.only(left: 45,bottom: 5),
    child: Text(widget.tx.text,
    style: TextStyle(
      color: Colors.white,
      fontFamily: 'DM Serif Display',
      fontSize: 17
    ),),
    ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: TextField(
      obscureText: widget.tx.isPassword ? obscure : false,
      cursorColor: Color(0xff5B7CA9),
    decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,

        hintText: widget.tx.hintText,
        hintStyle: TextStyle(
          color: Color(0xff5B7CA9),
          fontFamily: 'DM Serif Display',
            fontSize: 17
        ),
  ////////////////////////////////////////////
    suffixIcon: widget.tx.isPassword
    ? IconButton(
    icon: Icon(
    obscure
    ? Icons.visibility_off
        : Icons.visibility,
    ),
    onPressed: () {
    setState(() {
    obscure = !obscure;
    });
    },
    )
        : null,
///////////////////////////////////////


    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),


    )
    ),
    ),
    ),
        ],
    );
}}
