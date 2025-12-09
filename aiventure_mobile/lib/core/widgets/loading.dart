import 'package:flutter/material.dart';

/// Widget réutilisable pour afficher un indicateur de chargement centré
/// Utilisé pendant les requêtes API ou les opérations asynchrones
class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}
