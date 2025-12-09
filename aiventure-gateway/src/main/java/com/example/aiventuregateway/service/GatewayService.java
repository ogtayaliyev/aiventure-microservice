package com.example.aiventuregateway.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class GatewayService {
    
    private final RestTemplate restTemplate = new RestTemplate();
    
    @Value("${microservices.auth.url:http://localhost:8081}")
    private String authServiceUrl;
    
    @Value("${microservices.ia.url:http://localhost:8082}")
    private String iaServiceUrl;
    
    @Value("${microservices.social.url:http://localhost:8083}")
    private String socialServiceUrl;
    
    public ResponseEntity<String> forwardToAuthService(String path, HttpMethod method, Object body, HttpHeaders headers) {
        return forwardRequest(authServiceUrl + path, method, body, headers);
    }
    
    public ResponseEntity<String> forwardToIaService(String path, HttpMethod method, Object body, HttpHeaders headers) {
        return forwardRequest(iaServiceUrl + path, method, body, headers);
    }
    
    public ResponseEntity<String> forwardToSocialService(String path, HttpMethod method, Object body, HttpHeaders headers) {
        return forwardRequest(socialServiceUrl + path, method, body, headers);
    }
    
    private ResponseEntity<String> forwardRequest(String url, HttpMethod method, Object body, HttpHeaders headers) {
        try {
            HttpEntity<Object> entity = new HttpEntity<>(body, headers);
            
            log.info("Forwarding {} request to: {}", method, url);
            
            return restTemplate.exchange(url, method, entity, String.class);
            
        } catch (Exception e) {
            log.error("Error forwarding request to {}: {}", url, e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("{\"error\": \"Service temporairement indisponible\"}");
        }
    }
    
    public boolean isServiceHealthy(String serviceUrl) {
        try {
            ResponseEntity<String> response = restTemplate.getForEntity(serviceUrl + "/actuator/health", String.class);
            return response.getStatusCode() == HttpStatus.OK;
        } catch (Exception e) {
            log.warn("Health check failed for service: {}", serviceUrl);
            return false;
        }
    }
}