import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/filter_cubit/filter_cubit.dart';
import 'package:rent/cubit/filter_cubit/filter_state.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/widgets/filter_widget/filter_property_card.dart';

class FilterResultScreen extends StatefulWidget {
  const FilterResultScreen({super.key});

  @override
  State<FilterResultScreen> createState() => _FilterResultScreenState();
}

class _FilterResultScreenState extends State<FilterResultScreen> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
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

          Column(
            children: [
              const SizedBox(height: 50),

              Text(
                t.filter_results,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 40),

              Expanded(
                child: BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, state) {
                    if (state is FilterLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is FilterError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      );
                    }

                    if (state is FilterEmpty) {
                      return Center(
                        child: Text(
                          t.no_results,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }

                    if (state is FilterLoaded) {
                      return ListView.builder(
                        itemCount: state.properties.length,
                        itemBuilder: (context, index) {
                          final prop = state.properties[index];
                          return FilteredPropertyCard(
                            property: prop,
                            onTap: () {},
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
