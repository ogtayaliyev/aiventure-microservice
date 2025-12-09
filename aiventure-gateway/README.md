# 🛡️ AiVenture Gateway - API Gateway Enterprise

Gateway de sécurité et d'authentification pour l'écosystème microservices AiVenture. Point d'entrée unique avec JWT, protection anti-attaques, audit complet et documentation Swagger intégrée.

[![Java](https://img.shields.io/badge/Java-17-orange.svg)](https://openjdk.java.net/projects/jdk/17/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.7-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue.svg)](https://www.postgresql.org/)
[![Docker](https://img.shields.io/badge/Docker-Compose-blue.svg)](https://docs.docker.com/compose/)
[![Swagger](https://img.shields.io/badge/Swagger-3.0-85EA2D.svg)](https://swagger.io/)

## 📋 Table des Matières

- [🏗️ Architecture](#architecture)
- [⭐ Fonctionnalités](#fonctionnalités)
- [🔐 API Endpoints](#api-endpoints)
- [🛡️ Sécurité JWT](#sécurité-jwt)
- [📚 Documentation Swagger](#documentation-swagger)
- [🚀 Installation](#installation)
- [📊 Monitoring](#monitoring)

## 🏗️ Architecture

```
Client -> Gateway (Port 8080) -> Microservices
                  │
                  ├── 🔐 JWT Authentication
                  ├── 🛡️ Rate Limiting
                  ├── 📊 Session Management
                  ├── 🔍 Audit Logging
                  │
                  └── Microservices
                      ├── Auth Service (Port 8081)
                      ├── IA Service (Port 8082)
                      └── Social Service (Port 8083)
```

## ⭐ Fonctionnalités

### 🔐 Authentification & Sécurité

- **🔑 JWT Authentication** : Tokens sécurisés avec expiration (1h access, 24h refresh)
- **👤 Inscription/Connexion** : Endpoints complets avec validation avancée
- **🛡️ Anti-Brute Force** : Blocage automatique après 5 tentatives échouées (15 min)
- **🌐 Protection IP** : Blocage intelligent des adresses suspectes
- **📊 Sessions Management** : Maximum 3 sessions actives par utilisateur
- **🔍 Audit Logging** : Traçage complet de toutes les tentatives de connexion
- **✅ Validation Stricte** : Contrôles d'entrée et sanitisation des données

### 📚 Documentation API

- **📋 Swagger UI** : Interface interactive pour tester les endpoints
- **📄 OpenAPI 3.0** : Spécifications complètes de l'API
- **🔐 JWT Integration** : Authentification directe dans Swagger
- **📝 Documentation Détaillée** : Descriptions complètes des endpoints

### 🚀 Production Ready

- **🐘 PostgreSQL** : Base de données robuste avec pool de connexions optimisé
- **🐳 Docker Compose** : Déploiement containerisé complet
- **📈 Monitoring** : Health checks et métriques intégrées
- **🔒 CORS Sécurisé** : Configuration restrictive pour la production
- **🧹 Auto-Cleanup** : Nettoyage automatique des données expirées

## 🔐 API Endpoints

### 🔓 Endpoints Publics (sans authentification)

| Méthode | Endpoint                 | Description                 | Paramètres                                     |
| ------- | ------------------------ | --------------------------- | ---------------------------------------------- |
| `POST`  | `/api/auth/signin`       | **Connexion utilisateur**   | `username`, `password`                         |
| `POST`  | `/api/auth/signup`       | **Inscription utilisateur** | `name`, `email`, `password`, `confirmPassword` |
| `POST`  | `/api/auth/refreshtoken` | **Renouvellement token**    | `refreshToken`                                 |

### 🔒 Endpoints Protégés (JWT requis)

| Méthode | Endpoint            | Description                | Rôle Requis |
| ------- | ------------------- | -------------------------- | ----------- |
| `POST`  | `/api/auth/signout` | **Déconnexion**            | USER        |
| `GET`   | `/api/gateway/**`   | **Administration Gateway** | ADMIN       |

### 📚 Documentation & Monitoring

| Méthode | Endpoint           | Description                    |
| ------- | ------------------ | ------------------------------ |
| `GET`   | `/swagger-ui.html` | **Interface Swagger UI**       |
| `GET`   | `/v3/api-docs`     | **Spécifications OpenAPI 3.0** |
| `GET`   | `/actuator/health` | **Health Check**               |

---

## 🛡️ Sécurité JWT

### 🔑 Structure du Token JWT

```json
{
  "header": {
    "alg": "HS256",
    "typ": "JWT"
  },
  "payload": {
    "sub": "admin@example.com",
    "iat": 1732998400,
    "exp": 1733002000,
    "roles": ["ADMIN", "USER"]
  }
}
```

### ⏱️ Durées de Vie

| Type              | Durée     | Usage                             |
| ----------------- | --------- | --------------------------------- |
| **Access Token**  | 1 heure   | Authentification des requêtes API |
| **Refresh Token** | 24 heures | Renouvellement des access tokens  |
| **Session**       | Variable  | Gestion des sessions actives      |

### 🔐 Configuration Sécurité

```yaml
JWT:
  Secret: 64+ caractères sécurisés
  Algorithm: HS256
  Issuer: AiVenture Gateway

Rate Limiting:
  Max Tentatives: 5 par 15 minutes
  Blocage IP: 15 minutes
  Blocage Compte: 15 minutes

Sessions:
  Max par utilisateur: 3
  Nettoyage auto: Toutes les heures
```

---

## 📚 Documentation Swagger

### 🌐 Accès à Swagger UI

```bash
# Interface interactive
http://localhost:8080/swagger-ui.html

# Spécifications JSON
http://localhost:8080/v3/api-docs

# Spécifications YAML
http://localhost:8080/v3/api-docs.yaml
```

### 🔐 Authentification dans Swagger

1. **Obtenir un token** via `/api/auth/signin`
2. **Cliquer sur "Authorize"** dans Swagger UI
3. **Entrer** : `Bearer YOUR_JWT_TOKEN`
4. **Tester les endpoints** protégés directement

### 📝 Exemple d'utilisation Swagger

```javascript
// 1. Inscription
POST /api/auth/signup
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "SecurePass123!",
  "confirmPassword": "SecurePass123!"
}

// 2. Connexion
POST /api/auth/signin
{
  "username": "john@example.com",
  "password": "SecurePass123!"
}

// 3. Utiliser le token retourné pour les autres endpoints
```

---

## 📁 Structure du Projet

````
src/main/java/com/example/aiventuregateway/
├── config/                 # Configuration Spring & OpenAPI
│   ├── AppConfig.java      # Configuration générale
│   ├── DataInitializer.java # Initialisation des données
│   └── OpenApiConfig.java  # Configuration Swagger/OpenAPI
├── controller/             # Contrôleurs REST
│   ├── AuthController.java # Authentification (signin, signup)
│   └── GatewayController.java # Administration
├── dto/                   # DTOs avec validation
│   ├── AuthRequest.java   # Requête de connexion
│   ├── AuthResponse.java  # Réponse d'authentification
│   ├── SignupRequest.java # Requête d'inscription
│   └── RefreshTokenRequest.java # Requête refresh
├── entity/                # Entités JPA
│   ├── User.java          # Utilisateurs avec rôles
│   ├── RefreshToken.java  # Tokens de rafraîchissement
│   ├── LoginAttempt.java  # Audit des tentatives
│   ├── ActiveSession.java # Sessions actives
│   └── Role.java          # Énumération des rôles
├── repository/            # Repositories JPA
├── security/              # Configuration sécurité
│   ├── ApplicationSecurity.java # Config Spring Security
│   ├── jwt/              # Gestion JWT
│   └── service/          # Services d'authentification
└── service/              # Services métier

---

## 🔧 Exemples d'Utilisation API

### 🆕 Inscription d'un Utilisateur

**Endpoint** : `POST /api/auth/signup`

**Requête** :
```json
{
  "name": "Marie Dupont",
  "email": "marie.dupont@example.com",
  "password": "MonMotDePasse123!",
  "confirmPassword": "MonMotDePasse123!"
}
````

**Validation** :

- ✅ Mot de passe : min 8 caractères + 1 majuscule + 1 caractère spécial
- ✅ Email : format valide et unique
- ✅ Nom : entre 2 et 50 caractères
- ✅ Confirmation : doit correspondre au mot de passe

**Réponse Succès (200)** :

```json
{
  "message": "Inscription réussie! Vous pouvez maintenant vous connecter.",
  "userId": 123
}
```

**Erreurs Possibles** :

```json
// 400 - Email déjà utilisé
{
  "error": "Email déjà utilisé"
}

// 400 - Mots de passe différents
{
  "error": "Les mots de passe ne correspondent pas"
}
```

---

### 🔑 Connexion Utilisateur

**Endpoint** : `POST /api/auth/signin`

**Requête** :

```json
{
  "username": "marie.dupont@example.com",
  "password": "MonMotDePasse123!"
}
```

**Réponse Succès (200)** :

```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9...",
  "type": "Bearer",
  "refreshToken": "a1b2c3d4-e5f6-7890-1234-567890abcdef",
  "sessionToken": "x1y2z3a4-b5c6-d7e8-f9g0-h1i2j3k4l5m6",
  "id": 123,
  "username": "marie.dupont@example.com",
  "email": "marie.dupont@example.com",
  "roles": ["USER"]
}
```

---

### 📊 Tests avec PowerShell

```powershell
# Variables
$baseUrl = "http://localhost:8080"
$headers = @{"Content-Type" = "application/json"}

# 1. Inscription
$signupData = @{
    name = "Test User"
    email = "test@example.com"
    password = "TestPassword123!"
    confirmPassword = "TestPassword123!"
} | ConvertTo-Json

$signupResponse = Invoke-RestMethod -Uri "$baseUrl/api/auth/signup" -Method POST -Body $signupData -Headers $headers

# 2. Connexion
$loginData = @{
    username = "test@example.com"
    password = "TestPassword123!"
} | ConvertTo-Json

$loginResponse = Invoke-RestMethod -Uri "$baseUrl/api/auth/signin" -Method POST -Body $loginData -Headers $headers
$token = $loginResponse.token
```

│ └── ActiveSession.java # Gestion des sessions
├── repository/ # Repositories optimisés
├── security/ # Sécurité avancée
│ ├── jwt/ # JWT utils, filters & entry points
│ └── service/ # Services d'authentification
└── service/ # Services métier
├── SecurityService.java # Gestion sécurité
├── GatewayService.java # Routage microservices
└── RefreshTokenService.java # Gestion tokens

database/ # Scripts PostgreSQL
├── setup_database.sql # Création DB et utilisateur
└── schema.sql # Tables avec indexes optimisés

````

## ⚙️ Configuration

### 🗄️ Base de Données

- **PostgreSQL 18.1** avec utilisateur dédié non-privilégié
- **Pool HikariCP** optimisé (20 max, 5 min idle)
- **Index performants** sur toutes les requêtes fréquentes
- **Triggers automatiques** pour la maintenance des données

### 🔧 Variables d'Environnement

```bash
# Sécurité JWT
JWT_SECRET=VotreCleSecureDeMinimum64CaracteresIciPourProduction123456789

# Base de données
DB_USERNAME=aiventure_user
DB_PASSWORD=VotreMotDePasseSuperSecurise2024!

# CORS Production
CORS_ORIGINS=https://yourdomain.com,https://app.yourdomain.com
````

### 🌐 URLs des Microservices

```properties
microservices.auth.url=http://localhost:8081
microservices.ia.url=http://localhost:8082
microservices.social.url=http://localhost:8083
```

## 👥 Utilisateurs par Défaut

| Username | Password | Rôles       | Description            |
| -------- | -------- | ----------- | ---------------------- |
| admin    | admin123 | ADMIN, USER | Administrateur système |

⚠️ **IMPORTANT** : Changez le mot de passe admin en production !

## 🔌 API Endpoints

### 🔐 Authentification

- **POST** `/api/auth/signin` - Connexion sécurisée
- **POST** `/api/auth/refreshtoken` - Rafraîchir le token JWT
- **POST** `/api/auth/signout` - Déconnexion avec nettoyage des sessions

### 🌉 Gateway (Authentification requise)

- **\*** `/api/gateway/auth/**` - Proxy vers service d'authentification
- **\*** `/api/gateway/ia/**` - Proxy vers service IA (USER/ADMIN)
- **\*** `/api/gateway/social/**` - Proxy vers service social (USER/ADMIN)
- **GET** `/api/gateway/health` - Santé des services (ADMIN seulement)

### 📊 Monitoring & Administration

- **GET** `/actuator/health` - Santé de la gateway (authentifié)
- **GET** `/actuator/metrics` - Métriques de performance (ADMIN)
- **GET** `/actuator/info` - Informations de l'application

## 🚀 Démarrage Rapide (pour vos collègues)

### ✅ Prérequis

Votre collègue doit avoir installé :
- **Docker Desktop** (avec Docker Compose)
- **Git**

C'est tout ! Pas besoin de Java, Maven ou PostgreSQL.

---

### 📥 Étape 1 : Cloner le Projet

```bash
# Cloner depuis GitHub
git clone https://github.com/VOTRE-USERNAME/aiventure-gateway.git

# Aller dans le dossier
cd aiventure-gateway
```

---

### 🔧 Étape 2 : Configurer les Variables

Créer un fichier `.env` à la racine :

```bash
# Copier le fichier d'exemple
cp .env.example .env
```

**OU** créer manuellement `.env` avec ce contenu minimum :

```env
# JWT
JWT_SECRET=AiVenture2024SuperSecureJwtSecretKeyForProductionEnvironmentWithMinimum64Characters123456789
JWT_EXPIRATION=3600000
JWT_REFRESH_EXPIRATION=86400000

# Base de données
DB_HOST=postgres
DB_PORT=5432
DB_NAME=aiventure_gateway
DB_USERNAME=root
DB_PASSWORD=root

# Admin par défaut
DEFAULT_ADMIN_USERNAME=admin
DEFAULT_ADMIN_PASSWORD=Admin2024.
DEFAULT_ADMIN_EMAIL=admin@admin.com

# Serveur
SERVER_PORT=8080
```

---

### 🚀 Étape 3 : Lancer avec Docker

```bash
# Construire et démarrer tous les services
docker-compose up --build -d
```

**Attendre 30-40 secondes** que tout démarre...

---

### ✅ Étape 4 : Vérifier que ça Marche

```bash
# Vérifier les containers
docker-compose ps

# Tester l'API
curl http://localhost:8080/actuator/health
```

**Ou ouvrir dans le navigateur** :
- 🌐 **Swagger UI** : http://localhost:8080/swagger-ui.html
- 🏥 **Health** : http://localhost:8080/actuator/health
- 🗄️ **Adminer (DB)** : http://localhost:8081

---

### 🔑 Connexion par Défaut

**Via Swagger ou Postman** :

```json
POST http://localhost:8080/api/auth/signin

{
  "username": "admin",
  "password": "Admin2024."
}
```

---

### 🛑 Arrêter l'Application

```bash
# Arrêter les containers
docker-compose down

# Arrêter ET supprimer les données
docker-compose down -v
```

---

### 🔧 Commandes Utiles

```bash
# Voir les logs en temps réel
docker-compose logs -f app

# Reconstruire après changement de code
docker-compose up --build -d

# Redémarrer un service
docker-compose restart app

# Accéder au container
docker-compose exec app sh
```

---

## 🚀 Installation Manuelle (sans Docker)

### 📋 Prérequis

- **Java 17+**
- **Maven 3.8+**
- **PostgreSQL 13+**

### 🔧 Installation

1. **Configurer PostgreSQL** (en tant qu'administrateur)

   ```powershell
   .\setup-postgresql.ps1
   ```

2. **Compiler le projet**

   ```bash
   mvn clean compile
   ```

3. **Lancer l'application**

   ```bash
   mvn spring-boot:run
   ```

4. **Vérifier le démarrage**
   ```bash
   curl http://localhost:8080/actuator/health
   ```

## 💡 Exemples d'Utilisation

### 1. 🔐 Connexion

```bash
curl -X POST http://localhost:8080/api/auth/signin \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "admin123"}'

# Réponse :
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "type": "Bearer",
  "refreshToken": "550e8400-e29b-41d4-a716-446655440000",
  "sessionToken": "session-uuid-here",
  "id": 1,
  "username": "admin",
  "email": "admin@aiventure.com",
  "roles": ["ADMIN", "USER"]
}
```

### 2. 🔑 Utilisation du Token

```bash
curl -X GET http://localhost:8080/api/gateway/ia/analyze \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json"
```

### 3. 🔄 Rafraîchir le Token

```bash
curl -X POST http://localhost:8080/api/auth/refreshtoken \
  -H "Content-Type: application/json" \
  -d '{"refreshToken": "YOUR_REFRESH_TOKEN"}'
```

### 4. 📊 Vérifier la Santé des Services (Admin)

```bash
curl -X GET http://localhost:8080/api/gateway/health \
  -H "Authorization: Bearer YOUR_ADMIN_JWT_TOKEN"
```

## 🛡️ Sécurité

### 🔐 Authentification & Autorisation

- **JWT Secret** : Clé de 64+ caractères (variable d'environnement)
- **Tokens courte durée** : 1h (access) / 24h (refresh)
- **Chiffrement BCrypt** : Salt de 12 rounds
- **Sessions limitées** : Max 3 sessions actives par utilisateur

### 🛡️ Protection Anti-Attaques

- **Rate Limiting** : 5 tentatives max/compte (15 min blocage)
- **IP Protection** : 10 tentatives max/IP (15 min blocage)
- **Audit Trail** : Logs sécurisés de toutes les tentatives
- **Session Management** : Nettoyage automatique des sessions expirées

### 🌐 Configuration Réseau

- **CORS Restrictif** : Origins spécifiques (pas de wildcard)
- **Headers Sécurisés** : Protection XSS et clickjacking
- **HTTPS Ready** : Configuration SSL/TLS pour production

### ✅ Validation des Données

- **Input Validation** : Contrôles stricts sur tous les champs
- **SQL Injection** : Protection JPA/Hibernate
- **XSS Prevention** : Échappement automatique

## 🏭 Configuration Production

### 🔧 Variables d'Environnement Essentielles

```bash
# Sécurité
export JWT_SECRET="VotreCleSecureDeMinimum64CaracteresAleatoiresPourProduction2024"
export DB_PASSWORD="MotDePasseComplexeAvecChiffresEtSymboles2024!"

# Réseau
export CORS_ORIGINS="https://yourdomain.com,https://app.yourdomain.com"
export SERVER_PORT=8080

# Base de données
export DB_URL="jdbc:postgresql://your-db-server:5432/aiventure_gateway"
export DB_USERNAME="aiventure_user"
```

### ✅ Checklist de Sécurisation

- [ ] **JWT Secret** : Clé aléatoire de 64+ caractères
- [ ] **Base de données** : Utilisateur dédié non-privilégié
- [ ] **HTTPS** : Certificat SSL/TLS valide activé
- [ ] **CORS** : Domaines spécifiques uniquement
- [ ] **Logs** : Niveau INFO (pas DEBUG)
- [ ] **Monitoring** : Alertes sur métriques critiques
- [ ] **Backup** : Sauvegardes automatisées PostgreSQL
- [ ] **Firewall** : Ports 8080 et 5432 sécurisés
- [ ] **Updates** : Mises à jour sécurité planifiées

### ⚡ Performance & Monitoring

**Configuration JVM Recommandée :**

```bash
-Xms512m -Xmx2g
-XX:+UseG1GC
-XX:MaxGCPauseMillis=200
-Djava.security.egd=file:/dev/./urandom
```

**Pool de Connexions :**

- Production : 20-50 connexions max selon charge
- Timeout : 20s connexion, 10min idle
- Validation : Test avant utilisation

**Intégrations Recommandées :**

- **Prometheus + Grafana** : Métriques temps réel
- **ELK Stack** : Centralisation des logs
- **Sentry** : Monitoring erreurs applicatives

## 📞 Support & Maintenance

### 🔧 Scripts Utiles

```bash
# Nettoyage manuel des sessions expirées
./scripts/cleanup-sessions.sql

# Analyse des tentatives de connexion suspectes
./scripts/security-audit.sql

# Vérification performance base de données
./scripts/db-performance-check.sql
```

### 📊 Métriques Importantes à Surveiller

- Tentatives de connexion échouées > 100/min
- Sessions actives > 1000
- Temps de réponse > 2s
- Utilisation CPU > 80%
- Connexions DB > 80% du pool

---

🛡️ **AiVenture Gateway** - Sécurité de niveau entreprise pour vos microservices
