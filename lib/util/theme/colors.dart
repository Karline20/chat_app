import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme.light(
  surface: Colors.white,
  onSurface: Colors.blue,
  primary: Colors.grey.shade200,
  secondary: Colors.grey.shade300,
  tertiary: Colors.black,
  tertiaryFixed: Colors.white,
  tertiaryContainer: Colors.blue,
  onError: Colors.red,
);

final darkColorScheme = ColorScheme.dark(
  surface: Colors.grey.shade900,
  onSurface: Colors.black,
  primary: Colors.grey.shade800,
  secondary: Colors.grey.shade700,
  tertiary: Colors.white,
  tertiaryFixed: Colors.white,
  tertiaryContainer: Colors.white,
  onError: Colors.red,
);
