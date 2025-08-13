import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:karthikprofile/core/theme/theme.dart';


class AppEnv {
  final Size size;
  final bool isDark;
  AppEnv({required this.size, required this.isDark});
}

final themeProvider = StateProvider<ThemeData>((ref) => AppTheme.darkThemeMode);

final appEnvProvider = StateProvider<AppEnv>((ref) {
  return AppEnv(size: Size.zero, isDark: true);
});

final randomGradientModeProvider = StateProvider<bool>((ref) => false);

final backgroundGradientProvider = Provider<LinearGradient>((ref) {

    final isRandom = ref.watch(randomGradientModeProvider);

  if (isRandom) {
    return AppTheme.randomGradient();
  }
  final env = ref.watch(appEnvProvider);
  final isReduced = env.size.width < 600;

  final begin = isReduced ? Alignment.topCenter : Alignment.centerLeft;
  final end = isReduced ? Alignment.bottomCenter : Alignment.centerRight;

  if (env.isDark) {
    return LinearGradient(
      colors: const [
        Color(0xFF182D48),
        Color(0xFF172A45),
        Color(0xFF183661),
        Color(0xFF113771),
      ],
      begin: begin,
      end: end,
    );
  } else {
    return LinearGradient(
      colors: const [
        Color(0xFFE3F2FD),
        Color(0xFFBBDEFB),
        Color(0xFF90CAF9),
        Color(0xFF64B5F6),
      ],
      begin: begin,
      end: end,
    );
  }
});