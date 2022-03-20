import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  final light = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.black,
      onSecondary: Colors.white,
      shadow: Colors.grey,
      surface: Colors.white,
      error: Colors.red,
      background: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      
      subtitle1: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 32,
      ),
      subtitle2: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 20,
      ),
      caption: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 16,
      ),
    ),
  );

  final dark = ThemeData(
    colorScheme: const ColorScheme.dark(
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: Colors.black,
      shadow: Colors.grey,
      surface: Colors.black,
      error: Colors.red,
      background: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.black,
  );
}
