# 🚀 Démarrage Rapide - AiVenture Gateway

## 📥 Après avoir cloné depuis GitHub

### Étape 1 : Cloner le projet

```bash
git clone https://github.com/VOTRE-USERNAME/aiventure-gateway.git
cd aiventure-gateway
```

---

## 🐳 Option A : Démarrage avec Docker (Recommandé)

**Pas besoin de Java, Maven ou PostgreSQL installés !**

### 1. Prérequis
- ✅ Docker Desktop
- ✅ Git

### 2. Créer le fichier `.env`

```bash
# Copier le fichier d'exemple
cp .env.example .env
```

**Ou créer `.env` avec ce contenu** :

```env
# JWT
JWT_SECRET=AiVenture2024SuperSecureJwtSecretKey
JWT_EXPIRATION=3600000
JWT_REFRESH_EXPIRATION=86400000

# Base de données
DB_HOST=postgres
DB_PORT=5432
DB_NAME=aiventure_gateway
DB_USERNAME=root
DB_PASSWORD=root

# Admin
DEFAULT_ADMIN_USERNAME=admin
DEFAULT_ADMIN_PASSWORD=Admin2024.
DEFAULT_ADMIN_EMAIL=admin@admin.com

# Serveur
SERVER_PORT=8080
```

### 3. Lancer avec Docker

```bash
# Construire et démarrer
docker-compose up --build -d

# Attendre 30 secondes que tout démarre...
```

### 4. Vérifier

```bash
# Voir les containers
docker-compose ps

# Tester l'API
curl http://localhost:8080/actuator/health
```

### 5. Accéder aux services

- 🌐 **API** : http://localhost:8080
- 📚 **Swagger** : http://localhost:8080/swagger-ui.html
- 🗄️ **Base de données (Adminer)** : http://localhost:8081

### 6. Arrêter

```bash
# Arrêter les containers
docker-compose down

# Arrêter ET supprimer les données
docker-compose down -v
```

---

## ☕ Option B : Démarrage Manuel (sans Docker)

### Prérequis

- ✅ Java 17+
- ✅ Maven 3.8+
- ✅ PostgreSQL 15+

### 1. Installer les dépendances Java

```bash
# Télécharger toutes les dépendances Maven
mvn clean install -DskipTests
```

**Cette commande va** :
- Télécharger Spring Boot, PostgreSQL driver, JWT, etc.
- Compiler le projet
- Créer le fichier JAR

### 2. Configurer PostgreSQL

### 2. Configurer PostgreSQL

**Option A: Script automatique (Recommandé)**

```powershell
# Exécuter en tant qu'administrateur
.\setup-postgresql.ps1
```

**Option B: Configuration manuelle**

```sql
-- Se connecter à PostgreSQL en tant que superutilisateur
psql -U postgres

-- Exécuter les scripts
\i database/setup_database.sql
\c aiventure_gateway
\i database/schema.sql
```

### 3. Créer le fichier `.env`

```bash
cp .env.example .env
```

### 4. Lancer l'application

### 4. Lancer l'application

```bash
mvn spring-boot:run
```

L'application sera disponible sur : **http://localhost:8080**

---

## 🔍 Différences entre Docker et Manuel

| Aspect | Docker | Manuel |
|--------|--------|--------|
| **Installation** | Juste Docker Desktop | Java 17 + Maven + PostgreSQL |
| **Dépendances** | Automatique | `mvn clean install` |
| **Base de données** | Incluse (PostgreSQL) | À installer séparément |
| **Configuration** | Fichier `.env` | Fichier `.env` + setup DB |
| **Lancement** | `docker-compose up` | `mvn spring-boot:run` |
| **Temps démarrage** | ~30 secondes | ~10 secondes |
| **Recommandé pour** | Débutants, équipe | Développement actif |

---

## 🔐 Test de l'API

### Connexion

```bash
curl -X POST http://localhost:8080/api/auth/signin \
  -H "Content-Type: application/json" \
  -d "{\"username\": \"admin\", \"password\": \"admin123\"}"
```

### Test du Gateway

```bash
# Avec le token reçu
curl -X GET http://localhost:8080/api/gateway/health \
  -H "Authorization: Bearer VOTRE_TOKEN"
```

## 📊 Monitoring

- **Health Check**: http://localhost:8080/actuator/health
- **Base de données**: `psql -U aiventure_user -d aiventure_gateway`

## 🔒 Utilisateurs par défaut

| Username | Password | Rôles       |
| -------- | -------- | ----------- |
| admin    | admin123 | ADMIN, USER |

## 🚨 Sécurité

- ✅ JWT avec expiration courte (1h)
- ✅ Blocage après 5 tentatives échouées
- ✅ Limitation des sessions (3 max par utilisateur)
- ✅ Audit des connexions
- ✅ CORS sécurisé
- ✅ Validation des entrées

## 🔧 Endpoints principaux

```
POST /api/auth/signin        # Connexion
POST /api/auth/refreshtoken  # Rafraîchir token
POST /api/auth/signout       # Déconnexion
GET  /api/gateway/health     # Status des services
*    /api/gateway/auth/**    # Proxy vers auth-service
*    /api/gateway/ia/**      # Proxy vers ia-service
*    /api/gateway/social/**  # Proxy vers social-service
```

## ⚠️ Production

Avant la mise en production, modifiez :

1. **JWT Secret** dans les variables d'environnement
2. **Mots de passe** de la base de données
3. **CORS origins** dans application.properties
4. **SSL/TLS** (décommentez dans application.properties)
5. **Logs level** → INFO/WARN
