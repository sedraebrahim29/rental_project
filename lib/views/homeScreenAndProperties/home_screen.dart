import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rent/categories/details_category.dart';
import 'package:rent/cubit/details_cubit/details_cubit.dart';

import 'package:rent/l10n/app_localizations.dart';

import '../../cubit/property_cubit.dart';
import '../../cubit/property_state.dart';
import '../../data/colors.dart';
import '../../widgets/home_header.dart';
import '../../widgets/main_drawer.dart';
import '../../widgets/property_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!; //للترجمة
    return Scaffold(
      drawer: BlocProvider(
        create: (context) => PropertyCubit(),
        child: MainDrawer(),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset('assets/HomeBackground.png', fit: BoxFit.cover),
          ),

          // Content
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

                    if (state is PropertyLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: MyColor.deepBlue,
                        ),
                      );
                    }

                    if (state is PropertyError) {
                      return RefreshIndicator(
                        onRefresh: refresh,
                        color: MyColor.deepBlue,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is PropertyLoaded) {
                      final allProperties = state.properties;

                      if (allProperties.isEmpty) {
                        return RefreshIndicator(
                          onRefresh: refresh,
                          color: MyColor.deepBlue,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: const Center(
                              child: Text(
                                "No Properties Available",
                                style: TextStyle(
                                  color: MyColor.deepBlue,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: refresh,
                        color: MyColor.deepBlue,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: allProperties.length,
                          itemBuilder: (context, index) {
                            final prop = allProperties[index];

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
