package com.synex.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.synex.domain.User;
import com.synex.service.UserService;

@Controller  // RestController returns json data. Controller returns view resolver (returns file name).
public class HomeController {
    
    @Autowired UserService userService;
    
    @GetMapping("home")
    public String home(Principal principal, Model model) {
        modelData(principal, model);
        return "home";
    }
    
    @GetMapping("mybookings")
    public String myBookings(Principal principal, Model model) {
        modelData(principal, model);
        return "myBookings";
    }
    
    private void modelData(Principal principal, Model model) {
        String username = null;
        if (principal != null) {
            username = principal.getName();
            
            User user = userService.findByUserName(username);
            String userEmail = user.getEmail();
            model.addAttribute("userEmail", userEmail);
        }
        
        // get this by either request.getAttribute("username") as <% javacodes %> or ${username} as javascript codes or "${username}" as jQuery codes in home.jsp.
        model.addAttribute("username", username);
        
    }
    
}
