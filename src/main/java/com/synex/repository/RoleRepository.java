package com.synex.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.synex.domain.Role;

// @Repository comes from JpaRepository
public interface RoleRepository extends JpaRepository<Role, Integer> {
    
    Role findByRoleName(String roleName);  // using nomenclature
    
}
