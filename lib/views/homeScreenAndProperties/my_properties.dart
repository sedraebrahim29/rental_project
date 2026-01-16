import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/add_property_cubit.dart';
import 'package:rent/l10n/app_localizations.dart';
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
    final t = AppLocalizations.of(context)!;//للترجمة
    return BlocProvider(
      create: (context) => PropertiesCubit()..getProperties(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20, right: 10),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyPropertiesBookingScreen(),
                ),
              );
            },
            backgroundColor: MyColor.deepBlue,
            label: Text(
             t.my_properties_booking,
              style: TextStyle(
                color: MyColor.offWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

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
                Text(
                  t.my_properties,
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
                  child:  Text(
                    t.add,
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
                            return Center(
                              child: Text(
                                t.no_properties_yet,
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
                                      builder: (context) =>
                                          EditPropertyScreen(property: prop),
                                    ),
                                  ).then((_) {
                                    context
                                        .read<PropertiesCubit>()
                                        .getProperties();
                                  });
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
