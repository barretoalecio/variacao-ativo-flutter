import 'package:flutter/material.dart';

final guideTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    toolbarHeight: 128,
    backgroundColor: Color(0xFF2B4E4D),
    elevation: 0.0,
  ),
  colorScheme: const ColorScheme(
    primary: Color(0xFF2B4E4D),
    primaryContainer: Color(0xFF10194E),
    secondary: Color(0xFF068e87),
    secondaryContainer: Color(0xFF18B5E8),
    background: Color(0xFFEEEEEE),
    surface: Color(0xFFFFFFFF),
    error: Color(0xFFEB5757),
    onPrimary: Color(0xFF212121),
    onSecondary: Color(0xFF010A43),
    onBackground: Color(0xFF333852),
    onSurface: Color(0xFF333852),
    onError: Color(0xFFFFFFFF),
    brightness: Brightness.light,
  ),
  fontFamily: 'roboto',
  textTheme: TextTheme(
    titleMedium: const TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.grey[900]),
    bodyLarge: const TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.grey[900]),
    labelSmall: const TextStyle(
      fontWeight: FontWeight.w700,
      letterSpacing: 0.4,
    ),
  ),
);
