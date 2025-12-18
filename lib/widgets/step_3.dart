import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rent/models/textfield_model.dart';
import 'package:rent/widgets/textfieldwidget.dart';

class Step3 extends StatelessWidget {
  final VoidCallback onPickProfile;
  final VoidCallback onPickId;
  final File? profileImage;
  final File? idImage;

  const Step3({
    required this.onPickProfile,
    required this.onPickId,
    required this.profileImage,
    required this.idImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [

        Padding(
          padding: const EdgeInsets.only(left: 7),
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
          padding: const EdgeInsets.only(left: 18),
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
      ],
    );
  }

  Widget imageBox(File? image) {
    return Padding(
      padding: const EdgeInsets.only(left: 100,top: 5),
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

