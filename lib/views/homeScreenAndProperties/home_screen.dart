import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  // جلب القائمة من الـ State
                  if (state is PropertyUpdated) {
                    final allProperties = state.properties;

                    if (allProperties.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Properties Available",
                          style: TextStyle(color: MyColor.offWhite, fontSize: 18),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: allProperties.length,
                      itemBuilder: (context, index) {
                        final prop = allProperties[index];

                        //  تمرير الموديل  للـ Card
                        return PropertyCard(
                          property: prop,
                          onTap: () {
                            //  الانتقال لصفحة التفاصيل
                          },
                        );
                      },
                    );
                  }

                  // في حال كانت  Initial أو Loading
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}