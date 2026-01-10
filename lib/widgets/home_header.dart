import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent/cubit/filter_cubit/filter_cubit.dart';
import 'package:rent/cubit/filter_cubit/filter_meta_cubit.dart';
import 'package:rent/views/homeScreenAndProperties/my_properties.dart';

import '../data/colors.dart';

import '../views/homeScreenAndProperties/search_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // TOP BAR
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: MyColor.offWhite),
                      onPressed: () {
                        ScaffoldMessenger.of(context);
                        Scaffold.of(context).openDrawer();
                      },
                    ),

                    // SEARCH BAR
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        // provide cubit
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (_) =>
                                      FilterMetaCubit()..loadInitialData(),
                                ),
                              ],
                              child: const SearchScreen(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 250,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: MyColor.offWhite,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'Search',
                          style: TextStyle(
                            color: MyColor.deepBlue, //
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: MyColor.offWhite,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 7),
                Row(
                  children: [
                    //MY PROPERTIES
                    _CategoryButtons(
                      title: "My Properties",
                      textColor: MyColor.deepBlue,
                      color: MyColor.offWhite,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MyPropertiesScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 20),
                    //RENT
                    _CategoryButtons(
                      title: "Rent",
                      color: MyColor.skyBlue,
                      textColor: MyColor.deepBlue,
                      onTap: () {},
                    ),
                    const SizedBox(width: 20),
                    //MESSAGES
                    _CategoryButtons(
                      title: "Messages",
                      color: MyColor.offWhite,
                      textColor: MyColor.deepBlue,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryButtons extends StatelessWidget {
  final String title;
  final Function() onTap;
  final Color color;
  final Color textColor;

  const _CategoryButtons({
    required this.title,
    required this.onTap,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}
