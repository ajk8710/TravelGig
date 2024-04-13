package com.synex.client;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;

@Component
public class ReviewClient {
    
    @GetMapping  // RequestMapping annotation for HttpServletRequest
    public JsonNode saveReview(JsonNode json, HttpServletRequest servletRequest) {  // get json from controller
        String contextPath = servletRequest.getContextPath();
        
        HttpHeaders headers = new HttpHeaders();  // make sure to import from spring package, not java.net package
        headers.setContentType(MediaType.APPLICATION_JSON);  // construct request to be sent to another project's API
        HttpEntity<String> request = new HttpEntity<>(json.toString(), headers);  // new HttpEntity<>(body, headers)
        
        RestTemplate restTemplate = new RestTemplate();  // use restTemplate to send request to another project
        ResponseEntity<Object> responseEntity =          // and receive response back from another project
                restTemplate.postForEntity("http://localhost:8083/" + contextPath + "/saveReview", request, Object.class);
        Object obj = responseEntity.getBody();  // get body of response
        
        ObjectMapper mapper = new ObjectMapper();  // use objectMapper to convert body to json.
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);
        return returnObj;
    }
    
    @GetMapping
    public JsonNode findAllReviewsByHotelId(int hotelId, HttpServletRequest servletRequest) {
        String contextPath = servletRequest.getContextPath();
        
        // RestTemplate can make requests to another project on another port.
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity =  // get reseponseEntity from API of another project (microservice)
                restTemplate.getForEntity("http://localhost:8083/" + contextPath + "/findAllReviewsByHotelId/" + hotelId, Object.class);  // Response is List<Review>
        Object obj = responseEntity.getBody();  // get body of responseEntity
        
        ObjectMapper mapper = new ObjectMapper();  // let mapper to convert it to json
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);  // JsonNode can represent any json.
        return returnObj;
    }
    
}
