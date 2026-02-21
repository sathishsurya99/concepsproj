import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _primaryBlue = Color(0xFF0052CC); // Premium Blue
  static const Color _secondaryBlue = Color(0xFF00B4D8); // Ocean Blue Accent
  static const Color _surfaceColor = Color(
    0xFFF4F7FC,
  ); // Light blueish-grey surface

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    primaryColor: _primaryBlue,

    colorScheme: const ColorScheme.light(
      primary: _primaryBlue,
      secondary: _secondaryBlue,
      error: Color(0xFFD32F2F),
      surface: _surfaceColor,
    ),

    scaffoldBackgroundColor: _surfaceColor,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: Color(0xFF1A1A24)),
      titleTextStyle: TextStyle(
        color: Color(0xFF1A1A24),
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: Color(0xFF1A1A24),
        letterSpacing: -1.0,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: Color(0xFF1A1A24),
        letterSpacing: -0.5,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF333340), height: 1.5),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF555565),
        height: 1.5,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        shadowColor: _primaryBlue.withValues(alpha: 0.4),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.5),
      ),
      hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 15),
    ),

    cardTheme: CardThemeData(
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.06),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: const ColorScheme.dark(
      primary: _primaryBlue,
      secondary: _secondaryBlue,
    ),

    scaffoldBackgroundColor: const Color(0xFF0F172A),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryBlue,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
