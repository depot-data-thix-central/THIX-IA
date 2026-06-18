import 'package:dio/dio.dart';

/// Intercepteur personnalisé pour THIX.
///
/// Rôles :
/// - Logger toutes les requêtes et réponses.
/// - Ajouter les headers communs (auth, content-type).
/// - Transformer les erreurs en [AppException] (optionnel).
class ThixInterceptor extends Interceptor {
  final String? apiKey;

  ThixInterceptor({this.apiKey});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Headers obligatoires
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';

    // Clé API si fournie
    if (apiKey != null && apiKey!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $apiKey';
    }

    // Log structuré
    _log('➡️ REQUEST [${options.method}] ${options.uri}');
    _log('Headers: ${options.headers}');
    if (options.data != null) {
      _log('Body: ${options.data}');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log('⬅️ RESPONSE [${response.statusCode}] ${response.requestOptions.uri}');
    _log('Data: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log('❌ ERROR [${err.type}] ${err.requestOptions.uri}');
    _log('Message: ${err.message}');
    if (err.response != null) {
      _log('Status: ${err.response?.statusCode}');
      _log('Body: ${err.response?.data}');
    }

    // On laisse passer l'erreur native, le ErrorHandler s'en chargera.
    handler.next(err);
  }

  void _log(String message) {
    // Utilise un logger (à importer depuis utils/logger.dart plus tard)
    // Pour l'instant, on imprime en mode debug.
    final timestamp = DateTime.now().toIso8601String();
    // ignore: avoid_print
    print('[$timestamp] THIX-NETWORK: $message');
  }
}
