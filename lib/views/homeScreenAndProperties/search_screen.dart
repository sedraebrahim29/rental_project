import 'package:flutter/material.dart';

import '../../data/colors.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: MyColor.deepBlue,
      ),
      body: const Center(
        child: Text(
          'Search Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
