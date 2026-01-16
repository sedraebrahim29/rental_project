import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/categories/filter_category/type_category.dart';
import 'package:rent/cubit/filter_cubit/filter_cubit.dart';
import 'package:rent/cubit/filter_cubit/filter_meta_cubit.dart';
import 'package:rent/cubit/filter_cubit/filter_meta_state.dart';
import 'package:rent/cubit/language_cubit/language_cubit.dart';
import 'package:rent/data/colors.dart';
import 'package:rent/l10n/app_localizations.dart';
import 'package:rent/views/filter_result.dart';
import 'package:rent/widgets/filter_widget/amenity_item.dart';
import 'package:rent/widgets/filter_widget/drop_down.dart';
import 'package:rent/widgets/filter_widget/filter_info_row.dart';
import 'package:rent/widgets/filter_widget/input.dart';
import 'package:rent/widgets/filter_widget/price_range_slider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int? selectedCategoryId;
  int? selectedGovernorateId;
  int? selectedCityId;
  int? minPrice;
  int? maxPrice;
  List<int> selectedAmenities = [];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!; //للترجمة
    final filterCubit = context.read<FilterCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          t.filter,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: MyColor.offWhite,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/HomeBackground.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: SafeArea(
          child: BlocBuilder<FilterMetaCubit, FilterMetaState>(
            builder: (context, metaState) {
              if (metaState is FilterMetaLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (metaState is FilterMetaError) {
                return Center(child: Text(metaState.message));
              }

              if (metaState is! FilterMetaLoaded) {
                return const SizedBox();
              }

              final categories = metaState.categories;
              final amenities = metaState.amenities;
              final governorates = metaState.governorates;
              final cities = metaState.cities;

              return ListView(
                padding: const EdgeInsets.only(top: 190, right: 20, left: 11),
                children: [
                  /// CATEGORY
                  Text(
                    t.category,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: MyColor.deepBlue,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 18,
                    runSpacing: 10,
                    children: List.generate(categories.length, (index) {
                      final cat = categories[index];
                      final isSelected = selectedCategoryId == cat.id;

                      return TypeCategoryp(
                        title: cat.name,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            selectedCategoryId = cat.id;
                          });
                        },
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  /// PRICE
                  Padding(
                    padding: EdgeInsets.only(right: 240),
                    child: Text(
                      t.pricing_range,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: MyColor.deepBlue,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  PriceRangeSlider(
                    onChanged: (min, max) {
                      minPrice = min;
                      maxPrice = max;
                    },
                  ),

                  const SizedBox(height: 40),

                  /// INPUTS + DROPDOWNS
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        FilterInfoRow(label: t.beds, field: Input()),
                        const SizedBox(height: 10),
                        FilterInfoRow(label: t.baths, field: Input()),
                        const SizedBox(height: 10),
                        FilterInfoRow(label: t.area, field: Input()),
                        const SizedBox(height: 10),

                        /// GOVERNORATE
                        FilterInfoRow(
                          label: t.governorate,
                          field: DropDown(
                            items: governorates.map((e) => e.name).toList(),
                            onSelected: (index) {
                              selectedGovernorateId = governorates[index].id;
                              selectedCityId = null;

                              final lang = context
                                  .read<LanguageCubit>()
                                  .state
                                  .languageCode;
                              context.read<FilterMetaCubit>().loadCities(
                                selectedGovernorateId!,
                                lang,
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// CITY
                        FilterInfoRow(
                          label: t.city,
                          field: DropDown(
                            items: cities.map((e) => e.name).toList(),
                            onSelected: (index) {
                              selectedCityId = cities[index].id;
                            },
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// AMENITIES
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.amenities,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MyColor.deepBlue,
                                ),
                              ),

                              const SizedBox(height: 15),

                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SizedBox(
                                  height: 250,
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 10,
                                          childAspectRatio: 2.6,
                                        ),
                                    itemCount: amenities.length,
                                    itemBuilder: (context, index) {
                                      final amenity = amenities[index];
                                      final isSelected = selectedAmenities
                                          .contains(amenity.id);

                                      return AmenityItem(
                                        title: amenity.name,
                                        isSelected: isSelected,
                                        onTap: () {
                                          setState(() {
                                            if (isSelected) {
                                              selectedAmenities.remove(
                                                amenity.id,
                                              );
                                            } else {
                                              selectedAmenities.add(amenity.id);
                                            }
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // APPLY FILTER
                  Center(
                    child: SizedBox(
                      width: 220,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColor.deepBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        onPressed: () {
                          final filterCubit = context.read<FilterCubit>();
                          final lang = context
                              .read<LanguageCubit>()
                              .state
                              .languageCode;

                          filterCubit.applyFilter(
                            categoryId: selectedCategoryId,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                            governorateId: selectedGovernorateId,
                            cityId: selectedCityId,
                            amenities: selectedAmenities,
                            lang: lang,
                          );

                          log('2');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const FilterResultScreen(),
                            ),
                          );
                        },
                        child: Text(
                          t.apply_filter,
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
