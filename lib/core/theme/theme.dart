import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:karthikprofile/core/theme/app_pallete.dart';
//#182D48 //#172A45  // #183661 , //#113771

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 3),
    borderRadius: BorderRadius.circular(10),
  );


  static ThemeData randomTheme() {
  final random = UniqueKey().hashCode;
  final color = Color((random & 0xFFFFFF) | 0xFF000000);
  return ThemeData(
    scaffoldBackgroundColor: color,
    primaryColor: color,
    appBarTheme: AppBarTheme(backgroundColor: color),
    colorScheme: ColorScheme.fromSeed(seedColor: color),
  );
}

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.gradient2,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(Pallete.borderColor),
      focusedBorder: _border(Pallete.gradient2),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.backgroundColor,
    ),
  );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(Pallete.borderColor),
      focusedBorder: _border(Pallete.gradient2),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Pallete.backgroundColor,
    ),
  );

  // Gradient helper
  static LinearGradient getBackgroundGradient(BuildContext context) {
    final isDesktop = [
      TargetPlatform.windows,
      TargetPlatform.macOS,
      TargetPlatform.linux,
    ].contains(defaultTargetPlatform);

    return LinearGradient(
      colors: const [
        Color(0xFF182D48),
        Color(0xFF172A45),
        Color(0xFF183661),
        Color(0xFF113771),
      ],
      begin: isDesktop ? Alignment.centerLeft : Alignment.topCenter,
      end: isDesktop ? Alignment.centerRight : Alignment.bottomCenter,
    );
  }

  static LinearGradient getLightBackgroundGradient(BuildContext context) {
  final isDesktop = [
    TargetPlatform.windows,
    TargetPlatform.macOS,
    TargetPlatform.linux,
  ].contains(defaultTargetPlatform);

  return LinearGradient(
    colors: const [
      Color(0xFFE3F2FD), // Light blue
      Color(0xFFBBDEFB), // Lighter blue
      Color(0xFF90CAF9), // Even lighter blue
      Color(0xFF64B5F6), // Soft blue
    ],
    begin: isDesktop ? Alignment.centerLeft : Alignment.topCenter,
    end: isDesktop ? Alignment.centerRight : Alignment.bottomCenter,
  );
}

static LinearGradient randomGradient() {
  List<Color> colors = List.generate(
    4,
    (_) => Color((UniqueKey().hashCode & 0xFFFFFF) | 0xFF000000),
  );
  return LinearGradient(
    colors: colors,
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
}
