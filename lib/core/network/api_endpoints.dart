import 'package:dio/dio.dart';

import 'api_endpoints.dart';
import 'api_interceptors.dart';

/// Client HTTP unique pour toute l'application.
///
/// Utilise [Dio] avec :
/// - Base URL dynamique.
/// - Intercepteurs (logging, auth, erreurs).
/// - Timeouts configurés.
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  Dio? _dio;

  /// L'instance Dio, initialisée à la première utilisation.
  Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  /// Recrée le client avec une nouvelle configuration.
  /// À appeler quand l'utilisateur change l'endpoint ou la clé API.
  void configure({
    String? baseUrl,
    String? apiKey,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    if (baseUrl != null) {
      ApiEndpoints.baseUrl = baseUrl;
    }
    _dio = _createDio(
      apiKey: apiKey,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
    );
  }

  /// Force la réinitialisation du client (utile pour les tests).
  void reset() {
    _dio = null;
  }

  // ───── Private ─────

  Dio _createDio({
    String? apiKey,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    final dio = Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: connectTimeout ?? const Duration(seconds: 15),
      receiveTimeout: receiveTimeout ?? const Duration(seconds: 60),
      sendTimeout: sendTimeout ?? const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Intercepteurs
    dio.interceptors.add(ThixInterceptor(apiKey: apiKey));

    // (Optionnel) Intercepteur de retry, circuit breaker, etc.
    // On pourra les ajouter plus tard.

    return dio;
  }
}
