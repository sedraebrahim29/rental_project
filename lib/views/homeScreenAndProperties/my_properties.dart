import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/add_property_cubit.dart';
import 'package:rent/cubit/property_cubit.dart';
import 'package:rent/views/homeScreenAndProperties/add_property.dart';

import '../../cubit/properties/properties_cubit.dart';

import '../../data/colors.dart';
import '../../widgets/property_card.dart';
import 'edit_property.dart';
import 'my_properties_booking_screen.dart';

class MyPropertiesScreen extends StatelessWidget {
  const MyPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertiesCubit()..getProperties(),
      child: Scaffold(
        body: SizedBox.expand(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/HomeBackground.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),

                /// TITLE
                const Text(
                  'My Properties',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 90),

                /// ADD BUTTON
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => AddPropertyCubit(),
                          child: AddPropertyScreen(),
                        ),
                      ),
                    ).then((_) {
                      /// Refresh list when coming back
                      context.read<PropertiesCubit>().getProperties();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.deepBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      color: MyColor.offWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// LIST
                Expanded(
                  child: BlocBuilder<PropertiesCubit, PropertiesState>(
                    builder: (context, state) {
                      switch (state.state) {
                        case State.loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );

                        case State.error:
                          return Center(
                            child: Text(
                              state.error,
                              style: const TextStyle(color: Colors.red),
                            ),
                          );

                        case State.success:
                          if (state.properties.isEmpty) {
                            return const Center(
                              child: Text(
                                'No properties yet',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: state.properties.length,
                            itemBuilder: (context, index) {
                              final prop = state.properties[index];
                              return PropertyCard(
                                property: prop,
                                onEdit: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider(
                                        create: (context) =>
                                            PropertyCubit()..getAllProperties(),

                                        child: EditPropertyScreen(
                                          property: prop,
                                        ),
                                      ),
                                    ),
                                  ).then((_) {
                                    context
                                        .read<PropertiesCubit>()
                                        .getProperties();
                                  });
                                },

                                // 2. Logic for Booking Button (Navigate with Property ID)
                                onBooking: () {
                                  // Ensure ID is not null or handle error
                                  if (prop.id != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: context
                                              .read<PropertiesCubit>(),
                                          child: MyPropertiesBookingScreen(
                                            propertyId: prop.id!,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },

                                onTap: () {
                                  // الانتقال لصفحة التفاصيل
                                },
                              );
                            },
                          );
                        case State.init:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
