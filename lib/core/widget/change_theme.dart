import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:karthikprofile/core/provider/gradient_provider.dart';
import 'package:karthikprofile/core/theme/theme.dart';

class ChangeTheme extends ConsumerWidget {
  const ChangeTheme({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
final env = ref.watch(appEnvProvider);
final isDark = env.isDark;

  return  Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(Icons.color_lens),
              onPressed: () {
                ref.read(randomGradientModeProvider.notifier).state = false;
                Future.delayed(Duration.zero, () {
                  ref.read(randomGradientModeProvider.notifier).state = true;
                });
                ref.read(themeProvider.notifier).state = AppTheme.randomTheme();
              },
            ),
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () {
                ref.read(randomGradientModeProvider.notifier).state = false;
                final prev = ref.read(appEnvProvider);
                final newIsDark = !prev.isDark;
                ref.read(appEnvProvider.notifier).state = AppEnv(
                  size: prev.size,
                  isDark: newIsDark,
                );
                ref.read(themeProvider.notifier).state = newIsDark
                    ? AppTheme.darkThemeMode
                    : AppTheme.lightThemeMode;
              },
            ),
          ],
        ),

        Switch(
          value: isDark,
          onChanged: (value) {

  ref.read(randomGradientModeProvider.notifier).state = false;
                final prev = ref.read(appEnvProvider);
                final newIsDark = !prev.isDark;
                ref.read(appEnvProvider.notifier).state = AppEnv(
                  size: prev.size,
                  isDark: newIsDark,
                );
                ref.read(themeProvider.notifier).state = newIsDark
                    ? AppTheme.darkThemeMode
                    : AppTheme.lightThemeMode;

      
          },
        ),
      ],
    );
  }
}
