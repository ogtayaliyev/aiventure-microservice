package com.example.aiventuregateway.service;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.aiventuregateway.entity.ActiveSession;
import com.example.aiventuregateway.entity.LoginAttempt;
import com.example.aiventuregateway.entity.User;
import com.example.aiventuregateway.repository.ActiveSessionRepository;
import com.example.aiventuregateway.repository.LoginAttemptRepository;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SecurityService {
    
    private final LoginAttemptRepository loginAttemptRepository;
    private final ActiveSessionRepository activeSessionRepository;
    
    @Value("${app.security.max-failed-attempts:5}")
    private int maxFailedAttempts;
    
    @Value("${app.security.lockout-duration:15}")
    private int lockoutDurationMinutes;
    
    @Value("${app.security.max-sessions-per-user:3}")
    private int maxSessionsPerUser;
    
    @Value("${app.security.session-timeout:24}")
    private int sessionTimeoutHours;
    
    public void recordLoginAttempt(String username, String ipAddress, String userAgent, boolean success) {
        LoginAttempt attempt = new LoginAttempt();
        attempt.setUsername(username);
        attempt.setIpAddress(ipAddress);
        attempt.setUserAgent(userAgent);
        attempt.setSuccess(success);
        
        loginAttemptRepository.save(attempt);
        
        if (success) {
            log.info("Successful login for user: {} from IP: {}", username, ipAddress);
        } else {
            log.warn("Failed login attempt for user: {} from IP: {}", username, ipAddress);
        }
    }
    
    public boolean isAccountLocked(String username) {
        LocalDateTime lockoutThreshold = LocalDateTime.now().minusMinutes(lockoutDurationMinutes);
        Long failedAttempts = loginAttemptRepository.countFailedAttemptsByUsernameAndSince(username, lockoutThreshold);
        
        boolean locked = failedAttempts >= maxFailedAttempts;
        if (locked) {
            log.warn("Account locked for user: {} due to {} failed attempts", username, failedAttempts);
        }
        
        return locked;
    }
    
    public boolean isIpBlocked(String ipAddress) {
        LocalDateTime blockThreshold = LocalDateTime.now().minusMinutes(lockoutDurationMinutes);
        Long failedAttempts = loginAttemptRepository.countFailedAttemptsByIpAndSince(ipAddress, blockThreshold);
        
        boolean blocked = failedAttempts >= maxFailedAttempts * 2; // Plus strict pour les IP
        if (blocked) {
            log.warn("IP blocked: {} due to {} failed attempts", ipAddress, failedAttempts);
        }
        
        return blocked;
    }
    
    @Transactional
    public String createSession(User user, String ipAddress, String userAgent) {
        // Limiter le nombre de sessions par utilisateur
        Long activeSessionCount = activeSessionRepository.countActiveSessionsByUser(user, LocalDateTime.now());
        
        if (activeSessionCount >= maxSessionsPerUser) {
            // Supprimer les sessions les plus anciennes
            var sessions = activeSessionRepository.findByUserAndExpiresAtAfter(user, LocalDateTime.now());
            sessions.stream()
                    .sorted((s1, s2) -> s1.getCreatedAt().compareTo(s2.getCreatedAt()))
                    .limit(activeSessionCount - maxSessionsPerUser + 1)
                    .forEach(activeSessionRepository::delete);
        }
        
        ActiveSession session = new ActiveSession();
        session.setUser(user);
        session.setSessionToken(UUID.randomUUID().toString());
        session.setIpAddress(ipAddress);
        session.setUserAgent(userAgent);
        session.setExpiresAt(LocalDateTime.now().plusHours(sessionTimeoutHours));
        
        activeSessionRepository.save(session);
        
        log.info("Created new session for user: {} from IP: {}", user.getUsername(), ipAddress);
        
        return session.getSessionToken();
    }
    
    public Optional<ActiveSession> validateSession(String sessionToken) {
        Optional<ActiveSession> sessionOpt = activeSessionRepository.findBySessionToken(sessionToken);
        
        if (sessionOpt.isPresent()) {
            ActiveSession session = sessionOpt.get();
            if (session.isExpired()) {
                activeSessionRepository.delete(session);
                log.info("Expired session removed for user: {}", session.getUser().getUsername());
                return Optional.empty();
            }
            
            // Mettre à jour le dernier accès
            session.setLastAccessed(LocalDateTime.now());
            activeSessionRepository.save(session);
            
            return sessionOpt;
        }
        
        return Optional.empty();
    }
    
    @Transactional
    public void invalidateAllUserSessions(User user) {
        activeSessionRepository.deleteAllByUser(user);
        log.info("All sessions invalidated for user: {}", user.getUsername());
    }
    
    @Transactional
    public void invalidateSession(String sessionToken) {
        activeSessionRepository.findBySessionToken(sessionToken)
                .ifPresent(session -> {
                    activeSessionRepository.delete(session);
                    log.info("Session invalidated for user: {}", session.getUser().getUsername());
                });
    }
    
    // Nettoyage périodique des anciennes tentatives et sessions expirées
    @Scheduled(fixedRate = 3600000) // Toutes les heures
    @Transactional
    public void cleanupExpiredData() {
        LocalDateTime cutoff = LocalDateTime.now().minusDays(7);
        
        // Supprimer les anciennes tentatives de connexion
        loginAttemptRepository.deleteByAttemptTimeBefore(cutoff);
        
        // Supprimer les sessions expirées
        activeSessionRepository.deleteExpiredSessions(LocalDateTime.now());
        
        log.info("Cleanup completed: removed expired sessions and old login attempts");
    }
}