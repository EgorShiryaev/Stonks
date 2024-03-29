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
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 70,
    ),
    dividerColor: Colors.grey.shade700,
    highlightColor: Colors.grey.shade100,
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
      bodyText1: GoogleFonts.roboto(
        color: Colors.grey.shade700,
        fontSize: 20,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(size: 32),
      unselectedIconTheme: IconThemeData(size: 24),
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
    ),
    indicatorColor: Colors.black,
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.shade300,
      hintStyle: GoogleFonts.roboto(
        color: Colors.black,
        fontSize: 24,
      ),
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        gapPadding: 0,
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
