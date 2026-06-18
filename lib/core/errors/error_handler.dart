import 'package:dio/dio.dart';

import 'failure.dart';
import 'app_exception.dart';

/// Mapper : convertit les exceptions techniques en [Failure]s métier.
/// La couche présentation n'a qu'à gérer des [Failure]s.
class ErrorHandler {
  ErrorHandler._();

  /// Convertit n'importe quel objet en [Failure].
  static Failure mapToFailure(dynamic error, {StackTrace? stackTrace}) {
    // Déjà une Failure → on la retourne directement
    if (error is Failure) {
      return error;
    }

    // AppException → on convertit en Failure correspondante
    if (error is AppException) {
      return _fromAppException(error);
    }

    // Erreur Dio (HTTP)
    if (error is DioException) {
      return _fromDioError(error);
    }

    // TypeError, NoSuchMethodError, etc.
    if (error is TypeError) {
      return UnknownFailure(
        message: 'Erreur de type inattendue.',
        code: 'TYPE_ERROR',
      );
    }

    // Fallback
    return UnknownFailure(
      message: error?.toString() ?? 'Erreur inconnue.',
      code: 'UNKNOWN',
    );
  }

  // ───── Converters privés ─────

  static Failure _fromAppException(AppException exception) {
    switch (exception) {
      case ServerException(:final message, :final code, :final statusCode):
        return ServerFailure(message: message, code: code, statusCode: statusCode);
      case NetworkException(:final message, :final code):
        return NetworkFailure(message: message, code: code);
      case CacheException(:final message, :final code):
        return CacheFailure(message: message, code: code);
      case AuthException(:final message, :final code):
        return AuthFailure(message: message, code: code);
      case ValidationException(:final message, :final code, :final fieldErrors):
        return ValidationFailure(message: message, code: code, fieldErrors: fieldErrors);
      case ThixException(:final message, :final code):
        return ThixFailure(message: message, code: code);
      default:
        return UnknownFailure(message: exception.message, code: exception.code);
    }
  }

  static Failure _fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
          message: 'La connexion a expiré. Vérifie ta connexion ou le serveur distant.',
          code: 'TIMEOUT',
        );

      case DioExceptionType.connectionError:
        return const NetworkFailure(
          message: 'Impossible de se connecter au serveur. Vérifie ta connexion Internet.',
          code: 'NO_CONNECTION',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final body = error.response?.data;

        String message = 'Erreur serveur.';
        if (statusCode == 400) message = 'Requête invalide.';
        if (statusCode == 401) message = 'Authentification échouée. Vérifie ta clé API.';
        if (statusCode == 403) message = 'Accès refusé.';
        if (statusCode == 404) message = 'Ressource introuvable.';
        if (statusCode == 429) message = 'Trop de requêtes. Ralentis.';
        if (statusCode == 500) message = 'Erreur interne du serveur.';

        // Tente d'extraire un message depuis le corps de la réponse
        if (body is Map && body['error'] is String) {
          message = body['error'];
        }

        return ServerFailure(
          message: message,
          code: 'HTTP_$statusCode',
          statusCode: statusCode,
        );

      case DioExceptionType.cancel:
        return const Failure(message: 'Requête annulée.', code: 'CANCEL');

      case DioExceptionType.badCertificate:
        return const NetworkFailure(
          message: 'Certificat SSL invalide.',
          code: 'BAD_CERTIFICATE',
        );

      default:
        return UnknownFailure(
          message: error.message ?? 'Erreur réseau inconnue.',
          code: 'UNKNOWN_NETWORK',
        );
    }
  }
}
