import 'package:flutter/material.dart';

import '../../data/apartments_data.dart';
import '../../widgets/home_header.dart';
import '../../widgets/home_screen_items.dart';
import '../../widgets/main_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/HomeBackground.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            // CUSTOM HEADER
            const HomeHeader(),
            const SizedBox(height: 20),
            // LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: ApartmentsData.items.length,
                itemBuilder: (context, index) {
                  return HomeScreenItems(
                    apartment: ApartmentsData.items[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
