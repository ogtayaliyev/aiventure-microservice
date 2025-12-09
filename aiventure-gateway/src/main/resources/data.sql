-- Insertion d'un utilisateur admin par défaut
INSERT INTO users (id, username, email, password, first_name, last_name, is_active, created_at, updated_at) 
VALUES (1, 'admin', 'admin@aiventure.com', '$2a$10$slYQmyNdGzTn7EjHXLsLiOIsEF9E0oLU9LZ3z8o9yXXu5dV5zOKwK', 'Admin', 'User', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Ajout du rôle ADMIN pour l'utilisateur admin
INSERT INTO user_roles (user_id, role) VALUES (1, 'ADMIN');

-- Insertion d'un utilisateur normal pour les tests
INSERT INTO users (id, username, email, password, first_name, last_name, is_active, created_at, updated_at) 
VALUES (2, 'testuser', 'test@aiventure.com', '$2a$10$slYQmyNdGzTn7EjHXLsLiOIsEF9E0oLU9LZ3z8o9yXXu5dV5zOKwK', 'Test', 'User', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Ajout du rôle USER pour l'utilisateur test
INSERT INTO user_roles (user_id, role) VALUES (2, 'USER');