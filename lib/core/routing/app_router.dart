/// Noms des routes de l'application.
/// Utilisés avec GoRouter pour la navigation typée.
class RouteNames {
  RouteNames._();

  // ───── Routes principales ─────
  static const String home = '/';
  static const String chat = '/chat';
  static const String settings = '/settings';
  static const String history = '/history';
  static const String onboarding = '/onboarding';

  // ───── Sous-routes ─────
  static const String conversation = 'conversation';
  static const String conversationPath = '$history/:id';

  /// Génère le chemin d'une conversation spécifique.
  static String conversationById(String id) => '$history/$id';
}
