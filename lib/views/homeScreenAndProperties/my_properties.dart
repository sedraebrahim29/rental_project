import 'package:flutter/material.dart' hide State;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/add_property_cubit.dart';
import 'package:rent/cubit/property_cubit.dart';
import 'package:rent/views/homeScreenAndProperties/add_property.dart';

import '../../cubit/language_cubit/language_cubit.dart';
import '../../cubit/properties/properties_cubit.dart';

import '../../data/colors.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/property_card.dart';
import 'edit_property.dart';
import 'my_properties_booking_screen.dart';

class MyPropertiesScreen extends StatelessWidget {
  const MyPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final t = AppLocalizations.of(context)!;

    final lang = context.read<LanguageCubit>().state.languageCode;


    return BlocProvider(
      create: (context) => PropertiesCubit()..getProperties(lang),
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
                      context.read<PropertiesCubit>().getProperties(lang);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColor.deepBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
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
                            child: CircularProgressIndicator(color: MyColor.deepBlue,),
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
                            // empty state in RefreshIndicator so user can pull to check 
                            return RefreshIndicator(
                              onRefresh: () async {
                                await context.read<PropertiesCubit>().getProperties(lang);
                              },
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Container(
                                  height: 500, 
                                  alignment: Alignment.center,
                                  child:  Text(
                                    t.no_properties_yet,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          }

                          return RefreshIndicator(
                            color: MyColor.deepBlue,
                            onRefresh: () async {
                              await context.read<PropertiesCubit>().getProperties(lang);
                            },
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
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
                                          .getProperties(lang);
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
                            ),
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
