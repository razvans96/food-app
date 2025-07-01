import 'package:flutter/material.dart';
import 'package:food_app/presentation/theme/design_constants.dart';
import 'package:food_app/presentation/theme/theme_extensions.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
      ),
      useMaterial3: true,
    );
    return _customizeTheme(base).copyWith(
      extensions: [
        FoodScoreColors.light,
        AdditiveColors.light,
        AllergenColors.light,
        ProductCardColors.light,
      ],
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.green,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
    return _customizeTheme(base).copyWith(
      extensions: [
        FoodScoreColors.dark,
        AdditiveColors.dark,
        AllergenColors.dark,
        ProductCardColors.dark,
      ],
    );
  }

  static ThemeData _customizeTheme(ThemeData base) {
    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: base.colorScheme.surface,
        foregroundColor: base.colorScheme.onSurface,
        centerTitle: true,
        iconTheme: IconThemeData(color: base.colorScheme.onSurface),
        titleTextStyle: TextStyle(
          color: base.colorScheme.onSurface,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: base.colorScheme.primary,
          foregroundColor: base.colorScheme.onPrimary,
          textStyle: const TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: base.colorScheme.secondary,
          foregroundColor: base.colorScheme.onSecondary,
          textStyle: const TextStyle(fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: base.colorScheme.primary,
          foregroundColor: base.colorScheme.onPrimary,
          side: BorderSide(color: base.colorScheme.primary),
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: AppDesignConstants.elevationMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDesignConstants.borderRadiusMedium),
        ),
      ),
    );
  }
}
