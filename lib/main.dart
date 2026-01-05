import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rent/views/login_view.dart';
import 'cubit/property_cubit.dart';

void main() {
  runApp(ProviderScope(child: const Rent()));
}

class Rent extends StatelessWidget {
  const Rent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertyCubit(),

      child: MaterialApp(debugShowCheckedModeBanner: false, home: LoginView()),
    );
  }
}
