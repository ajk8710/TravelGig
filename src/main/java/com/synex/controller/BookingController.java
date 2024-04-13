package com.synex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.synex.client.BookingClient;

@RestController
public class BookingController {
    
    @Autowired BookingClient bookingClient;
    
    @PostMapping("saveBooking")
    public JsonNode saveBooking(@RequestBody JsonNode json) {
        return bookingClient.saveBooking(json);
    }
    
    @GetMapping("findAllByUserName/{userName}")
    public JsonNode findAllByUserName(@PathVariable String userName) {
        return bookingClient.findAllByUserName(userName);
    }
    
    @DeleteMapping("deleteBookingById/{id}")
    public void deleteBookingById(@PathVariable int id) {
        bookingClient.deleteBookingById(id);
    }
    
    @DeleteMapping("cancelBookingById/{id}")
    public void cancelBookingById(@PathVariable int id) {
        bookingClient.cancelBookingById(id);
    }
    
}
