import 'package:flutter/material.dart';
import 'package:uikit/color/colors.dart';

class ThemeColors {
  const ThemeColors({
    required this.primary,
    required this.primaryVariant,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.error,
    required this.onPrimary,
    required this.onSecondary,
    required this.onBackground,
    required this.onSurface,
    required this.onError,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.cardBackground,
    required this.dividerColor,
    required this.shadowColor,
  });

  final Color primary;
  final Color primaryVariant;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color error;
  final Color onPrimary;
  final Color onSecondary;
  final Color onBackground;
  final Color onSurface;
  final Color onError;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color cardBackground;
  final Color dividerColor;
  final Color shadowColor;

  static const light = ThemeColors(
    primary: ThemeConstants.primaryLight,
    primaryVariant: Color(0xFF1E40AF),
    secondary: ThemeConstants.secondaryLight,
    background: ThemeConstants.backgroundLight,
    surface: ThemeConstants.surfaceLight,
    error: ThemeConstants.errorLight,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onBackground: ThemeConstants.textPrimaryLight,
    onSurface: ThemeConstants.textPrimaryLight,
    onError: Colors.white,
    textPrimary: ThemeConstants.textPrimaryLight,
    textSecondary: ThemeConstants.textSecondaryLight,
    textDisabled: ThemeConstants.textDisabledLight,
    cardBackground: ThemeConstants.cardBackgroundLight,
    dividerColor: ThemeConstants.dividerColorLight,
    shadowColor: ThemeConstants.shadowColorLight,
  );

  static const dark = ThemeColors(
    primary: ThemeConstants.primaryDark,
    primaryVariant: Color(0xFF3B82F6),
    secondary: ThemeConstants.secondaryDark,
    background: ThemeConstants.backgroundDark,
    surface: ThemeConstants.surfaceDark,
    error: ThemeConstants.errorDark,
    onPrimary: ThemeConstants.backgroundDark,
    onSecondary: ThemeConstants.backgroundDark,
    onBackground: ThemeConstants.textPrimaryDark,
    onSurface: ThemeConstants.textPrimaryDark,
    onError: ThemeConstants.backgroundDark,
    textPrimary: ThemeConstants.textPrimaryDark,
    textSecondary: ThemeConstants.textSecondaryDark,
    textDisabled: ThemeConstants.textDisabledDark,
    cardBackground: ThemeConstants.cardBackgroundDark,
    dividerColor: ThemeConstants.dividerColorDark,
    shadowColor: ThemeConstants.shadowColorDark,
  );
}
