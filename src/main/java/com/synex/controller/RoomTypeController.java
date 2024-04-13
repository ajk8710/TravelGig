package com.synex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.synex.client.RoomTypeClient;

@RestController  // RestController returns json data. Controller returns view resolver (returns file name).
public class RoomTypeController {
    
    @Autowired RoomTypeClient roomTypeClient;
    
    @GetMapping("findRoomTypeById/{id}")
    public JsonNode findRoomTypeById(@PathVariable int id) {
        return roomTypeClient.findRoomTypeById(id);
    }
    
}
