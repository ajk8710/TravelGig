package com.synex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.JsonNode;
import com.synex.client.HotelClient;

import jakarta.servlet.http.HttpServletRequest;

@RestController  // RestController returns json data. Controller returns view resolver (returns file name).
public class HotelController {
    
    @Autowired HotelClient hotelClient;
    
    @GetMapping("findHotelById/{id}")
    public JsonNode findHotelById(@PathVariable int id, HttpServletRequest servletRequest) {
        return hotelClient.findHotelById(id, servletRequest);
    }
    
    @GetMapping("searchHotel/{searchString}")
    public JsonNode searchHotel(@PathVariable String searchString, HttpServletRequest servletRequest) {
        return hotelClient.searchHotel(searchString, servletRequest);
    }
    
    @GetMapping("getRoomTypesOfHotel/{hotelId}")
    public JsonNode getRoomTypesOfHotel(@PathVariable int hotelId, HttpServletRequest servletRequest) {
        return hotelClient.getRoomTypesOfHotel(hotelId, servletRequest);
    }
    
    @GetMapping("getRoomPriceAndDiscount/{hotelId}/{roomTypeId}")
    public JsonNode getRoomPriceAndDiscount(@PathVariable int hotelId, @PathVariable int roomTypeId, HttpServletRequest servletRequest) {
        return hotelClient.getRoomPriceAndDiscount(hotelId, roomTypeId, servletRequest);
    }
    
}
