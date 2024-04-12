package com.synex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.synex.client.GuestClient;

@RestController
public class GuestController {  // Not using it right now. Instead save guests along with booking through saveBookng.
    
    @Autowired GuestClient guestClient;
    
    @PostMapping("saveGuest")
    public JsonNode saveGuest(@RequestBody JsonNode json) {
        return guestClient.saveGuest(json);
    }
    
}
