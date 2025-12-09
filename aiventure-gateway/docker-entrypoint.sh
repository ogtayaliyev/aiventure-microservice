#!/bin/bash
# =================================================================
# SCRIPT DE DÉMARRAGE DOCKER - AIVENTURE GATEWAY
# =================================================================
# Attend que PostgreSQL soit prêt avant de démarrer l'application

echo "🚀 Démarrage d'AiVenture Gateway..."
echo "📊 Configuration:"
echo "   - Database: ${DB_HOST}:${DB_PORT}/${DB_NAME}"
echo "   - User: ${DB_USERNAME}"
echo "   - Server Port: ${SERVER_PORT:-8080}"

# Attendre que PostgreSQL soit prêt
echo "⏳ Attente de PostgreSQL..."
timeout=60
while ! nc -z "${DB_HOST}" "${DB_PORT}"; do
    timeout=$((timeout - 1))
    if [ $timeout -le 0 ]; then
        echo "❌ Timeout: PostgreSQL n'est pas accessible après 60 secondes"
        exit 1
    fi
    echo "   Tentative de connexion à ${DB_HOST}:${DB_PORT}... (${timeout}s restantes)"
    sleep 1
done

echo "✅ PostgreSQL est prêt!"
echo "🏃 Démarrage de l'application Spring Boot..."

# Démarrage de l'application avec les paramètres JVM optimisés
exec java \
    -Xms256m \
    -Xmx1024m \
    -XX:+UseG1GC \
    -XX:G1HeapRegionSize=16m \
    -XX:+UseStringDeduplication \
    -Djava.security.egd=file:/dev/./urandom \
    -Dspring.profiles.active=${SPRING_PROFILES_ACTIVE:-default} \
    -jar /app/app.jar "$@"