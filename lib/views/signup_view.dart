import 'package:flutter/material.dart';
import 'package:rent/models/textfield_model.dart';
import 'package:rent/widgets/step_1.dart';
import 'package:rent/widgets/step_2.dart';
import 'package:rent/widgets/step_3.dart';
import 'package:rent/widgets/textfieldwidget.dart';

class SignupView extends StatefulWidget {
  const SignupView();

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  int currentStep = 0;




  @override
  Widget build(BuildContext context) {



    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/login_42_page_1.png',),
                fit: BoxFit.cover),),

           child:  Column(
             children: [
               SizedBox(
                 height: 65,
               ),
               Center(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,

                   children: [
                     Container(
                       width: 10,
                       height: 10,
                       decoration: const BoxDecoration(
                         color: Color(0xff011963),
                         shape: BoxShape.circle,
                       ),
                     ),
                     const SizedBox(width: 15),
                     Container(
                       width: 10,
                       height: 10,
                       decoration: const BoxDecoration(
                         color: Colors.white,
                         shape: BoxShape.circle,
                       ),
                     ),
                     const SizedBox(width: 15),
                     Container(
                       width: 10,
                       height: 10,
                       decoration: const BoxDecoration(
                         color: Colors.white,
                         shape: BoxShape.circle,
                       ),
                     ),
                   ],
                 ),),
               SizedBox(height: 14),
               Text('Creat a new account',
                 style: TextStyle(
                   fontSize: 25,
                   fontFamily: 'DM Serif Display',
                   color: Color(0xff011963)
                 ),),
               SizedBox(height: 30),
                IndexedStack(
                   index: currentStep,
                   children: [
                     Step1(),
                     Step2(),
                     Step3(),
                   ],
                 ),


               SizedBox(height: 150,),
          Container(
            height: 60,
            width: 250,

            decoration: BoxDecoration(
              color: Color(0xff011963),
              borderRadius: BorderRadius.circular(28),

            ),
            child: Center(
                child:GestureDetector(
                  onTap: () {
                    if (currentStep < 2) {
                      setState(() {
                        currentStep++;
                      });
                    } else {
                      //هون بدي حط ال api
                      //submitSignup();
                    }
                  },
                  child: Text(
                    currentStep < 2 ? 'Next' : 'Sign up',
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'DM Serif Display',
                    ),
                  ),
                )
            ),
          ),
          const SizedBox(height: 20),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Text('Already have an account ? ',
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
                     child: const Text('Log in',
                       style: TextStyle(
                           fontSize: 23,
                           fontFamily: 'DM Serif Display',
                           color: Color(0xff011963)
                       ),),
                   )
                 ],
               ),
               ]
           )
        ),

    );
  }
}
