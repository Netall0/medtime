import 'package:flutter/material.dart';
import '../color/colors.dart';
import '../fonts/typography.dart';

class ThemeTypography {
  const ThemeTypography({
    required this.headlineFont,
    required this.bodyFont,
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.caption,
    required this.overline,
  });

  final String headlineFont;
  final String bodyFont;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle h5;
  final TextStyle h6;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle caption;
  final TextStyle overline;

  static const light = ThemeTypography(
    headlineFont: ThemeConstants.fontFamily,
    bodyFont: ThemeConstants.fontFamilyBody,
    h1: TextStyle(
      fontSize: AppTypographyConstants.h1,
      fontWeight: FontWeight.bold,
      height: AppTypographyConstants.lineHeightTight,
      letterSpacing: AppTypographyConstants.letterSpacingTight,
      color: ThemeConstants.textPrimaryLight,
    ),
    h2: TextStyle(
      fontSize: AppTypographyConstants.h2,
      fontWeight: FontWeight.bold,
      height: AppTypographyConstants.lineHeightTight,
      color: ThemeConstants.textPrimaryLight,
    ),
    h3: TextStyle(
      fontSize: AppTypographyConstants.h3,
      fontWeight: FontWeight.w600,
      height: AppTypographyConstants.lineHeightNormal,
      color: ThemeConstants.gray700,
    ),
    h4: TextStyle(
      fontSize: AppTypographyConstants.h4,
      fontWeight: FontWeight.w600,
      height: AppTypographyConstants.lineHeightNormal,
      color: ThemeConstants.gray700,
    ),
    h5: TextStyle(
      fontSize: AppTypographyConstants.h5,
      fontWeight: FontWeight.w500,
      height: AppTypographyConstants.lineHeightNormal,
      color: ThemeConstants.gray600,
    ),
    h6: TextStyle(
      fontSize: AppTypographyConstants.h6,
      fontWeight: FontWeight.w500,
      height: AppTypographyConstants.lineHeightNormal,
      color: ThemeConstants.textPrimaryLight,
    ),
    bodyLarge: TextStyle(
      fontSize: AppTypographyConstants.bodyLarge,
      fontWeight: FontWeight.normal,
      height: AppTypographyConstants.lineHeightRelaxed,
      color: ThemeConstants.textPrimaryLight,
    ),
    bodyMedium: TextStyle(
      fontSize: AppTypographyConstants.bodyMedium,
      fontWeight: FontWeight.normal,
      height: AppTypographyConstants.lineHeightRelaxed,
      color: ThemeConstants.textSecondaryLight,
    ),
    bodySmall: TextStyle(
      fontSize: AppTypographyConstants.bodySmall,
      fontWeight: FontWeight.normal,
      height: AppTypographyConstants.lineHeightNormal,
      color: ThemeConstants.textSecondaryLight,
    ),
    caption: TextStyle(
      fontSize: AppTypographyConstants.caption,
      fontWeight: FontWeight.normal,
      color: ThemeConstants.textDisabledLight,
    ),
    overline: TextStyle(
      fontSize: AppTypographyConstants.overline,
      fontWeight: FontWeight.w500,
      letterSpacing: AppTypographyConstants.letterSpacingWide,
      color: ThemeConstants.textDisabledLight,
    ),
  );

  static const dark = ThemeTypography(
    headlineFont: ThemeConstants.fontFamily,
    bodyFont: ThemeConstants.fontFamilyBody,
    h1: TextStyle(
      fontSize: AppTypographyConstants.h1,
      fontWeight: FontWeight.bold,
      height: AppTypographyConstants.lineHeightTight,
      letterSpacing: AppTypographyConstants.letterSpacingTight,
      color: ThemeConstants.textPrimaryDark,
    ),
    h2: TextStyle(
      fontSize: AppTypographyConstants.h2,
      fontWeight: FontWeight.bold,
      height: AppTypographyConstants.lineHeightTight,
      color: ThemeConstants.textPrimaryDark,
    ),
    h3: TextStyle(
      fontSize: AppTypographyConstants.h3,
      fontWeight: FontWeight.w600,
      height: AppTypographyConstants.lineHeightNormal,
      color: ThemeConstants.slate200,
    ),
    h4: TextStyle(
      fontSize: AppTypographyConstants.h4,
      fontWeight: FontWeight.w600,
      height: AppTypographyConstants.lineHeightNormal,
      color: ThemeConstants.slate200,
    ),
    h5: TextStyle(
      fontSize: AppTypographyConstants.h5,
      fontWeight: FontWeight.w500,
      height: AppTypographyConstants.lineHeightNormal,
      color: ThemeConstants.slate300,
    ),
    h6: TextStyle(
      fontSize: AppTypographyConstants.h6,
      fontWeight: FontWeight.w500,
      height: AppTypographyConstants.lineHeightNormal,
      color: ThemeConstants.slate300,
    ),
    bodyLarge: TextStyle(
      fontSize: AppTypographyConstants.bodyLarge,
      fontWeight: FontWeight.normal,
      height: AppTypographyConstants.lineHeightRelaxed,
      color: ThemeConstants.textPrimaryDark,
    ),
    bodyMedium: TextStyle(
      fontSize: AppTypographyConstants.bodyMedium,
      fontWeight: FontWeight.normal,
      height: AppTypographyConstants.lineHeightRelaxed,
      color: ThemeConstants.textSecondaryDark,
    ),
    bodySmall: TextStyle(
      fontSize: AppTypographyConstants.bodySmall,
      fontWeight: FontWeight.normal,
      height: AppTypographyConstants.lineHeightNormal,
      color: ThemeConstants.textSecondaryDark,
    ),
    caption: TextStyle(
      fontSize: AppTypographyConstants.caption,
      fontWeight: FontWeight.normal,
      color: ThemeConstants.textDisabledDark,
    ),
    overline: TextStyle(
      fontSize: AppTypographyConstants.overline,
      fontWeight: FontWeight.w500,
      letterSpacing: AppTypographyConstants.letterSpacingWide,
      color: ThemeConstants.textDisabledDark,
    ),
  );
}
