import 'package:shared_preferences/shared_preferences.dart';

/// Abstraction du stockage local clé-valeur.
///
/// Permet de changer l'implémentation (SharedPreferences → Hive) sans impacter le reste.
abstract class LocalStorage {
  Future<void> init();

  String? getString(String key);
  Future<void> setString(String key, String value);

  int? getInt(String key);
  Future<void> setInt(String key, int value);

  bool? getBool(String key);
  Future<void> setBool(String key, bool value);

  double? getDouble(String key);
  Future<void> setDouble(String key, double value);

  List<String>? getStringList(String key);
  Future<void> setStringList(String key, List<String> value);

  Future<void> remove(String key);
  Future<void> clear();
}

// ───── Implémentation SharedPreferences ─────

class SharedPrefLocalStorage implements LocalStorage {
  late final SharedPreferences _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  String? getString(String key) => _prefs.getString(key);

  @override
  Future<void> setString(String key, String value) =>
      _prefs.setString(key, value);

  @override
  int? getInt(String key) => _prefs.getInt(key);

  @override
  Future<void> setInt(String key, int value) =>
      _prefs.setInt(key, value);

  @override
  bool? getBool(String key) => _prefs.getBool(key);

  @override
  Future<void> setBool(String key, bool value) =>
      _prefs.setBool(key, value);

  @override
  double? getDouble(String key) => _prefs.getDouble(key);

  @override
  Future<void> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  @override
  List<String>? getStringList(String key) => _prefs.getStringList(key);

  @override
  Future<void> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  @override
  Future<void> remove(String key) => _prefs.remove(key);

  @override
  Future<void> clear() => _prefs.clear();
}
