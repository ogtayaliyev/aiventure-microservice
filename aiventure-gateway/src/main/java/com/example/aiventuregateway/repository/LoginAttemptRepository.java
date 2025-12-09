package com.example.aiventuregateway.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.aiventuregateway.entity.LoginAttempt;

@Repository
public interface LoginAttemptRepository extends JpaRepository<LoginAttempt, Long> {
    
    @Query("SELECT COUNT(la) FROM LoginAttempt la WHERE la.username = :username AND la.success = false AND la.attemptTime > :since")
    Long countFailedAttemptsByUsernameAndSince(@Param("username") String username, @Param("since") LocalDateTime since);
    
    @Query("SELECT COUNT(la) FROM LoginAttempt la WHERE la.ipAddress = :ipAddress AND la.success = false AND la.attemptTime > :since")
    Long countFailedAttemptsByIpAndSince(@Param("ipAddress") String ipAddress, @Param("since") LocalDateTime since);
    
    List<LoginAttempt> findByUsernameAndAttemptTimeAfterOrderByAttemptTimeDesc(String username, LocalDateTime since);
    
    List<LoginAttempt> findByIpAddressAndAttemptTimeAfterOrderByAttemptTimeDesc(String ipAddress, LocalDateTime since);
    
    void deleteByAttemptTimeBefore(LocalDateTime before);
}