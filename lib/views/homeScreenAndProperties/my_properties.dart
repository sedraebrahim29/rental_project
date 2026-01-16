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
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => PropertiesCubit()..getProperties(),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20, right: 10),
          child: FloatingActionButton.extended(
            backgroundColor: MyColor.deepBlue,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyPropertiesBookingScreen(),
                ),
              );
            },
            label: Text(
              t.my_properties_booking,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        body: Stack(
          children: [
            // Background image
            const Positioned.fill(
              child: Image(
                image: AssetImage('assets/HomeBackground.png'),
                fit: BoxFit.cover,
              ),
            ),

            // Overlay
            Positioned.fill(
              child: Container(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.65)
                    : Colors.black.withValues(alpha: 0.25),
              ),
            ),

            // Content
            Column(
              children: [
                const SizedBox(height: 50),

                /// TITLE
                Text(
                  t.my_properties,
                  style: theme.textTheme.titleLarge?.copyWith(
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
                          child: const AddPropertyScreen(),
                        ),
                      ),
                    ).then((_) {
                      context.read<PropertiesCubit>().getProperties();
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
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
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
                          return const Center(child: CircularProgressIndicator());

                        case State.error:
                          return Center(
                            child: Text(
                              state.error,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.red,
                              ),
                            ),
                          );

                        case State.success:
                          if (state.properties.isEmpty) {
                            return Center(
                              child: Text(
                                t.no_properties_yet,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                ),
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
                                onTap: () {},
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
          ],
        ),
      ),
    );
  }
}
