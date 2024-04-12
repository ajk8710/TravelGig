package com.synex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.synex.client.ReviewClient;

@RestController
public class ReviewController {
    
    @Autowired ReviewClient reviewClient;
    
    @PostMapping("saveReview")
    public JsonNode saveReview(@RequestBody JsonNode json) {
        return reviewClient.saveReview(json);
    }
    
    @GetMapping("findAllReviewsByHotelId/{hotelId}")
    public JsonNode findAllReviewsByHotelId(@PathVariable int hotelId) {
        return reviewClient.findAllReviewsByHotelId(hotelId);
    }
    
}
