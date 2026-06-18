import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import 'route_names.dart';

/// Routeur principal de THIX.
///
/// Utilise [GoRouter] pour une navigation déclarative.
final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.onboarding,
  routes: [

    // ───── Onboarding (premier lancement) ─────
    GoRoute(
      path: RouteNames.onboarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // ───── Chat (écran principal) ─────
    GoRoute(
      path: RouteNames.chat,
      name: 'chat',
      builder: (context, state) => const ChatScreen(),
    ),

    // ───── Historique des conversations ─────
    GoRoute(
      path: RouteNames.history,
      name: 'history',
      builder: (context, state) => const HistoryScreen(),
      routes: [
        GoRoute(
          path: ':id',
          name: 'conversation',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return ChatScreen(conversationId: id);
          },
        ),
      ],
    ),

    // ───── Paramètres ─────
    GoRoute(
      path: RouteNames.settings,
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),

    // ───── Route par défaut (redirection vers l'onboarding) ─────
    GoRoute(
      path: '/',
      redirect: (_, __) => RouteNames.onboarding,
    ),
  ],

  // Gestion des erreurs 404
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Page introuvable')),
    body: Center(
      child: Text(
        'Erreur 404 : ${state.uri}',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ),
  ),
);
