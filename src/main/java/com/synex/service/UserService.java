package com.synex.service;

import java.util.List;

import com.synex.domain.User;

public interface UserService {

    public User save(User user);
    public User findByUserId(long userId);
    public List<User> findAll();
    public void deleteUserById(long userId);
    
    public User findByUserName(String userName);
    public boolean existById(long userId);
    
}
