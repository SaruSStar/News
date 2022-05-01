import 'package:flutter/material.dart';

class AppColors {
  static const Color secoundary = Color(0xFF0080FF);
  static const Color tertiary = Color(0xFFFFE600);

  static const MaterialColor primary =
      MaterialColor(_primePrimaryValue, <int, Color>{
    50: Color(0xFFFFE7E9),
    100: Color(0xFFFFC4C7),
    200: Color(0xFFFF9DA2),
    300: Color(0xFFFF757C),
    400: Color(0xFFFF5860),
    500: Color(_primePrimaryValue),
    600: Color(0xFFFF343E),
    700: Color(0xFFFF2C35),
    800: Color(0xFFFF252D),
    900: Color(0xFFFF181F),
  });
  static const int _primePrimaryValue = 0xFFFF3A44;
}
