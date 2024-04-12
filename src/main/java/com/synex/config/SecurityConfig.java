package com.synex.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.expression.WebExpressionAuthorizationManager;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    
	// @Autowired
	// UserDetailsService userDetailsService;  //  For internal temporary user/password. Leaving it causes cyclic dependency with bcrypt.
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
//	@Bean
//	public UserDetailsService userDetailsService() {  //  For internal temporary user/password
//		UserDetails user =
//			 User.withDefaultPasswordEncoder()
//				.username("user")
//				.password("password")
//				.roles("USER")
//				.build();
//
//		return new InMemoryUserDetailsManager(user);
//	}
	
	@Bean 
	public SecurityFilterChain apiFilterChain2(HttpSecurity http) throws Exception {
		http
			.apply(MyCustomDsl.customDsl())  // MyCustomDsl just setting http.csrf().disable(). This could be done directly in SecurityConfig.
			.flag(true).and()  // This flag is not doing anything right now.
			.authorizeRequests()  // set security for following
				.requestMatchers("/", "/home", "/register").permitAll().and()  // home and register can be reached without security
			      .exceptionHandling().accessDeniedPage("/accessDeniedPage").and()
			.authorizeRequests()  // set security for following, these urls can only be reached with security
				.requestMatchers("/mybookings", "/userProfile", "/test").hasAnyAuthority("ADMIN", "USER").and()
		.formLogin()  // formLogin sets up login page
			.loginPage("/login")
			.defaultSuccessUrl("/home").permitAll().and()  // get here upon successful login.
		.logout()
		.logoutSuccessUrl("/")  // get here upon successful logout.
        .invalidateHttpSession(true)
        .deleteCookies("JSESSIONID")
        .permitAll();
		
		return http.build();
	}
	
}
