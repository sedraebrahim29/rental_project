import 'dart:developer';

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
    final t = AppLocalizations.of(context)!; //للترجمة
    return Scaffold(
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

              Text(
                t.filter_results,

                style: TextStyle(
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
                      log('4');
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is FilterError) {
                      log('5');
                      return Center(
                        child: Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    log('3');
                    if (state is FilterEmpty) {
                      return Center(
                        child: Text(
                          t.no_results,
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    if (state is FilterLoaded) {
                      log('7');
                      return ListView.builder(
                        itemCount: state.properties.length,
                        itemBuilder: (context, index) {
                          final prop = state.properties[index];
                          log('blabla');
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
        ),
      ),
    );
  }
}
