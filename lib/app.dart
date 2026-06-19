import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';

/// Widget racine de l'application THIX.
class ThixApp extends StatelessWidget {
  const ThixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'THIX IA',
      debugShowCheckedModeBanner: false,
      // Thème sombre exclusif
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      // Navigation déclarative via GoRouter
      routerConfig: appRouter,
    );
  }
}
