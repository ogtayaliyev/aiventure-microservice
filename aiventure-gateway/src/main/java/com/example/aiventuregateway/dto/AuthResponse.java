package com.example.aiventuregateway.dto;

import java.util.Set;

import com.example.aiventuregateway.entity.Role;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AuthResponse {
    
    private String token;
    private String type;
    private String refreshToken;
    private String sessionToken;
    private Long id;
    private String username;
    private String email;
    private Set<Role> roles;
}