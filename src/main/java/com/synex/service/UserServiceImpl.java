package com.synex.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.synex.domain.User;
import com.synex.repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {
    
    @Autowired UserRepository userRepository;
    // @Autowired BCryptPasswordEncoder bCrypt;
    @Autowired PasswordEncoder bCrypt;
    
    @Override
    public User save(User user) {
        // use bCrypt to encrypt password while saving
        String encryptedPassword = bCrypt.encode(user.getUserPassword());
        user.setUserPassword(encryptedPassword);
        return userRepository.save(user);
    }
    
    @Override
    public User findByUserId(long userId) {
        Optional<User> optUser = userRepository.findById(userId);  // can do .orElse(null)
        if (optUser.isPresent()) {
            return optUser.get();
        }
        return null;
    }
    
    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }
    
    @Override
    public void deleteUserById(long userId) {
        userRepository.deleteById(userId);
    }
    
    @Override
    public User findByUserName(String userName) {
        return userRepository.findByUserName(userName);
    }
    
    @Override
    public boolean existById(long userId) {
        return userRepository.existsById(userId);
    }
    
}
