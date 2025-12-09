package com.example.aiventuregateway.controller;

import java.util.Collections;
import java.util.Enumeration;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.example.aiventuregateway.service.GatewayService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/api/gateway")
@RequiredArgsConstructor
@Slf4j
public class GatewayController {
    
    private final GatewayService gatewayService;
    
    // Routes pour le service d'authentification
    @RequestMapping(value = "/auth/**", method = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE})
    public ResponseEntity<String> forwardToAuthService(HttpServletRequest request, @RequestBody(required = false) Object body) {
        String path = extractPath(request.getRequestURI(), "/api/gateway/auth");
        HttpHeaders headers = extractHeaders(request);
        HttpMethod method = HttpMethod.valueOf(request.getMethod());
        
        log.info("Forwarding to Auth Service: {} {}", method, path);
        
        return gatewayService.forwardToAuthService(path, method, body, headers);
    }
    
    // Routes pour le service IA
    @RequestMapping(value = "/ia/**", method = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE})
    @PreAuthorize("hasRole('USER') or hasRole('ADMIN')")
    public ResponseEntity<String> forwardToIaService(HttpServletRequest request, @RequestBody(required = false) Object body) {
        String path = extractPath(request.getRequestURI(), "/api/gateway/ia");
        HttpHeaders headers = extractHeaders(request);
        HttpMethod method = HttpMethod.valueOf(request.getMethod());
        
        log.info("Forwarding to IA Service: {} {}", method, path);
        
        return gatewayService.forwardToIaService(path, method, body, headers);
    }
    
    // Routes pour le service social
    @RequestMapping(value = "/social/**", method = {RequestMethod.GET, RequestMethod.POST, RequestMethod.PUT, RequestMethod.DELETE})
    @PreAuthorize("hasRole('USER') or hasRole('ADMIN')")
    public ResponseEntity<String> forwardToSocialService(HttpServletRequest request, @RequestBody(required = false) Object body) {
        String path = extractPath(request.getRequestURI(), "/api/gateway/social");
        HttpHeaders headers = extractHeaders(request);
        HttpMethod method = HttpMethod.valueOf(request.getMethod());
        
        log.info("Forwarding to Social Service: {} {}", method, path);
        
        return gatewayService.forwardToSocialService(path, method, body, headers);
    }
    
    // Endpoint pour vérifier la santé des services
    @GetMapping("/health")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Object> checkServicesHealth() {
        return ResponseEntity.ok()
                .body(java.util.Map.of(
                        "auth-service", gatewayService.isServiceHealthy("http://localhost:8081"),
                        "ia-service", gatewayService.isServiceHealthy("http://localhost:8082"),
                        "social-service", gatewayService.isServiceHealthy("http://localhost:8083")
                ));
    }
    
    private String extractPath(String requestURI, String prefix) {
        return requestURI.substring(prefix.length());
    }
    
    private HttpHeaders extractHeaders(HttpServletRequest request) {
        HttpHeaders headers = new HttpHeaders();
        Enumeration<String> headerNames = request.getHeaderNames();
        
        if (headerNames != null) {
            for (String headerName : Collections.list(headerNames)) {
                String headerValue = request.getHeader(headerName);
                if (headerValue != null && headerName != null) {
                    headers.add(headerName, headerValue);
                }
            }
        }
        
        return headers;
    }
}