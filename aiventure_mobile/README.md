# 🌍 AIVenture Mobile

Application mobile Flutter moderne pour découvrir et planifier vos aventures de voyage.

![Flutter](https://img.shields.io/badge/Flutter-3.38.3-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.10.1-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

## 📱 Description

AIVenture est une application mobile cross-platform qui vous permet de :

- 🔐 Vous connecter et créer un compte sécurisé
- 🗺️ Découvrir de nouvelles destinations
- 📸 Partager vos souvenirs de voyage
- 👥 Connecter avec d'autres voyageurs
- 🎯 Planifier vos itinéraires personnalisés

## ✨ Fonctionnalités

### Authentification

- Connexion sécurisée avec JWT
- Inscription avec validation de formulaire
- Stockage sécurisé des tokens (Flutter Secure Storage)
- Interface utilisateur moderne et intuitive

### Design System

- 🎨 Charte graphique professionnelle
- 🌈 Palette de couleurs moderne (Indigo/Rose)
- 📐 Système d'espacement cohérent (8px)
- 🔤 Typographie harmonieuse (Inter)
- 🎯 Composants réutilisables

### Architecture

- 🏗️ Architecture Clean (Data/Domain/Presentation)
- 🔄 Gestion d'état avec Riverpod
- 🌐 Client API avec Dio
- 🧪 Services Mock pour le développement
- 📱 Navigation avec GoRouter

## 🚀 Installation

### Prérequis

- Flutter SDK 3.38.3 ou supérieur
- Dart SDK 3.10.1 ou supérieur
- Un éditeur (VS Code, Android Studio, etc.)

### Étapes d'installation

1. **Cloner le repository**

```bash
git clone https://github.com/votre-username/aiventure_mobile.git
cd aiventure_mobile
```

2. **Installer les dépendances**

```bash
flutter pub get
```

3. **Générer les fichiers de code**

```bash
dart run build_runner build --delete-conflicting-outputs
```

4. **Lancer l'application**

Pour le Web :

```bash
flutter run -d chrome
```

Pour Windows :

```bash
flutter run -d windows
```

## 📦 Dépendances principales

| Package                | Version | Description                  |
| ---------------------- | ------- | ---------------------------- |
| flutter_riverpod       | ^2.3.6  | Gestion d'état réactive      |
| go_router              | ^7.0.0  | Navigation déclarative       |
| dio                    | ^5.0.0  | Client HTTP                  |
| freezed                | ^2.3.2  | Génération de code immutable |
| flutter_secure_storage | ^8.0.0  | Stockage sécurisé            |
| image_picker           | ^0.8.7  | Sélection d'images           |
| camera                 | ^0.10.0 | Accès caméra                 |

## 🏗️ Structure du projet

```
lib/
├── core/                      # Code partagé
│   ├── network/              # Configuration réseau
│   ├── permissions/          # Gestion des permissions
│   ├── routing/              # Configuration des routes
│   ├── theme/                # Thème et design system
│   │   ├── app_colors.dart   # Palette de couleurs
│   │   ├── app_text_styles.dart # Styles de texte
│   │   ├── app_spacing.dart  # Système d'espacement
│   │   ├── app_radius.dart   # Border radius
│   │   └── app_theme.dart    # Configuration du thème
│   └── widgets/              # Widgets réutilisables
├── features/                 # Fonctionnalités par domaine
│   ├── auth/                 # Authentification
│   │   ├── data/            # Services et repositories
│   │   ├── domain/          # Modèles de données
│   │   ├── presentation/    # Pages et widgets UI
│   │   └── providers/       # Providers Riverpod
│   ├── chat/                # Messagerie
│   ├── friends/             # Amis
│   ├── itineraries/         # Itinéraires
│   └── memories/            # Souvenirs
└── main.dart                # Point d'entrée
```

## 🎨 Charte graphique

### Couleurs principales

- **Primaire** : `#6366F1` (Indigo)
- **Secondaire** : `#EC4899` (Rose)
- **Succès** : `#10B981` (Vert)
- **Erreur** : `#EF4444` (Rouge)

### Typographie

- **Police** : Inter
- **Tailles** : 11px à 57px
- **Poids** : 400 (Regular), 600 (SemiBold), 700 (Bold)

### Espacements

- **Base** : 8px
- **XS** : 4px
- **SM** : 8px
- **MD** : 16px
- **LG** : 24px
- **XL** : 32px

## 🔧 Configuration

### Mode développement vs Production

L'application utilise des services Mock par défaut. Pour basculer vers l'API réelle :

```dart
// Dans lib/core/providers.dart
final useMockBackendProvider = Provider<bool>((ref) => false); // false pour prod
final baseUrlProvider = Provider<String>((ref) => 'https://votre-api.com');
```

### Variables d'environnement

Créez un fichier `.env` à la racine :

```env
API_BASE_URL=https://votre-api.com
API_TIMEOUT=15000
```

## 🧪 Tests

Lancer les tests :

```bash
flutter test
```

Lancer les tests avec couverture :

```bash
flutter test --coverage
```

## 📱 Plateformes supportées

- ✅ Web (Chrome, Edge, Firefox)
- ✅ Windows
- ✅ Android (nécessite Java 17 + Android SDK)
- ✅ iOS (nécessite Xcode + macOS)
- ✅ macOS
- ✅ Linux

## 🤝 Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Fork le projet
2. Créez votre branche (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 👨‍💻 Auteur

**Aliyev OGTAY**

## 🙏 Remerciements

- Flutter Team pour le framework
- Riverpod pour la gestion d'état
- La communauté Flutter

## 📞 Support

Pour toute question ou support :

- 📧 Email : votre@email.com
- 🐛 Issues : [GitHub Issues](https://github.com/votre-username/aiventure_mobile/issues)

---

Made with ❤️ using Flutter
