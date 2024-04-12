package com.synex.config;

import java.util.Properties;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
public class AppConfig {
    
    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
        dataSource.setDriverClassName("oracle.jdbc.OracleDriver");
        dataSource.setUsername("root");
        dataSource.setPassword("admin");
        return dataSource;
    }
    
    public Properties jpaProperties() {
        Properties jpaProperties = new Properties();
        jpaProperties.setProperty("hibernate.dialect", "org.hibernate.dialect.Oracle12cDialect");  // dialect is different for Oracle, mySQL, etc
        jpaProperties.setProperty("hibernate.show_sql", "true");  // show_sql means I can see sql queries on console
        jpaProperties.setProperty("hibernate.hbm2ddl.auto", "update"); // hbm = hibernate mapping, ddl = data definition language
        return jpaProperties;    // create or update. create deletes tables and data, & recreate every time compiles.
    }
    
    @Bean
    @Primary
    public LocalContainerEntityManagerFactoryBean entityManagerFactory() {  // ORM work with help of entity manager factory
        LocalContainerEntityManagerFactoryBean entityManagerFactory = new LocalContainerEntityManagerFactoryBean();
        entityManagerFactory.setDataSource(dataSource());
        entityManagerFactory.setPackagesToScan("com.synex.domain");  // All entities (schema to be stored) is in this package
        entityManagerFactory.setJpaVendorAdapter(new HibernateJpaVendorAdapter());
        entityManagerFactory.setJpaProperties(jpaProperties());
        return entityManagerFactory;
    }
    
    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();  // view resolver returns views (file names) with controller
        viewResolver.setPrefix("/WEB-INF/views/");  // directory of jsp file (views)
        viewResolver.setSuffix(".jsp");  // extension of jsp file
        viewResolver.setViewClass(JstlView.class);
        return viewResolver;
    }
    
}
