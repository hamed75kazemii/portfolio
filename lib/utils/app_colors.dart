import 'package:flutter/material.dart';

// Light Theme Colors
final lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF2196F3),
  brightness: Brightness.light,
  primary: const Color(0xFF2196F3),
  secondary: const Color(0xFF9C27B0),
  surface: Colors.white,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.black87,
);

// Dark Theme Colors
final darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF9C27B0),
  brightness: Brightness.dark,
  primary: const Color(0xFF9C27B0),
  secondary: const Color(0xFF2196F3),
  surface: const Color(0xFF1E1E1E),
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.white,
);

// Gradient Colors
class AppGradients {
  static const List<Color> primaryGradient = [
    Color(0xFF2196F3),
    Color(0xFF9C27B0),
  ];

  static const List<Color> secondaryGradient = [
    Color(0xFF9C27B0),
    Color(0xFFE91E63),
  ];

  static const List<Color> accentGradient = [
    Color(0xFF00BCD4),
    Color(0xFF4CAF50),
  ];
}
