import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent/cubit/add_property_cubit.dart';
import 'package:rent/cubit/details_cubit/details_cubit.dart';
import 'package:rent/cubit/login_cubit/login_cubit.dart';
import 'package:rent/cubit/properties/properties_cubit.dart';
import 'package:rent/cubit/signup_cubit/signup_cubit.dart';

import 'package:rent/views/login_view.dart';

import 'cubit/property_cubit.dart';

void main() {
  runApp(ProviderScope(child: const Rent()));
}

class Rent extends StatelessWidget {
  const Rent({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PropertyCubit()), // شغل زميلك
        BlocProvider(create: (context) => LoginCubit()), // شغلك
        BlocProvider(create: (context) => SignupCubit()), // شغلك
        BlocProvider(create: (context) => DetailsCubit()),
        BlocProvider(create: (context) => AddPropertyCubit()),
        BlocProvider(create: (context) => PropertiesCubit()..getProperties()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginView(),
        // home:
        // Scaffold(
        //
        //   body: Column(
        //     children: [
        //       SizedBox(height: 80,),
        //       BookingBottomSheet(),
        //     ],
        //   ),
        // )

        // home: Profile( apart: PropertyModel(
        //   id: '1',
        //   ownerName: 'Test Owner',
        //   city: 'Damascus',
        //   governorate: 'Damascus',
        //   category: 'Apartment',
        //   amenities: ['WiFi', 'AC', 'Pool'],
        //   area: '120',
        //   price: '500',
        //   beds: '3',
        //   baths: '2',
        //   address: 'Mazzeh, Damascus',
        //   rating: 4.5,
        //   imageUrls: [
        //     'https://via.placeholder.com/300',
        //   ],
        // ), ),

        // home: DetailsCategory(
        //   apartment: PropertyModel(
        //     imageUrls: [
        //
        //     ],
        //     ownerName: 'Test Owner',
        //     address: 'Test Location',
        //     category: 'Apartment',
        //     area: '1200 m2',
        //     price: '120',
        //     baths: '4',
        //     beds: '4',
        //     amenities: ['wifi','ac','pool','wifi','ac','pool','wifi','ac','pool'],
        //     rating: 4.8,
        //
        //   )
        // ),
        //

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
