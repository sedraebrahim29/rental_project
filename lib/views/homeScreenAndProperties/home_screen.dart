import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      drawer: const MainDrawer(),
      body: Stack(
        children: [
          // Background Image
          const Positioned.fill(
            child: Image(
              image: AssetImage('assets/HomeBackground.png'),
              fit: BoxFit.cover,
            ),
          ),

          // Overlay حسب الوضع
          Positioned.fill(
            child: Container(
              color: isDark
                  ? Colors.black.withOpacity(0.65)
                  : Colors.black.withOpacity(0.25),
            ),
          ),

          // Content
          Column(
            children: [
              const HomeHeader(),
              const SizedBox(height: 55),

              Expanded(
                child: BlocBuilder<PropertyCubit, PropertyState>(
                  builder: (context, state) {
                    if (state is PropertyLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: theme.colorScheme.onBackground,
                        ),
                      );
                    }

                    if (state is PropertyError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
                        ),
                      );
                    }

                    if (state is PropertyUpdated) {
                      final allProperties = state.properties;

                      if (allProperties.isEmpty) {
                        return Center(
                          child: Text(
                            t.no_properties,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onBackground,
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
                            onTap: () {
                              // navigate to details
                            },
                          );
                        },
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
