import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/signup_cubit/signup_cubit.dart';
import 'package:rent/models/textfield_model.dart';
import 'package:rent/widgets/login_signup_widgets/textfieldwidget.dart';

class Step2 extends StatelessWidget {
  const Step2({
    super.key,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onNext,
  });

  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final phone = TextFieldModel(
      text: 'Phone Number',
      hintText: 'Enter your phone number',
      controller: phoneController,
    );

    final password = TextFieldModel(
      text: 'Your password',
      hintText: 'Enter your password',
      controller: passwordController,
      isPassword: true,
    );

    final confirmPassword = TextFieldModel(
      text: 'Password confirmation',
      hintText: 'Enter your password again',
      controller: confirmPasswordController,
      isPassword: true,
    );

    return Column(
      children: [
        Textfieldwidget(phone),
        const SizedBox(height: 25),
        Textfieldwidget(password),
        const SizedBox(height: 25),
        Textfieldwidget(confirmPassword),

        const SizedBox(height: 155),

        // NEXT BUTTON
        Container(
          height: 60,
          width: 250,
          decoration: BoxDecoration(
            color: const Color(0xff011963),
            borderRadius: BorderRadius.circular(28),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                // trigger cubit (Step 2 data)
                context.read<SignupCubit>().setStep2Data(
                  phoneNumber: phoneController.text,
                  pass: passwordController.text,
                  confirmPass:
                  confirmPasswordController.text,
                );

                onNext();
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontFamily: 'DM Serif Display',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
