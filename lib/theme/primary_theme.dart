import 'package:flutter/material.dart';

abstract class PrimaryTheme {
  static ThemeData generateTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
