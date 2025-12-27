import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rent/categories/details_category.dart';
import 'package:rent/cubit/login_cubit/login_cubit.dart';
import 'package:rent/cubit/signup_cubit/signup_cubit.dart';
import 'package:rent/models/apartment.dart';
import 'package:rent/views/login_view.dart';

import 'cubit/property_cubit.dart';

void main() {
  runApp(const Rent());
}

class Rent extends StatelessWidget {
  const Rent({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PropertyCubit()), // شغل زميلك
        BlocProvider(create: (context) => LoginCubit()),    // شغلك
        BlocProvider(create: (context) => SignupCubit()),   // شغلك
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,


        home: DetailsCategory(
          apartment: Apartment(
            image: 'assets/apartment1.jpg',
            owner: 'Test Owner',
            location: 'Test Location',
            type: 'Apartment',
            size: '1200 m2',
            price: 120,
            bathrooms: 4,
            bedrooms: 4,
            amenities: ['wifi','ac','pool','wifi','ac','pool','wifi','ac','pool'],
            rating: 4.8,
          ),
        ),


        // initialRoute: '/login',
        // routes: {
        //   '/login': (context) => LoginView(),
        //   '/signup': (context) => const SignupView(),
        //   '/home': (context) => const HomeScreen(),
        //   '/admin': (context) => const AdminDashboard(),
        // },
      ),
    );
  }
}
