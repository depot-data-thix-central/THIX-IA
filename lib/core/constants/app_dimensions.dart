/// Dimensions et espacements cohérents pour toute l'application.
/// Inspiré d'un système de spacing 4px.
class AppDimensions {
  AppDimensions._();

  // ───── Espacements (base 4px) ─────
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // ───── Padding standard ─────
  static const EdgeInsets screenPadding = EdgeInsets.all(md);
  static const EdgeInsets cardPadding = EdgeInsets.all(sm);
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  // ───── Rayons de bordure ─────
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusRound = 999.0; // Pilule

  // ───── Tailles d'icônes ─────
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;
  static const double iconXl = 48.0;

  // ───── Avatar THIX ─────
  static const double avatarSize = 44.0;
  static const double avatarSizeLarge = 64.0;
  static const double avatarGlowRadius = 8.0;

  // ───── Bulles de chat ─────
  static const double bubbleMaxWidth = 0.78; // % de l'écran
  static const double bubbleRadius = radiusMd;
  static const double bubbleArrowSize = 8.0;

  // ───── Barre de saisie ─────
  static const double inputBarHeight = 64.0;
  static const double sendButtonSize = 40.0;

  // ───── Écrans ─────
  static const double maxContentWidth = 720.0; // Largeur max sur desktop/tablette
}
