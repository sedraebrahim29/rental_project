import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rent/models/textfield_model.dart';
import 'package:rent/views/login_view.dart';
import 'package:rent/widgets/textfieldwidget.dart';

class Step3 extends StatelessWidget {
  final VoidCallback onPickProfile;
  final VoidCallback onPickId;
  final File? profileImage;
  final File? idImage;

  final VoidCallback onSubmit;


  const Step3({
    required this.onPickProfile,
    required this.onPickId,
    required this.profileImage,
    required this.idImage,
    required this.onSubmit,
  });



  @override
  Widget build(BuildContext context) {
    return Column(

      children: [

        Padding(
          padding: const EdgeInsets.only(right: 85,bottom: 4),
          child: const Text('Your photo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontFamily:'DM Serif Display',
          ),),
        ),

        GestureDetector(
          onTap: onPickProfile,
          child: imageBox(profileImage),
        ),

        const SizedBox(height: 25),

        Padding(
          padding: const EdgeInsets.only(right: 70,bottom: 4),
          child: const Text('Your ID photo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily:'DM Serif Display',
            ),),
        ),

        GestureDetector(
          onTap: onPickId,
          child: imageBox(idImage),
        ),
        SizedBox(height: 135,),
        Container(
          height: 60,
          width: 250,

          decoration: BoxDecoration(
            color: Color(0xff011963),
            borderRadius: BorderRadius.circular(28),

          ),
          child: Center(
              child:GestureDetector(
                onTap: onSubmit,

                child: Text(
                  'Sign up' ,
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

  Widget imageBox(File? image) {
    return Center(
      child: Container(
            height: 120,
            width: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              image: image != null
                  ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
                  : null,
            ),
            child :
        image == null ? const Icon(Icons.camera_alt) : null,
        ),
        );
  }
}

