import 'package:flutter/material.dart';
import 'package:rent/views/login_view.dart';

void main() {
  runApp(const Rent());
}

class Rent extends StatelessWidget {
  const Rent({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );

  }
}

  
