package com.synex.service;

import java.util.List;

import com.synex.domain.Role;

public interface RoleService {

    public Role save(Role role);
    public Role findByRoleId(int roleId);
    public List<Role> findAll();
    public void deleteRoleById(int roleId);
    
    public Role findByRoleName(String roleName);
    public boolean existById(int roleId);
    
}
