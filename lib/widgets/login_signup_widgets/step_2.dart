import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/signup_cubit/signup_cubit.dart';
import 'package:rent/l10n/app_localizations.dart';
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
    final t = AppLocalizations.of(context)!; // للترجمة
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final phone = TextFieldModel(
      text: t.phone_number,
      hintText: t.enter_phone_num,
      controller: phoneController,
    );

    final password = TextFieldModel(
      text: t.password,
      hintText: t.enter_pass,
      controller: passwordController,
      isPassword: true,
    );

    final confirmPassword = TextFieldModel(
      text: t.pass_confirm,
      hintText: t.enter_pass_again,
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
            color: colors.primary,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                // trigger cubit (Step 2 data)
                context.read<SignupCubit>().setStep2Data(
                  phoneNumber: phoneController.text,
                  pass: passwordController.text,
                  confirmPass: confirmPasswordController.text,
                );

                onNext();
              },
              child: Text(
                t.next,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 25,
                  color: colors.onPrimary,
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
