import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade100,
    primary: Colors.grey.shade300,
  secondary: const Color.fromARGB(255, 230, 230, 230),
    tertiary: Colors.grey.shade50,
    inversePrimary: Colors.grey.shade900,
  ),
);
