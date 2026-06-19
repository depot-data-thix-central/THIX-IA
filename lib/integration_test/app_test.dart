import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:thix_ia/main.dart' as app;
import 'package:thix_ia/core/constants/app_strings.dart';
import 'package:thix_ia/core/routing/route_names.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('THIX App Integration Tests', () {
    testWidgets('Complete user journey', (WidgetTester tester) async {
      // 1. Lancement de l'application
      await app.main();
      await tester.pumpAndSettle();

      // 2. Vérification de l'écran d'onboarding
      expect(find.text(AppStrings.appName), findsOneWidget);
      expect(find.text(AppStrings.appTagline), findsOneWidget);
      expect(find.text(AppStrings.next), findsOneWidget);

      // 3. Passage aux paramètres
      await tester.tap(find.text(AppStrings.next));
      await tester.pumpAndSettle();
      expect(find.text(AppStrings.settingsTitle), findsOneWidget);

      // 4. Remplissage des paramètres
      // Endpoint
      await tester.enterText(
        find.byType(TextFormField).first,
        'http://localhost:11434',
      );
      // Sélection du modèle
      await tester.tap(find.text('llama3'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('deepseek-r1').last);
      await tester.pumpAndSettle();
      // Température
      await tester.tap(find.text('0.80'));
      await tester.pumpAndSettle();

      // 5. Sauvegarde
      await tester.tap(find.text(AppStrings.save));
      await tester.pumpAndSettle();
      expect(find.text('Paramètres sauvegardés ✅'), findsOneWidget);

      // 6. Navigation vers le chat (retour puis menu)
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      // Selon la logique, après onboarding, on pourrait aller directement au chat.
      // Ici, on simule l'accès au chat via la barre de navigation si elle existe.
      // Si on a un bottom nav ou un drawer, on peut l'ajouter plus tard.
      // Pour l'instant, on va directement au chat en utilisant la navigation nommée.
      // On suppose que le bouton "Suivant" de l'onboarding nous a menés aux paramètres,
      // puis on revient au chat en appuyant sur "back" et peut-être une redirection.
      // On va tester la présence du chat après sauvegarde en naviguant explicitement.
      await tester.tap(find.byIcon(Icons.chat));
      await tester.pumpAndSettle();

      // 7. Affichage du chat vide
      expect(find.text(AppStrings.thixGreeting), findsOneWidget);

      // 8. Envoi d'un message
      await tester.enterText(find.byType(TextField), 'Bonjour THIX');
      await tester.tap(find.byIcon(Icons.arrow_upward_rounded));
      await tester.pump();

      // 9. Vérification que le message utilisateur apparaît
      expect(find.text('Bonjour THIX'), findsWidgets);
      // L'indicateur de réflexion peut apparaître
      // (nécessite un mock de l'API pour être déterministe)

      // 10. Retour à l'historique (plus tard)
    });
  });
}
