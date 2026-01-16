import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/language_cubit/language_cubit.dart';
import 'package:rent/cubit/signup_cubit/signup_cubit.dart';
import 'package:rent/cubit/signup_cubit/signup_state.dart';
import 'package:rent/l10n/app_localizations.dart';

class Step3 extends StatelessWidget {
  final VoidCallback onPickProfile;
  final VoidCallback onPickId;
  final File? profileImage;
  final File? idImage;

  // هاد للتنقل بعد ما تنجح العملية
  final VoidCallback onSubmit;

  const Step3({
    super.key,
    required this.onPickProfile,
    required this.onPickId,
    required this.profileImage,
    required this.idImage,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;//للترجمة
    return Column(
      children: [
        // PROFILE IMAGE
         Padding(
          padding: EdgeInsets.only(right: 85, bottom: 4),
          child: Text(
            t.your_photo,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'DM Serif Display',
            ),
          ),
        ),
        GestureDetector(
          onTap: onPickProfile,
          child: imageBox(profileImage),
        ),

        const SizedBox(height: 25),

        //  ID IMAGE
         Padding(
          padding: EdgeInsets.only(right: 70, bottom: 4),
          child: Text(
            t.your_id_photo,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontFamily: 'DM Serif Display',
            ),
          ),
        ),
        GestureDetector(
          onTap: onPickId,
          child: imageBox(idImage),
        ),

        const SizedBox(height: 135),

        // integrate cubit
        BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              onSubmit(); // navigation
            }

            if (state is SignupError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is SignupLoading) {
              return const CircularProgressIndicator(color: Colors.white);
            }

            return Container(
              height: 60,
              width: 250,
              decoration: BoxDecoration(
                color: const Color(0xff011963),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    if (profileImage == null || idImage == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text(t.select_image)),
                      );
                      return;
                    }
                    final lang =  context.read<LanguageCubit>().state.languageCode;
                    //  trigger cubit
                    context.read<SignupCubit>().signup(
                      image: profileImage!,
                      idImage: idImage!,
                      lang: lang,
                    );
                  },
                  child:  Text(
                    t.signup,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'DM Serif Display',
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  //  IMAGE BOX
  Widget imageBox(File? image) {
    return Center(
      child: Container(
        height: 120,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          image: image != null
              ? DecorationImage(
            image: FileImage(image),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: image == null ? const Icon(Icons.camera_alt) : null,
      ),
    );
  }
}
