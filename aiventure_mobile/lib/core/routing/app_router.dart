import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/profile_page.dart';
import '../../features/auth/presentation/register_page.dart';
import '../../features/chat/presentation/chat_page.dart';
import '../../features/friends/presentation/add_friend_page.dart';
import '../../features/friends/presentation/friends_page.dart';
import '../../features/itineraries/presentation/itineraries_page.dart';
import '../../features/itineraries/presentation/itinerary_detail_page.dart';
import '../../features/memories/presentation/add_memory_page.dart';
import '../../features/memories/presentation/memories_page.dart';

/// Provider du routeur de navigation GoRouter
/// Configure toutes les routes de l'application avec navigation déclarative
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash', // Page de démarrage
    routes: [
      // Route de splash screen avec redirection automatique vers login
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),

      // Routes d'authentification
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),

      // Route principale avec shell navigation (AppBar + body)
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeShell(),
        routes: [
          // Route du profil utilisateur
          GoRoute(path: 'profile', builder: (c, s) => const ProfilePage()),

          // Routes de gestion des amis
          GoRoute(path: 'friends', builder: (c, s) => const FriendsPage()),
          GoRoute(
            path: 'friends/add',
            builder: (c, s) => const AddFriendPage(),
          ),

          // Routes de gestion des souvenirs (photos)
          GoRoute(path: 'memories', builder: (c, s) => const MemoriesPage()),
          GoRoute(
            path: 'memories/add',
            builder: (c, s) => const AddMemoryPage(),
          ),

          // Routes de gestion des itinéraires de voyage
          GoRoute(
            path: 'itineraries',
            builder: (c, s) => const ItinerariesPage(),
          ),
          GoRoute(
            path: 'itineraries/:id',
            builder: (c, s) =>
                ItineraryDetailPage(id: s.pathParameters['id'] ?? ''),
          ),

          // Route du chat
          GoRoute(path: 'chat', builder: (c, s) => const ChatPage()),
        ],
      ),
    ],
  );
});

/// Page de démarrage (Splash Screen)
/// Affiche un indicateur de chargement puis redirige vers la page de connexion après 1 seconde
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Redirection automatique vers /login après 1 seconde
    Future.microtask(
      () => Future.delayed(
        const Duration(seconds: 1),
        () => context.go('/login'),
      ),
    );
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

/// Shell de navigation principal de l'application
/// Fournit une AppBar commune et un body central pour toutes les pages /home/*
class HomeShell extends StatelessWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aiventure')),
      body: Center(
        child: Text('Bienvenue — utilisez la navigation pour tester les pages'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: const Text('Profile'),
                    onTap: () => context.go('/home/profile'),
                  ),
                  ListTile(
                    title: const Text('Friends'),
                    onTap: () => context.go('/home/friends'),
                  ),
                  ListTile(
                    title: const Text('Memories'),
                    onTap: () => context.go('/home/memories'),
                  ),
                  ListTile(
                    title: const Text('Itineraries'),
                    onTap: () => context.go('/home/itineraries'),
                  ),
                  ListTile(
                    title: const Text('Chat'),
                    onTap: () => context.go('/home/chat'),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Déconnexion'),
              onTap: () => context.go('/login'),
            ),
          ],
        ),
      ),
    );
  }
}
