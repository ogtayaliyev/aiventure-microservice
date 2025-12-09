# =================================================================

# GUIDE DE DÉMARRAGE DOCKER - AIVENTURE GATEWAY

# =================================================================

## 🚀 Lancement rapide

### 1. Construction et démarrage complet

```bash
docker-compose up --build -d
```

### 2. Vérification du statut

```bash
docker-compose ps
```

### 3. Logs en temps réel

```bash
docker-compose logs -f app
```

## 📊 Services disponibles

| Service          | URL                                    | Description              |
| ---------------- | -------------------------------------- | ------------------------ |
| **Gateway**      | http://localhost:8080                  | API Gateway principal    |
| **Health Check** | http://localhost:8080/actuator/health  | État de santé            |
| **Metrics**      | http://localhost:8080/actuator/metrics | Métriques (auth requise) |
| **Adminer**      | http://localhost:8081                  | Interface PostgreSQL     |
| **PostgreSQL**   | localhost:5432                         | Base de données          |

## 🔐 Identifiants par défaut

### Application

- **Admin**: `admin` / `Admin2024!SecurePassword`
- **Actuator**: `actuator` / `ActuatorMonitoring2024!Secure`

### Base de données

- **Host**: localhost:5432
- **Database**: aiventure_gateway
- **User**: root
- **Password**: root

## ⚡ Commandes utiles

### Démarrage

```bash
# Démarrage complet
docker-compose up -d

# Avec reconstruction des images
docker-compose up --build -d

# Démarrage d'un service spécifique
docker-compose up -d postgres
```

### Monitoring

```bash
# Logs de tous les services
docker-compose logs -f

# Logs de l'application uniquement
docker-compose logs -f app

# Logs PostgreSQL
docker-compose logs -f postgres

# Statut des services
docker-compose ps
```

### Maintenance

```bash
# Arrêt propre
docker-compose down

# Arrêt avec suppression des volumes
docker-compose down -v

# Reconstruction complète
docker-compose down && docker-compose up --build -d

# Nettoyage complet
docker-compose down -v --rmi all
```

### Base de données

```bash
# Connexion directe à PostgreSQL
docker-compose exec postgres psql -U root -d aiventure_gateway

# Sauvegarde
docker-compose exec postgres pg_dump -U root aiventure_gateway > backup.sql

# Restauration
docker-compose exec -T postgres psql -U root aiventure_gateway < backup.sql
```

## 🔧 Configuration

### Variables d'environnement

Les variables sont définies dans `docker-compose.yml`.
Pour les modifier, éditez directement le fichier.

### Volumes persistants

- **postgres_data**: Données PostgreSQL
- **app_logs**: Logs de l'application

### Réseau

Tous les services communiquent via le réseau `aiventure-network`.

## 🐛 Dépannage

### L'application ne démarre pas

```bash
# Vérifier les logs
docker-compose logs app

# Vérifier que PostgreSQL est prêt
docker-compose logs postgres
```

### Port déjà utilisé

```bash
# Changer le port dans docker-compose.yml
ports:
  - "8090:8080"  # Utilise le port 8090 au lieu de 8080
```

### Problème de permissions PostgreSQL

```bash
# Redémarrer PostgreSQL
docker-compose restart postgres

# Vérifier l'initialisation
docker-compose logs postgres | grep "database system is ready"
```

### Reconstruction propre

```bash
# Arrêt et nettoyage complet
docker-compose down -v --rmi all
docker system prune -f

# Reconstruction
docker-compose up --build -d
```

## 📈 Monitoring avancé

### Health checks

```bash
# Status détaillé
curl http://localhost:8080/actuator/health

# Métriques (avec authentification)
curl -u actuator:ActuatorMonitoring2024!Secure http://localhost:8080/actuator/metrics
```

### Tests de connectivité

```bash
# Test de la base de données depuis l'app
docker-compose exec app nc -zv postgres 5432

# Test de l'application depuis l'hôte
curl -I http://localhost:8080/actuator/health
```

## 🚨 Important pour la production

1. **Changez tous les mots de passe par défaut**
2. **Utilisez des secrets externes** (Docker secrets, Kubernetes secrets)
3. **Configurez HTTPS** avec des certificats valides
4. **Limitez l'exposition des ports**
5. **Activez les sauvegardes automatiques**
6. **Surveillez les logs et métriques**

## 🔄 Mise à jour

```bash
# Arrêt de l'application (garde la DB)
docker-compose stop app

# Reconstruction de l'application
docker-compose build app

# Redémarrage
docker-compose up -d app
```
