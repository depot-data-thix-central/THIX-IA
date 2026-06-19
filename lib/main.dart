import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/injection_container.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisation des services (stockage, API, etc.)
  await initializeServices();

  // Lancement de l'application avec ProviderScope (Riverpod)
  runApp(
    const ProviderScope(
      child: ThixApp(),
    ),
  );
}

/// Widget racine de l'application.
class ThixApp extends StatelessWidget {
  const ThixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'THIX IA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark, // THIX est sombre par défaut
      routerConfig: appRouter,
    );
  }
}
