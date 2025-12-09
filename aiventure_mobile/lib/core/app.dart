import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routing/app_router.dart';
import 'theme/app_theme.dart';

/// Widget principal de l'application AIventure
/// Configure le thème Material 3 et le routage GoRouter avec Riverpod
class AiventureApp extends ConsumerWidget {
  const AiventureApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Récupère le routeur depuis Riverpod pour la navigation déclarative
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Aiventure',
      theme: AppTheme.light(), // Applique le thème personnalisé Material 3
      routerConfig: router, // Configure GoRouter pour la navigation
    );
  }
}
