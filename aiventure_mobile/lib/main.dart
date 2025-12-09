import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app.dart';

/// Point d'entrée principal de l'application AIventure
/// Initialise Flutter et lance l'application avec Riverpod pour la gestion d'état
void main() async {
  // Initialise les bindings Flutter avant l'exécution de l'application
  WidgetsFlutterBinding.ensureInitialized();

  // Lance l'application avec le ProviderScope pour Riverpod
  runApp(const ProviderScope(child: AiventureApp()));
}
