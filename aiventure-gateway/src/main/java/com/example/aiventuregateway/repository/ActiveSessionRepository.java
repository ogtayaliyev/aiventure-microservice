package com.example.aiventuregateway.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.aiventuregateway.entity.ActiveSession;
import com.example.aiventuregateway.entity.User;

@Repository
public interface ActiveSessionRepository extends JpaRepository<ActiveSession, Long> {
    
    Optional<ActiveSession> findBySessionToken(String sessionToken);
    
    List<ActiveSession> findByUser(User user);
    
    List<ActiveSession> findByUserAndExpiresAtAfter(User user, LocalDateTime now);
    
    @Modifying
    @Query("DELETE FROM ActiveSession as WHERE as.user = :user")
    void deleteAllByUser(@Param("user") User user);
    
    @Modifying
    @Query("DELETE FROM ActiveSession as WHERE as.expiresAt < :now")
    void deleteExpiredSessions(@Param("now") LocalDateTime now);
    
    @Query("SELECT COUNT(as) FROM ActiveSession as WHERE as.user = :user AND as.expiresAt > :now")
    Long countActiveSessionsByUser(@Param("user") User user, @Param("now") LocalDateTime now);
}