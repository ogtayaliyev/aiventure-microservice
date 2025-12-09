# Structure du projet AIVenture

## 📁 Organisation des dossiers

```
aiventure-next/
├── app/                          # App Router de Next.js
│   ├── (auth)/                   # Routes d'authentification (sans layout principal)
│   │   ├── login/               # Page de connexion
│   │   ├── signup/              # Page d'inscription
│   │   └── layout.tsx           # Layout pour les pages d'auth
│   ├── (dashboard)/             # Routes du dashboard (avec layout)
│   │   ├── page.tsx             # Page d'accueil du dashboard
│   │   └── layout.tsx           # Layout avec Header/Footer
│   ├── api/                     # Routes API
│   │   ├── auth/                # Endpoints d'authentification
│   │   │   ├── login/           # POST /api/auth/login
│   │   │   └── register/        # POST /api/auth/register
│   │   └── health/              # GET /api/health
│   ├── layout.tsx               # Layout racine
│   ├── page.tsx                 # Page d'accueil
│   └── globals.css              # Styles globaux
│
├── components/                  # Composants réutilisables
│   ├── layout/                  # Composants de layout
│   │   ├── Header.tsx           # En-tête de navigation
│   │   └── Footer.tsx           # Pied de page
│   ├── ui/                      # Composants UI de base
│   │   ├── Button.tsx           # Bouton réutilisable
│   │   └── Card.tsx             # Carte réutilisable
│   └── auth/                    # Composants d'authentification
│
├── lib/                         # Bibliothèques et utilitaires
│   ├── api/                     # Client API
│   │   └── client.ts            # Client pour communiquer avec votre microservice Docker
│   ├── auth/                    # Logique d'authentification
│   └── utils/                   # Fonctions utilitaires
│       └── cn.ts                # Utilitaire pour les classes CSS
│
├── contexts/                    # Contextes React
│   └── AuthContext.tsx          # Contexte d'authentification global
│
├── hooks/                       # Hooks personnalisés
│   └── useRequireAuth.ts        # Hook pour protéger les routes
│
├── types/                       # Types TypeScript
│   └── index.ts                 # Types partagés
│
├── config/                      # Configuration
│   └── site.ts                  # Configuration du site et de l'API
│
└── middleware/                  # Middlewares Next.js
    └── (à ajouter selon besoins)

```

## 🚀 Routes disponibles

### Pages publiques
- `/` - Page d'accueil
- `/login` - Connexion
- `/signup` - Inscription

### API Routes
- `GET /api/health` - Statut de l'API
- `POST /api/auth/login` - Connexion utilisateur
- `POST /api/auth/register` - Inscription utilisateur

## 🔧 Configuration

### Variables d'environnement
Créez un fichier `.env.local` basé sur `.env.local.example` :

```bash
NEXT_PUBLIC_API_URL=http://localhost:8000
NEXT_PUBLIC_APP_URL=http://localhost:3000
JWT_SECRET=votre-secret-key
```

### Client API
Le client API dans `lib/api/client.ts` est configuré pour communiquer avec votre microservice Docker.

Exemple d'utilisation :
```typescript
import { apiClient } from '@/lib/api/client';

// GET request
const data = await apiClient.get('/endpoint');

// POST request avec token
const result = await apiClient.post('/endpoint', { data }, token);
```

## 🔐 Authentification

### AuthContext
Le contexte d'authentification est déjà configuré et fournit :
- `user` - Utilisateur connecté
- `isAuthenticated` - Statut de connexion
- `login()` - Méthode de connexion
- `logout()` - Méthode de déconnexion
- `register()` - Méthode d'inscription

### Protéger une route
```typescript
import { useRequireAuth } from '@/hooks/useRequireAuth';

export default function ProtectedPage() {
  const { isLoading } = useRequireAuth();
  
  if (isLoading) return <div>Chargement...</div>;
  
  return <div>Contenu protégé</div>;
}
```

## 📝 Prochaines étapes

1. Connecter le client API à votre microservice Docker
2. Implémenter la logique d'authentification complète
3. Ajouter vos pages personnalisées dans `app/(dashboard)/`
4. Créer des composants UI supplémentaires selon vos besoins
5. Configurer le middleware pour la protection des routes
