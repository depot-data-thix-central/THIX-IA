import 'package:flutter/material.dart';

/// Palette de couleurs de THIX.
/// Thème sombre par défaut, avec une touche chaleureuse (ambre/or).
class AppColors {
  AppColors._(); // Classe statique, pas d'instanciation

  // ───── Couleurs principales ─────
  static const Color primary = Color(0xFFFFB300); // Ambre chaud
  static const Color primaryVariant = Color(0xFFCC8F00);
  static const Color secondary = Color(0xFF1E1E2C); // Bleu nuit profond
  static const Color secondaryVariant = Color(0xFF2A2A3D);

  // ───── Surfaces & fonds ─────
  static const Color background = Color(0xFF121220); // Presque noir
  static const Color surface = Color(0xFF1A1A2E); // Cartes, dialogues
  static const Color surfaceLight = Color(0xFF252540); // Survol, sélection

  // ───── Texte ─────
  static const Color textPrimary = Color(0xFFF5F5F7);
  static const Color textSecondary = Color(0xFFB0B0C0);
  static const Color textHint = Color(0xFF6B6B80);

  // ───── Statuts & feedback ─────
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFEF5350);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF42A5F5);

  // ───── THIX spécifique ─────
  static const Color thixGlow = Color(0xFFFFB300); // Lueur autour de l'avatar
  static const Color userBubble = Color(0xFF2A2A45); // Bulle utilisateur
  static const Color thixBubble = Color(0xFF1F1F35); // Bulle THIX (plus sombre)
  static const Color thinkingDot = Color(0xFFFFB300); // Points de réflexion

  // ───── Dégradés ─────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryVariant],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, surface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
