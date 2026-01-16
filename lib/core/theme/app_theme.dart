import 'package:flutter/material.dart';

const navy = Color(0xFF0A1F44);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.transparent,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: navy),
    bodyMedium: TextStyle(color: navy),
    titleLarge: TextStyle(color: navy),
  ),
  colorScheme: const ColorScheme.light(
    onBackground: navy,
    onSurface: navy,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.transparent,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
  ),
  colorScheme: const ColorScheme.dark(
    onBackground: Colors.white,
    onSurface: Colors.white,
  ),
);
