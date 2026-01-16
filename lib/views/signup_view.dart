import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rent/image_picker/image_picker_method.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/views/login_view.dart';
import 'package:rent/widgets/login_signup_widgets/step_1.dart';
import 'package:rent/widgets/login_signup_widgets/step_2.dart';
import 'package:rent/widgets/login_signup_widgets/step_3.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  int currentStep = 0;
  File? profileImage;
  File? idImage;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PopScope(
      canPop: currentStep == 0,
      onPopInvoked: (didPop) {
        if (didPop) return;

        if (currentStep > 0) {
          setState(() {
            currentStep--;
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // Background Image
            const Positioned.fill(
              child: Image(
                image: AssetImage('assets/login_42_page_1.png'),
                fit: BoxFit.cover,
              ),
            ),

            // Overlay
            Positioned.fill(
              child: Container(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.65)
                    : Colors.black.withValues(alpha: 0.25),
              ),
            ),

            // Content
            Column(
              children: [
                const SizedBox(height: 70),

                Text(
                  t.create_account,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 25,
                    fontFamily: 'DM Serif Display',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),

                IndexedStack(
                  index: currentStep,
                  children: [
                    Step1(
                      firstNameController: firstNameController,
                      lastNameController: lastNameController,
                      birthDateController: birthDateController,
                      onNext: () => setState(() => currentStep = 1),
                    ),
                    Step2(
                      phoneController: phoneController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      onNext: () => setState(() => currentStep = 2),
                    ),
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
                      onSubmit: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginView()),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      t.already_have_account,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: 'DM Serif Display',
                        fontSize: 15,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginView()),
                        );
                      },
                      child: Text(
                        t.login,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontFamily: 'DM Serif Display',
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
