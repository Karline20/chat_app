import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primary = Color(0xFF1976D2); // A deep blue shade
final Color onPrimary = Color(0xFFFFFFFF); // White for contrast

final Color secondary = Color(0xFFFFA000); // A warm amber/orange
final Color onSecondary = Color(0xFF000000); // Black for contrast

final Color error = Color(0xFFD32F2F); // Standard red for errors
final Color onError = Color(0xFFFFFFFF);

final Color surface = Color(0xFF121212); // Dark background surface
final Color onSurface = Color(0xFFFFFFFF); // White for readability

final colorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: primary,
  onPrimary: onPrimary,
  secondary: secondary,
  onSecondary: onSecondary,
  error: error,
  onError: onError,
  surface: surface,
  onSurface: onSurface,
);

final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorScheme.surface,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      titleSmall: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
      titleLarge: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold)),
);
