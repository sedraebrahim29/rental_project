import 'package:flutter/material.dart';
import 'package:rent/views/homeScreen/home_screen.dart';
import 'package:rent/views/home_view.dart';
import 'package:rent/views/signup_view.dart';

void main() {
  runApp(const Rent());
}

class Rent extends StatelessWidget {
  const Rent({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeView(),      // LogIn
        '/signup': (context) => const SignupView(), // SignUp
        '/home': (context) => const HomeScreen(), // Apartments
      },
    );
  }
}

  
