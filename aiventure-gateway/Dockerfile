# =================================================================
# DOCKERFILE - AIVENTURE GATEWAY
# =================================================================
# Image multi-stage pour optimiser la taille finale

# Stage 1: Build
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /app

# Copie des fichiers de configuration Maven
COPY pom.xml .
COPY src ./src

# Construction de l'application (skip tests pour la rapidité)
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Installation des outils nécessaires (Alpine Linux)
RUN apk add --no-cache \
    curl \
    netcat-openbsd \
    bash

# Création d'un utilisateur non-root pour la sécurité
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copie du JAR depuis le stage de build
COPY --from=build /app/target/*.jar app.jar

# Script de démarrage avec health check PostgreSQL
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Création du répertoire de logs
RUN mkdir -p /app/logs && chown -R appuser:appgroup /app

# Exposition du port
EXPOSE 8080

# Changement vers l'utilisateur non-root
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

# Point d'entrée
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["java", "-jar", "/app/app.jar"]