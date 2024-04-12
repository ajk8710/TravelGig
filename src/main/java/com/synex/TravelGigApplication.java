package com.synex;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class TravelGigApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(TravelGigApplication.class, args);
	}
	
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(TravelGigApplication.class);
    }

}

/*
 * To deploy to external Tomcat:
 * 0. Make sure servlet and glassfish dependencies are included.
 * 
 * 1. SpringBootApp class with main() methods should be modified to extend SpringBootServletInitializer.
 * configure(SpringApplicationBuilder builder) method of SpringBootServletInitializer should be overridden.
 * 
 * 2. Remove the Tomcat dependency from spring-boot-starter-web as follows:
       <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <exclusions>
                <exclusion>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-starter-tomcat</artifactId>
                </exclusion>
            </exclusions>
        </dependency>
 * 
 * 3. Modify the packaging from jar to war file either from pom.xml's GUI or from the tag: <packaging>war</packaging>
 * 
 * 4. Use finalName tag in the build section so that Tomcat can the use tag's value as context:
 * <finalName>FilenameForWarFile</finalName>
 * 
 * 5. Modify the tomcat-users.xml file (in tomcat's conf directory ) to include the username and password as follows:
 * (Apache Software Foundation\Tomcat 10.1\conf\tomcat-users.xml)
 * <user username="yourchoice" password="yourchoice" roles="manager-gui"/>
 * If cannot access tomcat folder, change folder property – security – Add full control to users
 * (Select a principal – Advanced – Find Now).
 * 
 * Do Maven update –> Run as Maven clean –> Run as Maven install.
 * Run tomcat and access localhost:8080. Access Manager Webapp using username and password. Deploy war file.
 * 
 * To change max file size and connection timeout:
 * Apache Software Foundation\Tomcat 10.1\webapps\manager\WEB-INF\web.xml: Increase max file size.
 * Apache Software Foundation\Tomcat 10.1\conf.xml: Increase connection timeout.
 */
