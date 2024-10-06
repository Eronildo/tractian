import 'package:flutter/material.dart';

sealed class AppTheme {
  static final _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: Colors.transparent, width: 0),
  );

  static ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Color(0xff17192d),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF17192D),
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      fillColor: const Color(0xFFEAEFF3),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      prefixIconColor: const Color(0xFF8E98A3),
      suffixIconColor: const Color(0xFF8E98A3),
      hintStyle: const TextStyle(color: Color(0xFF8E98A3)),
      filled: true,
      enabledBorder: _outlineInputBorder,
      disabledBorder: _outlineInputBorder,
      border: _outlineInputBorder,
      focusedBorder: _outlineInputBorder,
    ),
  );
}
