import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent/cubit/add_property_cubit.dart';
import 'package:rent/cubit/details_cubit/details_cubit.dart';
import 'package:rent/cubit/filter_cubit/filter_cubit.dart';
import 'package:rent/cubit/filter_cubit/filter_meta_cubit.dart';
import 'package:rent/cubit/login_cubit/login_cubit.dart';
import 'package:rent/cubit/profile_cubit/profile_cubit.dart';
import 'package:rent/cubit/properties/properties_cubit.dart';
import 'package:rent/cubit/signup_cubit/signup_cubit.dart';
import 'package:rent/cubit/user_cubit.dart';
import 'package:rent/service/notification_service.dart';
import 'package:rent/views/homeScreenAndProperties/home_screen.dart';

import 'package:rent/views/login_view.dart';
import 'package:rent/views/signup_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'cubit/property_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationsService.init();
  runApp(ProviderScope(child: const Rent()));
}

class Rent extends StatelessWidget {
  const Rent({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PropertyCubit()), // شغل زميلك
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) => LoginCubit(context.read<AuthCubit>()),
        ), // شغلك
        BlocProvider(create: (context) => SignupCubit()), // شغلك
        BlocProvider(create: (context) => DetailsCubit()),
        BlocProvider(create: (context) => AddPropertyCubit()),
        BlocProvider(create: (context) => PropertiesCubit()..getProperties()),
        BlocProvider(create: (context) => FilterCubit()),
        BlocProvider(create: (context) => FilterMetaCubit()..loadInitialData()),
        BlocProvider(create: (context) => ProfileCubit()..getProfile()),
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
        //   ), apartmentId: 1,
        // ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginView(),
          '/signup': (context) => const SignupView(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
