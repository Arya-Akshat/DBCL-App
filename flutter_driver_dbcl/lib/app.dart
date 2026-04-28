import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_colors.dart';
import 'providers/app_providers.dart';
import 'screens/auth_gate.dart';

class DriverDbclApp extends ConsumerWidget {
  const DriverDbclApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appControllerProvider);
    final themeMode = appState.valueOrNull?.themeMode ?? ThemeMode.dark;

    return MaterialApp(
      title: 'Driver DBCL',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      home: const AuthGate(),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final background = isDark ? AppColors.background : const Color(0xFFF4F8FB);
    final panel = isDark ? AppColors.panel : Colors.white;
    final text = isDark ? AppColors.text : const Color(0xFF13283B);
    final muted = isDark ? AppColors.muted : const Color(0xFF5B7287);

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: brightness,
        surface: panel,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: panel,
        foregroundColor: text,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: panel,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: panel,
        labelStyle: TextStyle(color: muted),
        hintStyle: TextStyle(color: muted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.4),
        ),
      ),
      useMaterial3: true,
    );
  }
}
