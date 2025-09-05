import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF6D28D9),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF6D28D9),
      secondary: Color(0xFF3B82F6),
      background: Color(0xFF0B0F1A),
      surface: Color(0xFF12151B),
    ),
    scaffoldBackgroundColor: const Color(0xFF0B0F1A),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF12151B),
      elevation: 0,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF12151B),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A1F2E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6D28D9),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF3B82F6),
        textStyle: const TextStyle(fontWeight: FontWeight.w500),
      ),
    ),
    useMaterial3: true,
  );
}