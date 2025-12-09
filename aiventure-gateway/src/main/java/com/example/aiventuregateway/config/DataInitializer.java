package com.example.aiventuregateway.config;

import java.time.LocalDateTime;
import java.util.Set;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import com.example.aiventuregateway.entity.Role;
import com.example.aiventuregateway.entity.User;
import com.example.aiventuregateway.repository.UserRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Component
@RequiredArgsConstructor
@Slf4j
public class DataInitializer implements CommandLineRunner {
    
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    
    @Value("${app.default.admin.username}")
    private String adminUsername;
    
    @Value("${app.default.admin.password}")  
    private String adminPassword;
    
    @Value("${app.default.admin.email}")
    private String adminEmail;
    
    @Override
    public void run(String... args) throws Exception {
        
        // Créer un utilisateur admin depuis les variables d'environnement
        if (!userRepository.existsByUsername(adminUsername)) {
            User admin = new User();
            admin.setUsername(adminUsername);
            admin.setEmail(adminEmail);
            admin.setPassword(passwordEncoder.encode(adminPassword));
            admin.setFirstName("Admin");
            admin.setLastName("System");
            admin.setIsActive(true);
            admin.setRoles(Set.of(Role.ADMIN, Role.USER));
            admin.setCreatedAt(LocalDateTime.now());
            admin.setUpdatedAt(LocalDateTime.now());
            
            userRepository.save(admin);
            log.info("✅ Admin user '{}' created successfully from environment variables", adminUsername);
        } else {
            log.info("✅ Admin user '{}' already exists", adminUsername);
        }
        
        log.info("🛡️ Security configuration loaded from .env file");
        log.info("🔐 JWT expiration: {} ms", "${app.jwt.expiration}");
        log.info("⚡ Database pool max size: {} connections", "${spring.datasource.hikari.maximum-pool-size}");
    }
}