import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFFFFFFF),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: const Color(0xffFFF200),
      selectionColor: const Color(0xffFFF200).withAlpha(100),
      selectionHandleColor: const Color(0xffFFF200),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
      ),
    ),
  );
}
