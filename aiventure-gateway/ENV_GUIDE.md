# 🔐 Guide des Variables d'Environnement - AiVenture Gateway

Ce document décrit toutes les variables d'environnement utilisées par l'AiVenture Gateway.

## 📁 Fichiers de Configuration

### `.env` - Variables de Production

Contient tous les secrets et configurations sensibles. **Ne jamais commiter ce fichier !**

### `.env.example` - Template

Template pour créer votre fichier `.env`. Safe à commiter.

### `generate-secrets.ps1` - Générateur

Script PowerShell pour générer des secrets sécurisés automatiquement.

## 🔑 Variables Critiques

### JWT & Sécurité

```bash
JWT_SECRET=                    # Clé JWT (64+ caractères) - CRITIQUE
JWT_EXPIRATION=3600000         # Durée token (1h en ms)
JWT_REFRESH_EXPIRATION=86400000 # Durée refresh (24h en ms)
ENCRYPTION_SECRET_KEY=         # Clé chiffrement données sensibles
```

### Base de Données

```bash
DB_HOST=localhost              # Serveur PostgreSQL
DB_PORT=5432                   # Port PostgreSQL
DB_NAME=aiventure_gateway      # Nom base de données
DB_USERNAME=aiventure_user     # Utilisateur BDD
DB_PASSWORD=                   # Mot de passe BDD - CRITIQUE
DB_URL=                        # URL complète de connexion
```

### Utilisateurs par Défaut

```bash
DEFAULT_ADMIN_USERNAME=admin   # Nom admin par défaut
DEFAULT_ADMIN_PASSWORD=        # Mot de passe admin - CRITIQUE
DEFAULT_ADMIN_EMAIL=           # Email admin
```

## 🌐 Configuration Réseau

### CORS

```bash
CORS_ALLOWED_ORIGINS=          # Domaines autorisés (séparés par ,)
CORS_ALLOWED_METHODS=          # Méthodes HTTP autorisées
CORS_ALLOWED_HEADERS=          # Headers autorisés
CORS_ALLOW_CREDENTIALS=true    # Autoriser cookies/auth
CORS_MAX_AGE=3600             # Cache preflight (secondes)
```

### SSL/TLS

```bash
SERVER_SSL_ENABLED=false       # Activer HTTPS
SERVER_SSL_KEYSTORE=           # Chemin keystore
SERVER_SSL_KEYSTORE_PASSWORD=  # Mot de passe keystore - CRITIQUE
SERVER_SSL_KEYSTORE_TYPE=PKCS12 # Type keystore
```

## 🔧 Microservices

### URLs et API Keys

```bash
MICROSERVICE_AUTH_URL=         # URL service auth
MICROSERVICE_AUTH_API_KEY=     # Clé API auth - CRITIQUE
MICROSERVICE_IA_URL=           # URL service IA
MICROSERVICE_IA_API_KEY=       # Clé API IA - CRITIQUE
MICROSERVICE_SOCIAL_URL=       # URL service social
MICROSERVICE_SOCIAL_API_KEY=   # Clé API social - CRITIQUE
```

## 🛡️ Sécurité Renforcée

### Protection Anti-Attaques

```bash
SECURITY_MAX_FAILED_ATTEMPTS=5    # Tentatives max avant blocage
SECURITY_LOCKOUT_DURATION=15      # Durée blocage (minutes)
SECURITY_MAX_SESSIONS_PER_USER=3  # Sessions max par utilisateur
SECURITY_SESSION_TIMEOUT=24       # Timeout session (heures)
SECURITY_BCRYPT_ROUNDS=12         # Complexité hashage mot de passe
```

## 📊 Monitoring

### Actuator

```bash
MANAGEMENT_ENDPOINTS_EXPOSURE=health,info,metrics # Endpoints exposés
MANAGEMENT_SECURITY_ENABLED=true                  # Sécuriser actuator
ACTUATOR_USERNAME=actuator                        # User monitoring
ACTUATOR_PASSWORD=                                # Password monitoring - CRITIQUE
```

### Logging

```bash
LOG_LEVEL_ROOT=INFO            # Niveau log global
LOG_LEVEL_AIVENTURE=INFO       # Niveau log application
LOG_LEVEL_SECURITY=WARN        # Niveau log sécurité
LOG_LEVEL_HIBERNATE=WARN       # Niveau log BDD
LOG_FILE_PATH=logs/app.log     # Chemin fichier log
LOG_MAX_FILE_SIZE=10MB         # Taille max fichier log
LOG_MAX_HISTORY=30             # Rétention logs (jours)
```

## 🗃️ Pool de Connexions

### Configuration Base de Données

```bash
DB_POOL_MAX_SIZE=20            # Connexions max dans le pool
DB_POOL_MIN_IDLE=5             # Connexions idle minimum
DB_POOL_IDLE_TIMEOUT=300000    # Timeout idle (ms)
DB_POOL_CONNECTION_TIMEOUT=20000 # Timeout connexion (ms)
DB_POOL_MAX_LIFETIME=1200000   # Durée vie max connexion (ms)
```

## 🚀 Démarrage Rapide

### 1. Génération Automatique

```powershell
# Générer tous les secrets automatiquement
.\generate-secrets.ps1
```

### 2. Configuration Manuelle

```bash
# Copier le template
cp .env.example .env

# Éditer avec vos valeurs
notepad .env  # Windows
nano .env     # Linux
```

### 3. Validation

```bash
# Vérifier que toutes les variables sont définies
Get-Content .env | Where-Object { $_ -match "^[A-Z_]+=\s*$" }
```

## ⚠️ Sécurité Production

### Checklist Variables Critiques

- [ ] `JWT_SECRET` : 64+ caractères aléatoires
- [ ] `DB_PASSWORD` : Complexe avec symboles
- [ ] `DEFAULT_ADMIN_PASSWORD` : Changé du défaut
- [ ] `ENCRYPTION_SECRET_KEY` : Unique par environnement
- [ ] Toutes les `*_API_KEY` : Générées aléatoirement
- [ ] `SERVER_SSL_KEYSTORE_PASSWORD` : Si SSL activé
- [ ] `ACTUATOR_PASSWORD` : Fort pour monitoring

### Bonnes Pratiques

1. **Secrets uniques** par environnement (dev/staging/prod)
2. **Rotation régulière** des secrets (3-6 mois)
3. **Stockage sécurisé** (Azure Key Vault, AWS Secrets Manager)
4. **Accès restreint** aux fichiers .env
5. **Audit régulier** des variables utilisées
6. **Backup chiffré** des configurations

### Variables par Environnement

```bash
# Développement
JWT_SECRET=dev_secret_not_for_production
CORS_ALLOWED_ORIGINS=http://localhost:3000

# Production
JWT_SECRET=${VAULT_JWT_SECRET}
CORS_ALLOWED_ORIGINS=https://app.yourdomain.com
```

## 🔍 Validation & Tests

### Script de Validation

```powershell
# Vérifier les variables critiques
$criticalVars = @('JWT_SECRET', 'DB_PASSWORD', 'DEFAULT_ADMIN_PASSWORD')
foreach ($var in $criticalVars) {
    if (-not $env:$var) {
        Write-Warning "Variable critique manquante: $var"
    }
}
```

### Test des Connexions

```bash
# Test connexion base de données
psql -h $DB_HOST -U $DB_USERNAME -d $DB_NAME -c "SELECT 1;"

# Test endpoints avec variables
curl http://localhost:${SERVER_PORT}/actuator/health
```

---

🔐 **Sécurité Maximale** : Ne partagez jamais les vraies valeurs de production !
