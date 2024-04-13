package com.synex.client;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;

@Component
public class HotelClient {
    
    @GetMapping  // RequestMapping annotation for HttpServletRequest
    public JsonNode findHotelById(int id, HttpServletRequest servletRequest) {
        String contextPath = servletRequest.getContextPath();
        
        // RestTemplate can make requests to another project on another port.
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity =  // get reseponseEntity from API of another project (microservice)
                restTemplate.getForEntity("http://localhost:8084/" + contextPath + "/findHotelById/" + id, Object.class);  // Response is List<Booking>
        Object obj = responseEntity.getBody();  // get body of responseEntity
        
        ObjectMapper mapper = new ObjectMapper();  // let mapper to convert it to json
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);  // JsonNode can represent any json.
        return returnObj;
    }
    
    @GetMapping
    public JsonNode searchHotel(String searchString, HttpServletRequest servletRequest) {
        String contextPath = servletRequest.getContextPath();
        
        // RestTemplate can make requests to another project on another port.
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity =  // get reseponseEntity from API of another project (microservice)
                restTemplate.getForEntity("http://localhost:8084/" + contextPath + "/searchHotel/" + searchString, Object.class);  // Response is List<Hotel>
        Object obj = responseEntity.getBody();  // get body of responseEntity
        
        ObjectMapper mapper = new ObjectMapper();  // let mapper to convert it to json
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);  // JsonNode can represent any json.
        return returnObj;
    }
    
    @GetMapping
    public JsonNode getRoomTypesOfHotel(int hotelId, HttpServletRequest servletRequest) {
        String contextPath = servletRequest.getContextPath();
        
        // RestTemplate can make requests to another project on another port.
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity =  // get reseponseEntity from API of another project (microservice)
                restTemplate.getForEntity("http://localhost:8084/" + contextPath + "/getRoomTypesOfHotel/" + hotelId, Object.class);  // Response is List<Hotel>
        Object obj = responseEntity.getBody();  // get body of responseEntity
        
        ObjectMapper mapper = new ObjectMapper();  // let mapper to convert it to json
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);  // JsonNode can represent any json.
        return returnObj;
    }
    
    @GetMapping
    public JsonNode getRoomPriceAndDiscount(int hotelId, int roomTypeId, HttpServletRequest servletRequest) {
        String contextPath = servletRequest.getContextPath();
        
        // RestTemplate can make requests to another project on another port.
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity =  // get reseponseEntity from API of another project (microservice)
                restTemplate.getForEntity("http://localhost:8084/" + contextPath + "/getRoomPriceAndDiscount/" + hotelId + "/" + roomTypeId, Object.class);  // Response is List<Hotel>
        Object obj = responseEntity.getBody();  // get body of responseEntity
        
        ObjectMapper mapper = new ObjectMapper();  // let mapper to convert it to json
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);  // JsonNode can represent any json.
        return returnObj;
    }
    
}
