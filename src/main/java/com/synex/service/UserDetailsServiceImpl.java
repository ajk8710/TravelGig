package com.synex.service;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.synex.domain.Role;
import com.synex.domain.User;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    
    // co-relate my UserService with Sprnig's UserDetailsService
    @Autowired UserService userService;
    
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // when spring loadUserByUsername is called, find my user with username on my db
        User user = userService.findByUserName(username);
        
        if (user == null) {
            throw new UsernameNotFoundException(username);
        }
        
        // add user's roles to authorities
        Set<GrantedAuthority> authorities = new HashSet<>();
        
        Set<Role> roles = user.getRoles();
        for (Role role : roles) {
            authorities.add(new SimpleGrantedAuthority(role.getRoleName()));
            System.out.println("role.getRoleName()" + role.getRoleName());
        }
        
        // return spring user
        return new org.springframework.security.core.userdetails.User(user.getUserName(), user.getUserPassword(), authorities);
    }
    
}
