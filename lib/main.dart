import 'package:flutter/material.dart';
import 'package:rent/views/login_view.dart';
import 'package:rent/views/signup_view.dart';

import 'package:rent/views/adminDashboard/admin_dashboard.dart';
import 'package:rent/views/homeScreen/home_screen.dart';

void main() {
  runApp(const Rent());
}

class Rent extends StatelessWidget {
  const Rent({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginView(),
        '/signup': (context) => const SignupView(),
        '/home': (context) => const HomeScreen(),
        '/admin': (context) => const AdminDashboard(),
      },
    );
  }
}
