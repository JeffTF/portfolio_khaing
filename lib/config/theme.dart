import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
// 🌸 Girl-inspired theme (Light Blue focus in Light mode, Purple in Dark mode)
  static ThemeData softGirlLightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF5CA9FA), // Light blue (main)
    scaffoldBackgroundColor: const Color(0xFFEFF6FB), // Very soft blue-white
    cardColor: const Color(0xFFF9FCFE), // Almost white with blue hint
    dividerColor: const Color(0xFFD6E6F5),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color(0xFF5CA9FA), // Light blue (main)
      secondary: const Color(0xFF9E77ED), // Lavender purple (accent)
      brightness: Brightness.light,
      background: const Color(0xFFEFF6FB),
      surface: const Color(0xFFF9FCFE),
    ),
  );

  static ThemeData blueMistLightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.grey.shade100,
  primaryColor: const Color(0xFF607D8B), // blue-grey
  cardColor: Colors.white,
  dividerColor: Colors.blueGrey.shade200,
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).apply(
    bodyColor: Colors.blueGrey.shade900,
    displayColor: Colors.blueGrey.shade900,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.blueGrey.shade50,
    foregroundColor: Colors.blueGrey.shade900,
    iconTheme: IconThemeData(color: Colors.blueGrey.shade900),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.blueGrey.shade600,
    secondary: Colors.indigo.shade300,
    background: Colors.grey.shade100,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onBackground: Colors.blueGrey.shade900,
    onSurface: Colors.blueGrey.shade900,
  ),
);


  static ThemeData softGirlDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF9E77ED), // Violet (main in dark)
    scaffoldBackgroundColor: const Color(0xFF121224), // Deep midnight blue
    cardColor: const Color(0xFF1A1A33), // Slight purple-toned dark card
    dividerColor: const Color(0xFF2A2A44),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color(0xFF9E77ED), // Violet main
      secondary: const Color(0xFF5CA9FA), // Light blue accent
      brightness: Brightness.dark,
      background: const Color(0xFF121224),
      surface: const Color(0xFF1A1A33),
    ),
  );
}
