import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/categories/details_category.dart';
import 'package:rent/cubit/details_cubit/details_cubit.dart';
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
    return Scaffold(
      drawer: const MainDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/HomeBackground.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            const HomeHeader(),
            const SizedBox(height: 55),

            Expanded(
              child: BlocBuilder<PropertyCubit, PropertyState>(
                builder: (context, state) {
                  // 1. Loading State
                  if (state is PropertyLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: MyColor.deepBlue),
                    );
                  }

                  // 2. Error State
                  if (state is PropertyError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  // 3. Success State
                  if (state is PropertyUpdated) {
                    final allProperties = state.properties;

                    if (allProperties.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Properties Available",
                          style: TextStyle(
                            color: MyColor.deepBlue,
                            fontSize: 18,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: allProperties.length,
                      itemBuilder: (context, index) {
                        final prop = allProperties[index];

                        return PropertyCard(
                          property: prop,
                          // Only onTap is provided.
                          // onEdit is NOT provided, so the edit button remains hidden.
                          onTap: () {
                            final int id = int.parse(allProperties[index].id!);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => DetailsCubit(),
                                  child: DetailsCategory(apartmentId: (id)),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }

                  // 4. Initial State
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
