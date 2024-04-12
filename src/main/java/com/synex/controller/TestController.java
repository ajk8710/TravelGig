package com.synex.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController  // RestController returns json data. Controller returns view resolver (returns file name).
public class TestController {
    
    @GetMapping(value = "test")  // test url to test log in security
    public String test() {
        return "test";
    }
    
}
