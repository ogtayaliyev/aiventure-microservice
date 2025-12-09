package com.example.aiventuregateway.controller;

import java.util.Set;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.aiventuregateway.dto.AuthRequest;
import com.example.aiventuregateway.dto.AuthResponse;
import com.example.aiventuregateway.dto.RefreshTokenRequest;
import com.example.aiventuregateway.dto.SignupRequest;
import com.example.aiventuregateway.entity.RefreshToken;
import com.example.aiventuregateway.entity.Role;
import com.example.aiventuregateway.entity.User;
import com.example.aiventuregateway.repository.UserRepository;
import com.example.aiventuregateway.security.jwt.JwtUtils;
import com.example.aiventuregateway.service.RefreshTokenService;
import com.example.aiventuregateway.service.SecurityService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@Slf4j
@Tag(name = "Authentication", description = "API d'authentification - Connexion, inscription et gestion des tokens")
public class AuthController {
    
    private final AuthenticationManager authenticationManager;
    private final UserRepository userRepository;
    private final JwtUtils jwtUtils;
    private final RefreshTokenService refreshTokenService;
    private final SecurityService securityService;
    private final PasswordEncoder passwordEncoder;
    
    @PostMapping("/signin")
    @Operation(summary = "Connexion utilisateur", description = "Authentifie un utilisateur et retourne un token JWT")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Connexion réussie"),
        @ApiResponse(responseCode = "401", description = "Identifiants incorrects"),
        @ApiResponse(responseCode = "429", description = "Trop de tentatives de connexion")
    })
    public ResponseEntity<?> authenticateUser(@RequestBody AuthRequest loginRequest, HttpServletRequest request) {
        
        String ipAddress = getClientIpAddress(request);
        String userAgent = request.getHeader("User-Agent");
        
        // Vérifier si l'IP est bloquée
        if (securityService.isIpBlocked(ipAddress)) {
            securityService.recordLoginAttempt(loginRequest.getUsername(), ipAddress, userAgent, false);
            return ResponseEntity.status(HttpStatus.TOO_MANY_REQUESTS)
                    .body("{\"error\": \"IP address temporarily blocked due to too many failed attempts\"}");
        }
        
        // Vérifier si le compte est verrouillé
        if (securityService.isAccountLocked(loginRequest.getUsername())) {
            securityService.recordLoginAttempt(loginRequest.getUsername(), ipAddress, userAgent, false);
            return ResponseEntity.status(HttpStatus.LOCKED)
                    .body("{\"error\": \"Account temporarily locked due to too many failed attempts\"}");
        }
        
        try {
            Authentication authentication = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword())
            );
            
            SecurityContextHolder.getContext().setAuthentication(authentication);
            String jwt = jwtUtils.generateJwtToken(authentication);
            
            User user = userRepository.findByUsername(loginRequest.getUsername())
                    .orElseThrow(() -> new RuntimeException("Error: User not found."));
            
            // Enregistrer la tentative réussie
            securityService.recordLoginAttempt(loginRequest.getUsername(), ipAddress, userAgent, true);
            
            // Créer une session sécurisée
            String sessionToken = securityService.createSession(user, ipAddress, userAgent);
            
            RefreshToken refreshToken = refreshTokenService.createRefreshToken(user.getId());
            
            AuthResponse response = AuthResponse.builder()
                    .token(jwt)
                    .type("Bearer")
                    .refreshToken(refreshToken.getToken())
                    .sessionToken(sessionToken)
                    .id(user.getId())
                    .username(user.getUsername())
                    .email(user.getEmail())
                    .roles(user.getRoles())
                    .build();
            
            return ResponseEntity.ok(response);
            
        } catch (BadCredentialsException e) {
            securityService.recordLoginAttempt(loginRequest.getUsername(), ipAddress, userAgent, false);
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("{\"error\": \"Invalid username or password\"}");
        }
    }
    
    @PostMapping("/signup")
    @Operation(summary = "Inscription utilisateur", description = "Crée un nouveau compte utilisateur")
    @ApiResponses(value = {
        @ApiResponse(responseCode = "200", description = "Inscription réussie"),
        @ApiResponse(responseCode = "400", description = "Données invalides ou email déjà utilisé")
    })
    public ResponseEntity<?> registerUser(@Valid @RequestBody SignupRequest signupRequest) {
        
        // Vérifier si les mots de passe correspondent
        if (!signupRequest.getPassword().equals(signupRequest.getConfirmPassword())) {
            return ResponseEntity.badRequest()
                    .body("{\"error\": \"Les mots de passe ne correspondent pas\"}");
        }
        
        // Vérifier si l'email existe déjà
        if (userRepository.findByEmail(signupRequest.getEmail()).isPresent()) {
            return ResponseEntity.badRequest()
                    .body("{\"error\": \"Email déjà utilisé\"}");
        }
        
        // Vérifier si le username existe déjà (on utilisera l'email comme username)
        if (userRepository.findByUsername(signupRequest.getEmail()).isPresent()) {
            return ResponseEntity.badRequest()
                    .body("{\"error\": \"Compte déjà existant avec cet email\"}");
        }
        
        try {
            // Créer le nouvel utilisateur
            User user = new User();
            user.setUsername(signupRequest.getEmail()); // Utiliser l'email comme username
            user.setEmail(signupRequest.getEmail());
            user.setPassword(passwordEncoder.encode(signupRequest.getPassword()));
            user.setFirstName(signupRequest.getName());
            user.setIsActive(true);
            user.setRoles(Set.of(Role.USER)); // Rôle par défaut
            
            // Sauvegarder l'utilisateur
            User savedUser = userRepository.save(user);
            
            log.info("Nouvel utilisateur créé: {}", savedUser.getEmail());
            
            return ResponseEntity.ok()
                    .body("{\"message\": \"Inscription réussie! Vous pouvez maintenant vous connecter.\", \"userId\": " + savedUser.getId() + "}");
                    
        } catch (Exception e) {
            log.error("Erreur lors de l'inscription: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("{\"error\": \"Erreur lors de l'inscription\"}");
        }
    }
    
    @PostMapping("/refreshtoken")
    public ResponseEntity<AuthResponse> refreshToken(@RequestBody RefreshTokenRequest request) {
        String requestRefreshToken = request.getRefreshToken();
        
        return refreshTokenService.findByToken(requestRefreshToken)
                .map(refreshTokenService::verifyExpiration)
                .map(RefreshToken::getUser)
                .map(user -> {
                    String token = jwtUtils.generateTokenFromUsername(user.getUsername());
                    AuthResponse response = AuthResponse.builder()
                            .token(token)
                            .type("Bearer")
                            .refreshToken(requestRefreshToken)
                            .id(user.getId())
                            .username(user.getUsername())
                            .email(user.getEmail())
                            .roles(user.getRoles())
                            .build();
                    return ResponseEntity.ok(response);
                })
                .orElseThrow(() -> new RuntimeException("Refresh token is not in database!"));
    }
    
    @PostMapping("/signout")
    public ResponseEntity<String> logoutUser(@RequestBody RefreshTokenRequest request, HttpServletRequest httpRequest) {
        refreshTokenService.findByToken(request.getRefreshToken())
                .ifPresent(token -> {
                    refreshTokenService.deleteByUserId(token.getUser().getId());
                    securityService.invalidateAllUserSessions(token.getUser());
                });
        
        return ResponseEntity.ok("{\"message\": \"Log out successful!\"}");
    }
    
    private String getClientIpAddress(HttpServletRequest request) {
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0].trim();
        }
        
        String xRealIP = request.getHeader("X-Real-IP");
        if (xRealIP != null && !xRealIP.isEmpty()) {
            return xRealIP;
        }
        
        return request.getRemoteAddr();
    }
}