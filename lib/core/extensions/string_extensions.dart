/// Extensions pratiques sur [String].
extension StringX on String {
  // ───── Validation ─────
  /// Vérifie si la chaîne est nulle ou vide (ou contient uniquement des espaces).
  bool get isBlank => trim().isEmpty;

  /// Vérifie si la chaîne n'est pas vide.
  bool get isNotBlank => trim().isNotEmpty;

  /// Vérifie si la chaîne est un email valide.
  bool get isValidEmail => RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(this);

  /// Vérifie si la chaîne est une URL valide.
  bool get isValidUrl => Uri.tryParse(this)?.hasAbsolutePath ?? false;

  // ───── Transformations ─────
  /// Capitalise la première lettre.
  String get capitalize => isBlank
      ? this
      : '${this[0].toUpperCase()}${substring(1)}';

  /// Met la première lettre en minuscule.
  String get decapitalize => isBlank
      ? this
      : '${this[0].toLowerCase()}${substring(1)}';

  /// Tronque la chaîne à une longueur donnée et ajoute "…" si nécessaire.
  String truncate(int maxLength) =>
      length <= maxLength ? this : '${substring(0, maxLength)}…';

  /// Supprime tous les types d'espaces en trop (espaces multiples, retours à la ligne).
  String get collapseWhitespace => replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Retourne la chaîne ou une valeur par défaut si elle est vide.
  String orDefault(String defaultValue) => isBlank ? defaultValue : this;

  // ───── Interpolation ─────
  /// Remplace les placeholders {key} par les valeurs de la map.
  /// Exemple : "Hello {name}".interpolate({'name': 'THIX'}) → "Hello THIX"
  String interpolate(Map<String, String> params) {
    String result = this;
    for (final entry in params.entries) {
      result = result.replaceAll('{${entry.key}}', entry.value);
    }
    return result;
  }
}
