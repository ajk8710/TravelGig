package com.synex.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.synex.domain.Role;
import com.synex.repository.RoleRepository;

@Service
public class RoleServiceImpl implements RoleService {
    
    @Autowired RoleRepository roleRepository;
    
    @Override
    public Role save(Role role) {
        return roleRepository.save(role);
    }
    
    @Override
    public Role findByRoleId(int roleId) {
        Optional<Role> optRole = roleRepository.findById(roleId);  // can do .orElse(null)
        if (optRole.isPresent()) {
            return optRole.get();
        }
        return null;
    }
    
    @Override
    public List<Role> findAll() {
        return roleRepository.findAll();
    }
    
    @Override
    public void deleteRoleById(int roleId) {
        roleRepository.deleteById(roleId);
    }
    
    @Override
    public Role findByRoleName(String roleName) {
        return roleRepository.findByRoleName(roleName);
    }
    
    @Override
    public boolean existById(int roleId) {
        return roleRepository.existsById(roleId);
    }
    
}
