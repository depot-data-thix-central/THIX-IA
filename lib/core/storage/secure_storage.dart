import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Abstraction pour le stockage sécurisé (clés, tokens).
///
/// Encapsule [FlutterSecureStorage] pour ne pas être couplé au package.
abstract class SecureStorage {
  Future<void> init();
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
  Future<void> deleteAll();
}

// ───── Implémentation flutter_secure_storage ─────

class SecureStorageImpl implements SecureStorage {
  late final FlutterSecureStorage _storage;

  @override
  Future<void> init() async {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<void> deleteAll() => _storage.deleteAll();
}
