import 'package:flutter/material.dart';
import 'package:rent/models/textfield_model.dart';
import 'package:rent/service/login_service.dart';
import 'package:rent/views/home_view.dart';
import 'package:rent/views/signup_view.dart';
import '../widgets/textfieldwidget.dart';


class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final phoneField = TextFieldModel(
        text: 'Phone Number',
        hintText: 'Enter your phone number',
        controller: phoneController,);

    final passwordField = TextFieldModel(
      text: 'Password',
      hintText: 'Enter your password',
      controller: phoneController,
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

    Container(
      height: 60,
      width: 250,

      decoration: BoxDecoration(
        color: Color(0xff011963),
        borderRadius: BorderRadius.circular(28),

      ),
      child: Center(
      child:GestureDetector(
        onTap: () async {
          final phone = phoneController.text;
          final password = passwordController.text;

          final result = await LoginService().loginService(
            phone: phone,
            password: password,
          );


          // إذا نجح
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeView()),
          );
        },

        child: const
        Text('Login',
        style: TextStyle(
          fontSize: 25,
            fontFamily: 'DM Serif Display',
          color: Colors.white
        ),),
      )),
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
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const SignupView();
            }));
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
