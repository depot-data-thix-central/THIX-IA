import 'dart:developer' as dev;

/// Logger structuré pour THIX.
///
/// Utilise [dev.log] pour les logs de debug, qui apparaissent dans la console
/// Flutter sans être pollués par les print().
class Logger {
  Logger._();

  static const String _tag = 'THIX';

  /// Log de debug (visible uniquement en mode debug).
  static void debug(String message, [Object? extra]) {
    dev.log('🐛 $message', name: _tag, level: 500);
  }

  /// Log d'information.
  static void info(String message, [Object? extra]) {
    dev.log('ℹ️ $message', name: _tag, level: 800);
  }

  /// Log d'avertissement.
  static void warning(String message, [Object? extra]) {
    dev.log('⚠️ $message', name: _tag, level: 900);
  }

  /// Log d'erreur (toujours visible).
  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    dev.log(
      '❌ $message',
      name: _tag,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log d'une requête réseau (verbose).
  static void network(String message) {
    dev.log('🌐 $message', name: '$_tag-NETWORK', level: 600);
  }
}
