import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/add_property_cubit.dart';
import 'package:rent/views/homeScreenAndProperties/add_property.dart';

import '../../cubit/property_cubit.dart';
import '../../cubit/property_state.dart';
import '../../data/colors.dart';
import '../../widgets/property_card.dart';
import 'edit_property.dart';

class MyPropertiesScreen extends StatelessWidget {
  const MyPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                );
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
              child: BlocBuilder<PropertyCubit, PropertyState>(
                builder: (context, state) {
                  if (state is PropertyUpdated) {
                    if (state.properties.isEmpty) {
                      return const Center(child: Text('No properties yet'));
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
                              MaterialPageRoute(builder: (context) => EditPropertyScreen(property: prop)),
                            );
                          },
                          onTap: () {
                            // الانتقال لصفحة التفاصيل
                          },
                        );
                      },
                    );
                  }

                  return const Center(child: Text('No properties yet'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
