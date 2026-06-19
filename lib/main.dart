import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/injection_container.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialise les services asynchrones (stockage, réseau, etc.)
  await initializeServices();

  // Lance l'application avec le conteneur Riverpod
  runApp(
    const ProviderScope(
      child: ThixApp(),
    ),
  );
}
