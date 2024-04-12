package com.synex.client;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class HotelClient {
    
    public JsonNode findHotelById(int id) {
        // RestTemplate can make requests to another project on another port.
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity =  // get reseponseEntity from API of another project (microservice)
                restTemplate.getForEntity("http://localhost:8084/findHotelById/" + id, Object.class);  // Response is List<Booking>
        Object obj = responseEntity.getBody();  // get body of responseEntity
        
        ObjectMapper mapper = new ObjectMapper();  // let mapper to convert it to json
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);  // JsonNode can represent any json.
        return returnObj;
    }
    
    public JsonNode searchHotel(String searchString) {
        // RestTemplate can make requests to another project on another port.
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity =  // get reseponseEntity from API of another project (microservice)
                restTemplate.getForEntity("http://localhost:8084/searchHotel/" + searchString, Object.class);  // Response is List<Hotel>
        Object obj = responseEntity.getBody();  // get body of responseEntity
        
        ObjectMapper mapper = new ObjectMapper();  // let mapper to convert it to json
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);  // JsonNode can represent any json.
        return returnObj;
    }
    
    public JsonNode getRoomTypesOfHotel(int hotelId) {
        // RestTemplate can make requests to another project on another port.
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity =  // get reseponseEntity from API of another project (microservice)
                restTemplate.getForEntity("http://localhost:8084/getRoomTypesOfHotel/" + hotelId, Object.class);  // Response is List<Hotel>
        Object obj = responseEntity.getBody();  // get body of responseEntity
        
        ObjectMapper mapper = new ObjectMapper();  // let mapper to convert it to json
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);  // JsonNode can represent any json.
        return returnObj;
    }
    
    public JsonNode getRoomPriceAndDiscount(int hotelId, int roomTypeId) {
        // RestTemplate can make requests to another project on another port.
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity =  // get reseponseEntity from API of another project (microservice)
                restTemplate.getForEntity("http://localhost:8084/getRoomPriceAndDiscount/" + hotelId + "/" + roomTypeId, Object.class);  // Response is List<Hotel>
        Object obj = responseEntity.getBody();  // get body of responseEntity
        
        ObjectMapper mapper = new ObjectMapper();  // let mapper to convert it to json
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);  // JsonNode can represent any json.
        return returnObj;
    }
    
}
