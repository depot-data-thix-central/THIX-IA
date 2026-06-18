import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/api_client.dart';
import '../storage/local_storage.dart';
import '../storage/secure_storage.dart';

/// Providers pour les services globaux.
///
/// Ces providers sont accessibles dans toute l'application via Riverpod.
/// On les initialise dans le [ProviderScope] au lancement de l'app.

// ───── API Client ─────
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

// ───── Stockage local ─────
final localStorageProvider = Provider<LocalStorage>((ref) {
  return SharedPrefLocalStorage();
});

// ───── Stockage sécurisé ─────
final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorageImpl();
});

/// Initialise les services asynchrones au démarrage.
///
/// À appeler avant le [runApp] ou dans un [FutureProvider].
Future<void> initializeServices() async {
  // Initialise SharedPreferences via le provider
  final localStorage = SharedPrefLocalStorage();
  await localStorage.init();

  // Initialise le stockage sécurisé
  final secureStorage = SecureStorageImpl();
  await secureStorage.init();

  // Configure le client HTTP avec les valeurs stockées (endpoint, clé)
  final apiClient = ApiClient();
  final baseUrl = localStorage.getString('api_endpoint') ?? 'http://localhost:11434';
  final apiKey = await secureStorage.read('api_key');
  apiClient.configure(baseUrl: baseUrl, apiKey: apiKey);
}
