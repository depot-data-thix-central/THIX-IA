import 'package:equatable/equatable.dart';

/// Représente un échec métier (domain layer).
/// Les [Failure]s sont renvoyées par les usecases au lieu des exceptions techniques.
/// La couche présentation ne doit jamais voir les [Exception]s.
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

// ───── Failures concrètes ─────

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({
    required super.message,
    super.code,
    this.statusCode,
  });
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
  });
}

class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });
}

class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required super.message,
    super.code,
    this.fieldErrors,
  });
}

class ThixFailure extends Failure {
  const ThixFailure({
    required super.message,
    super.code,
  });
}

/// Fallback quand quelque chose d'inattendu se produit.
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'Une erreur inattendue est survenue.',
    super.code,
  });
}
