package com.synex.client;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;

@Component
public class RoomTypeClient {
    
    @GetMapping  // RequestMapping annotation for HttpServletRequest
    public JsonNode findRoomTypeById(int id, HttpServletRequest servletRequest) {
        String contextPath = servletRequest.getContextPath();
        
        // RestTemplate can make requests to another project on another port.
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity =  // get reseponseEntity from API of another project (microservice)
                restTemplate.getForEntity("http://localhost:8084/" + contextPath + "/findRoomTypeById/" + id, Object.class);  // Response is List<Booking>
        Object obj = responseEntity.getBody();  // get body of responseEntity
        
        ObjectMapper mapper = new ObjectMapper();  // let mapper to convert it to json
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);  // JsonNode can represent any json.
        return returnObj;
    }
    
}
