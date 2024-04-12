package com.synex.controller;

import java.security.Principal;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.synex.domain.Role;
import com.synex.domain.User;
import com.synex.repository.UserRepository;
import com.synex.service.RoleService;
import com.synex.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller  // As long as session (logged-in, cookie not expired) is there, this controller bean is in scope inside IOC container.
@SessionAttributes("user")  // IOC container has all the beans (objects) and lets you autowire (inject) them. Default scope is singleton scope.
public class LoginController {
    
    @Autowired UserService userService;
    @Autowired RoleService roleService;
    
    @GetMapping("login")
    public String login(@RequestParam(required = false) String logout, @RequestParam(required = false) String error,
            HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Model model) {
        
        String messageAfterLogInOut = "";  // message after login logout
        
        if (error != null) {  // error is empty string, not null, if parameter has passed (login?error)
            messageAfterLogInOut = "Invalid Credentials";
        }
        if (logout != null) {  // logout is empty string, not null, if parameter has passed (login?logout)
            // Following lines can also be done by SecurityConfig .logout() - invalidate session & clear auth: .invalidateHttpSession(true).clearAuthentication(true)
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth != null) {
                new SecurityContextLogoutHandler().logout(httpServletRequest, httpServletResponse, auth);
            }
            messageAfterLogInOut = "Logged out";
        }
        model.addAttribute("messageAfterLogInOut", messageAfterLogInOut);
        
        // return login.jsp if login failed. If success, go to home using SecurityConfig: .defaultSuccessUrl("/home", true)
        return "login";
    }
    
    @GetMapping("accessDeniedPage")
    public String accessDeniedPage(Principal principal, Model model) {  // User is logged in but its role do not have access.
        String message = principal.getName() + ", unauthorized access";
        model.addAttribute("message", message);
        return "accessDeniedPage";
    }
    
    @GetMapping("register")
    public String register(User user, Model model) {  // not including parameters caused "Neither BindingResult nor plain target object for bean name 'user' available as request attribute" error.
        return "register";
    }
    
    @PostMapping("saveUser")
    public String saveUser(@ModelAttribute User user, BindingResult br, Model model) {  // BindingResult must come before Model, otherwise Model will send to error page before BindingResult do its job.
        if (!br.hasErrors()) {
            Role userRole = roleService.findByRoleId(2);  // USER is role id 2.
            Set<Role> roleSet = new HashSet<>();
            roleSet.add(userRole);
            
            user.setRoles(roleSet);
            userService.save(user);
            model.addAttribute("messageAfterLogInOut", "Thank you for sign up. Please sign in.");
            return "login";
        }
        // else
        model.addAttribute("messageAfterLogInOut", "Error occured during sign up.");
        return "register";  // do not redirect (redirect:register), keep the info user entered and show error messages
    }
    
    @GetMapping("/user/{username}")
    @ResponseBody
    public String getUserByUsername(@PathVariable String username) {
        return userService.findByUserName(username).getEmail();
    }
    
//  @Bean
//  public BCryptPasswordEncoder bCryptpeasswordEncoder() {  // It's in SecurityConfig.
//      return new BCryptPasswordEncoder();
//  }

}
