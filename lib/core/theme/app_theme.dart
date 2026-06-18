import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

/// Styles de texte pour toute l'application.
class AppTextStyles {
  AppTextStyles._();

  // ───── Police par défaut ─────
  static final String? _fontFamily = GoogleFonts.inter().fontFamily;

  // ───── Display (grands titres) ─────
  static TextStyle displayLarge(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge ?? _displayLargeFallback;

  static final TextStyle _displayLargeFallback = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  // ───── Titres ─────
  static TextStyle headlineLarge(BuildContext context) =>
      Theme.of(context).textTheme.headlineLarge ?? _headlineLargeFallback;

  static final TextStyle _headlineLargeFallback = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle headlineSmall(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall ?? _headlineSmallFallback;

  static final TextStyle _headlineSmallFallback = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ───── Corps ─────
  static TextStyle bodyLarge(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge ?? _bodyLargeFallback;

  static final TextStyle _bodyLargeFallback = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle bodyMedium(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium ?? _bodyMediumFallback;

  static final TextStyle _bodyMediumFallback = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // ───── Légende / Hints ─────
  static TextStyle caption(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall ?? _captionFallback;

  static final TextStyle _captionFallback = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );

  // ───── Boutons ─────
  static TextStyle button(BuildContext context) =>
      Theme.of(context).textTheme.labelLarge ?? _buttonFallback;

  static final TextStyle _buttonFallback = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.background,
    letterSpacing: 0.5,
  );

  // ───── Chat ─────
  static TextStyle chatMessage(BuildContext context) =>
      bodyLarge(context).copyWith(height: 1.6);

  static TextStyle chatTimestamp(BuildContext context) =>
      caption(context).copyWith(fontSize: 10);

  // ───── Code (Markdown) ─────
  static TextStyle code(BuildContext context) =>
      bodyMedium(context).copyWith(
        fontFamily: 'monospace',
        backgroundColor: AppColors.surfaceLight,
        fontSize: 13,
      );
}
