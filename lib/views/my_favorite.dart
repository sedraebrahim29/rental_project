import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../widgets/property_card.dart';
import '../cubit/myFavotites/my_favorite_cubit.dart';
import '../cubit/myFavotites/my_favorite_state.dart';

class MyFavoriteScreen extends StatelessWidget {
  const MyFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteCubit()..getFavorites(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/HomeBackground.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),

              /// TITLE
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'My Favorites',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// LIST AREA
              Expanded(
                child: BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    switch (state.state) {
                      case FavoriteStatus.loading:
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );

                      case FavoriteStatus.error:
                        return Center(
                          child: Text(
                            state.error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );

                      case FavoriteStatus.success:
                        if (state.favorites.isEmpty) {
                          return const Center(
                            child: Text(
                              'No favorites yet',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          itemCount: state.favorites.length,
                          itemBuilder: (context, index) {
                            final prop = state.favorites[index];

                            return PropertyCard(
                              property: prop,

                              onTap: () {
                                //Detail Screen
                              },
                            );
                          },
                        );

                      case FavoriteStatus.init:
                        return const SizedBox.shrink();
                    }
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