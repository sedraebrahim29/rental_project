import 'package:flutter/material.dart';


import 'package:rent/models/textfield_model.dart';
import 'package:rent/views/signup_view.dart';

import '../widgets/textfieldwidget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  //Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final phoneField = TextFieldModel(
        text: 'Phone Number',
        hintText: 'Enter your phone number');

    final passwordField = TextFieldModel(
      text: 'Password',
      hintText: 'Enter your password',
      isPassword: true,
    );

    return Scaffold(
 resizeToAvoidBottomInset: false,
body: Container(
  decoration: BoxDecoration(
    image: DecorationImage(image: AssetImage('assets/login_42_page_1.png',),
        fit: BoxFit.cover),),
child: Column(

  children: [
    const SizedBox(height: 200),
    Textfieldwidget(phoneField),
    const SizedBox(height: 30),
    Textfieldwidget(passwordField),
    const Spacer(flex: 3,),

    GestureDetector(
      onTap: (){
        //هون ربط ال API
        Navigator.pushReplacementNamed(context, '/home');
      },
      child: Container(
        height: 60,
        width: 250,

        decoration: BoxDecoration(
          color: Color(0xff011963),
          borderRadius: BorderRadius.circular(28),

        ),
        child: Center(
        child:const
        Text('Login',
        style: TextStyle(
          fontSize: 25,
            fontFamily: 'DM Serif Display',
          color: Colors.white
        ),)),
      ),
    ),
    const SizedBox(height: 20),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       const Text('Don\'t you have an account?',
        style: TextStyle(
          color: Color(0xff5B7CA9),
          fontFamily: 'DM Serif Display',
          fontSize: 15
        ),),


        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/signup');

        },
          child: const Text('Sing up',
          style: TextStyle(
            fontSize: 23,
              fontFamily: 'DM Serif Display',
              color: Color(0xff011963)
          ),),
        )
      ],
    ),
    Spacer(flex: 2),
  ],

),

)
    );
  }
}
