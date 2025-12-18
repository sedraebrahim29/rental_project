import 'package:flutter/material.dart';

import '../data/colors.dart';
import '../views/homeScreen/search_screen.dart';

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchScreen(),
                          ),
                        );
                      },
                      child: Container(

                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 16,),
                        decoration: BoxDecoration(
                          color: MyColor.offWhite,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child:
                            Text(
                              'Search',
                              style: TextStyle(
                                color: MyColor.deepBlue,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
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
                    _CategoryButtons(title: "My Properties",color: MyColor.offWhite, onTap: () {}),
                    const SizedBox(width: 20,),
                    _CategoryButtons(title: "Rent",color: MyColor.skyBlue, onTap: () {}),
                    const SizedBox(width: 20,),
                    _CategoryButtons(title: "Messages",color: MyColor.offWhite, onTap: () {}),
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

  const _CategoryButtons({required this.title, required this.onTap, required this.color});

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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColor.deepBlue,
          ),
        ),
      ),
    );
  }
}
