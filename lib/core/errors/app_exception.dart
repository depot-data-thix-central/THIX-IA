/// Classe de base pour toutes les exceptions de l'application.
/// Permet de typer les erreurs et de les propager avec un message lisible.
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() => 'AppException($code): $message';
}

// ───── Exceptions spécialisées ─────

/// Erreur serveur / API (HTTP 4xx, 5xx).
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    required super.message,
    super.code,
    this.statusCode,
    super.originalError,
    super.stackTrace,
  });
}

/// Erreur réseau (pas de connexion, timeout).
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });
}

/// Erreur de cache / stockage local.
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });
}

/// Erreur d'authentification (clé API invalide, token expiré).
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });
}

/// Erreur de validation (données invalides, formulaire).
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required super.message,
    super.code,
    this.fieldErrors,
    super.originalError,
    super.stackTrace,
  });
}

/// Erreur spécifique à THIX (modèle non disponible, etc.).
class ThixException extends AppException {
  const ThixException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });
}
