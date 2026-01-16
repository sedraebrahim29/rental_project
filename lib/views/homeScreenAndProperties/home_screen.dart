import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rent/categories/details_category.dart';
import 'package:rent/cubit/details_cubit/details_cubit.dart';
import 'package:rent/l10n/app_localizations.dart';

import '../../cubit/property_cubit.dart';
import '../../cubit/property_state.dart';
import '../../widgets/home_header.dart';
import '../../widgets/main_drawer.dart';
import '../../widgets/property_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Overlay حسب الثيم
    final overlayColor = theme.brightness == Brightness.dark
        ? Colors.black.withAlpha(210)
        : Colors.white.withAlpha(0);

    return Scaffold(
      drawer: BlocProvider(
        create: (context) => PropertyCubit(),
        child: const MainDrawer(),
      ),
      body: Stack(
        children: [
          // ===== Background Image =====
          Positioned.fill(
            child: Image.asset('assets/HomeBackground.png', fit: BoxFit.cover),
          ),

          // ===== Overlay (Light / Dark) =====
          Positioned.fill(child: Container(color: overlayColor)),

          // ===== Content =====
          Column(
            children: [
              const HomeHeader(),
              const SizedBox(height: 70),

              Expanded(
                child: BlocBuilder<PropertyCubit, PropertyState>(
                  builder: (context, state) {
                    Future<void> refresh() async {
                      await context.read<PropertyCubit>().getAllProperties();
                    }

                    // Loading
                    if (state is PropertyLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.primary,
                        ),
                      );
                    }

                    // Error
                    if (state is PropertyError) {
                      return RefreshIndicator(
                        onRefresh: refresh,
                        color: colorScheme.primary,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Text(
                                state.message,
                                style: TextStyle(
                                  color: colorScheme.error,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    // Success
                    if (state is PropertyLoaded) {
                      final properties = state.properties;

                      if (properties.isEmpty) {
                        return RefreshIndicator(
                          onRefresh: refresh,
                          color: colorScheme.primary,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 40),
                                child: Text(
                                  'No Properties Avalibal',
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: refresh,
                        color: colorScheme.primary,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: properties.length,
                          itemBuilder: (context, index) {
                            final prop = properties[index];

                            return PropertyCard(
                              property: prop,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (_) => DetailsCubit(),
                                      child: DetailsCategory(
                                        apartmentId: int.parse(prop.id!),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
