import 'package:flutter/material.dart';

class AppTheme {
  // Custom color constants
  static const Color softBlue = Color(0xFF90CAF9);
  static const Color softGreen = Color(0xFFA5D6A7);
  static const Color lightGrey = Color(0xFFF5F5F5);
  
  /// Custom light theme for MindFocus Lite
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      
      // Color scheme based on soft blue primary
      colorScheme: ColorScheme.fromSeed(
        seedColor: softBlue,
        brightness: Brightness.light,
        surface: lightGrey,
        background: lightGrey,
        secondary: softGreen,
      ),
      
      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: softBlue,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
      ),
      
      // Card theme for consistent elevation and shape
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: softBlue,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      
      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: softBlue,
        unselectedItemColor: Colors.grey,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      
      // Icon theme
      iconTheme: const IconThemeData(
        color: softBlue,
      ),
      
      // Text theme with clean typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        displayMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.black87,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
      ),
    );
  }
} 