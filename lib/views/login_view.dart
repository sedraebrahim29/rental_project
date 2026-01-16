import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/language_cubit/language_cubit.dart';
import 'package:rent/cubit/login_cubit/login_cubit.dart';
import 'package:rent/cubit/login_cubit/login_state.dart';

import 'package:rent/cubit/property_cubit.dart';

import 'package:rent/l10n/app_localizations.dart';

import 'package:rent/models/textfield_model.dart';
import 'package:rent/views/homeScreenAndProperties/home_screen.dart';
import 'package:rent/views/signup_view.dart';
import 'package:rent/widgets/login_signup_widgets/textfieldwidget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!; //للترجمة

    final phoneField = TextFieldModel(
      text: t.phone_number,
      hintText: t.enter_phone_num,
      controller: phoneController,
    );

    final passwordField = TextFieldModel(
      text: t.password,
      hintText: t.enter_pass,
      controller: passwordController,
      isPassword: true,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_42_page_1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 200),
            Textfieldwidget(phoneField),
            const SizedBox(height: 30),
            Textfieldwidget(passwordField),
            const Spacer(flex: 3),

            Container(
              height: 60,
              width: 250,
              decoration: BoxDecoration(
                color: const Color(0xff011963),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                // integrate cubitt
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) async {
                    if (state is LoginSuccess) {
                      context.read<PropertyCubit>().getAllProperties();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    }

                    if (state is LoginError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const CircularProgressIndicator(
                        color: Colors.white,
                      );
                    }

                    return GestureDetector(
                      onTap: () async {
                        final lang = context
                            .read<LanguageCubit>()
                            .state
                            .languageCode;
                        //trigger cubit
                        context.read<LoginCubit>().login(
                          phone: phoneController.text,
                          password: passwordController.text,
                          lang: lang,
                        );
                      },
                      child: Text(
                        t.login,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'DM Serif Display',
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 30),

            // SIGN UP
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  t.dontHaveAccount,
                  style: TextStyle(
                    color: Color(0xff5B7CA9),
                    fontFamily: 'DM Serif Display',
                    fontSize: 15,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupView()),
                    );
                  },
                  child: Text(
                    t.signup,
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'DM Serif Display',
                      color: Color(0xff011963),
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
