import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rent/image_picker/image_picker_method.dart';
import 'package:rent/views/login_view.dart';
import 'package:rent/widgets/step_1.dart';
import 'package:rent/widgets/step_2.dart';
import 'package:rent/widgets/step_3.dart';

class SignupView extends StatefulWidget {
  const SignupView();

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  int currentStep = 0;
  File? profileImage;
  File? idImage;

  //////////////////
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
///////////////

  @override
  Widget build(BuildContext context) {

    return WillPopScope(onWillPop:() async {
      if (currentStep > 0) {
        setState(() {
          currentStep--;
        });
        return false; // لا تطلع من الصفحة
      }
      return true; // اطلع من الصفحة
    },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/login_42_page_1.png',),
                  fit: BoxFit.cover),),

             child:  Column(
               children: [
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
                 SizedBox(
                   height: 65,
                 ),

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
                       Step3(
                         profileImage: profileImage,
                         idImage: idImage,
                         onPickProfile: () async {
                           final image = await ImagePickerHelper.pickImage();
                           if (image != null) {
                             setState(() => profileImage = image);
                           }
                         },
                         onPickId: () async {
                           final image = await ImagePickerHelper.pickImage();
                           if (image != null) {
                             setState(() => idImage = image);
                           }
                         },
                       ),
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
                        setState(() => currentStep++);
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) =>  LoginView()),
                        );
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

      ),
    );
  }
}
