import 'package:flutter/material.dart';
import 'package:rent/data/colors.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF030341);
  static const Color secondaryBlue = Color(0xFF465362);
  static const Color lightBackground = Color(0xFFE3E2E7);
  static const Color accentRed = Color(0xFF8B0909);
  static const Color accentLightBlue = Color(0xFFBCD4FC);
  static const Color lightOverlay = Color.fromRGBO(255, 255, 255, 0.65);
  static const Color darkOverlay = Color.fromRGBO(0, 0, 0, 0.75);

  // ================= LIGHT THEME =================
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    colorScheme: const ColorScheme.light(
      primary: primaryBlue,
      secondary: lightBackground,
      surface: Colors.white,
      error: accentRed,
      onPrimary: Colors.white,
      onSecondary: primaryBlue,
      onSurface: primaryBlue,
      onError: Colors.white,
    ),

    scaffoldBackgroundColor: lightBackground,

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: primaryBlue,
      elevation: 0,
    ),

    iconTheme: const IconThemeData(color: primaryBlue),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: primaryBlue),
      bodyMedium: TextStyle(color: primaryBlue),
      titleMedium: TextStyle(color: primaryBlue),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    ),
  );

  // ================= DARK THEME =================
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    colorScheme: const ColorScheme.dark(
      primary: accentLightBlue,
      secondary: MyColor.blueGray,
      surface: Color(282828),
      error: accentRed,
      onPrimary: Color(0xFF01010B),
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
    ),

    scaffoldBackgroundColor: primaryBlue,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryBlue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    iconTheme: const IconThemeData(color: Colors.white),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentLightBlue,
        foregroundColor: primaryBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),
    ),
  );
}
