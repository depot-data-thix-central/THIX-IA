/// Toutes les URLs de l'API THIX.
/// Modifie [baseUrl] selon ton environnement (local, staging, production).
class ApiEndpoints {
  ApiEndpoints._();

  /// URL de base du serveur Ollama (par défaut) ou de l'API IA.
  static String baseUrl = 'http://localhost:11434';

  // ───── Endpoints ─────

  /// Génération de texte (Ollama / OpenAI-compatible).
  static String get generate => '/api/generate';

  /// Chat avec historique (OpenAI-compatible).
  static String get chat => '/v1/chat/completions';

  /// Liste des modèles disponibles (Ollama).
  static String get models => '/api/tags';

  /// Vérification de la connexion (ping).
  static String get health => '/api/health';
}
