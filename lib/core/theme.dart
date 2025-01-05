import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom ColorScheme for Light Theme
final ColorScheme lightColorScheme =  ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff009788),
  onPrimary: Colors.white,
  secondary: Colors.amber,
  onSecondary: Colors.black,
  error: Colors.red,
  onError: Colors.white,
  surface: Colors.grey[200]!,
  onSurface: Colors.black,
);

// Custom ColorScheme for Dark Theme
final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF042f2e),
  onPrimary: Colors.grey.shade200,
  secondary: Colors.amber,
  onSecondary: Colors.white,
  error: Colors.red,
  onError: Colors.black,
  surface: Color(0xFF020617),
  onSurface: Color(0xFFe2e8f0),
);

// Light Theme
final ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,
  textTheme: TextTheme(
      displayLarge: const TextStyle(
        // fontSize: 72,
        // fontWeight: FontWeight.bold,
      ),
      titleSmall: GoogleFonts.roboto(
        // fontSize: 12.0,
        // fontWeight: FontWeight.w500,
      ),

      titleMedium: GoogleFonts.roboto(
        // fontSize: 16.0,
        // fontWeight: FontWeight.w600,
      ),

      titleLarge: GoogleFonts.roboto(
        // fontSize: 22.0,
        // fontWeight: FontWeight.w700,
      ),
      bodyMedium: GoogleFonts.inter(
          // fontSize: 16
      )
  ),

);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  colorScheme: darkColorScheme,
  useMaterial3: true,
);
