import 'package:flutter/material.dart';
import 'package:rent/data/apartments_data.dart';
import '../../data/colors.dart';
import '../../widgets/home_header.dart';
import '../../widgets/home_screen_items.dart';
import '../../widgets/main_drawer.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.offWhite,
      drawer: const MainDrawer(),
      body: Column(
        children: [
          // CUSTOM HEADER
          const HomeHeader(),

          // LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ApartmentsData.items.length,
              itemBuilder: (context, index) {
                return HomeScreenItems(apartment: ApartmentsData.items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
