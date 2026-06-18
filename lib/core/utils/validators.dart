/// Validateurs pour les formulaires et entrées utilisateur.
class Validators {
  Validators._();

  /// Vérifie que le champ n'est pas vide (après trim).
  static String? required(String? value, [String fieldName = 'Ce champ']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName est requis.';
    }
    return null;
  }

  /// Vérifie la longueur minimale d'une chaîne.
  static String? minLength(String? value, int min, [String fieldName = 'Ce champ']) {
    if (value == null || value.trim().length < min) {
      return '$fieldName doit contenir au moins $min caractères.';
    }
    return null;
  }

  /// Vérifie la longueur maximale d'une chaîne.
  static String? maxLength(String? value, int max, [String fieldName = 'Ce champ']) {
    if (value != null && value.trim().length > max) {
      return '$fieldName ne doit pas dépasser $max caractères.';
    }
    return null;
  }

  /// Vérifie une URL valide (http/https).
  static String? url(String? value, [String fieldName = 'URL']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName est requise.';
    }
    final uri = Uri.tryParse(value.trim());
    if (uri == null || !uri.hasScheme || (!uri.isScheme('http') && !uri.isScheme('https'))) {
      return 'Veuillez entrer une URL valide (ex: http://...).';
    }
    return null;
  }

  /// Vérifie que la valeur est un nombre entier positif.
  static String? positiveInt(String? value, [String fieldName = 'Valeur']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName est requise.';
    }
    final number = int.tryParse(value.trim());
    if (number == null || number < 1) {
      return '$fieldName doit être un nombre entier supérieur à 0.';
    }
    return null;
  }

  /// Vérifie que la température est entre 0.0 et 2.0.
  static String? temperature(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La température est requise.';
    }
    final temp = double.tryParse(value.trim().replaceAll(',', '.'));
    if (temp == null || temp < 0.0 || temp > 2.0) {
      return 'La température doit être comprise entre 0.0 et 2.0.';
    }
    return null;
  }

  /// Combine plusieurs validateurs pour un même champ.
  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}
