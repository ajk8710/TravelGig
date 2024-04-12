package com.synex.client;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class ReviewClient {
    
    public JsonNode saveReview(JsonNode json) {  // get json from controller
        HttpHeaders headers = new HttpHeaders();  // make sure to import from spring package, not java.net package
        headers.setContentType(MediaType.APPLICATION_JSON);  // construct request to be sent to another project's API
        HttpEntity<String> request = new HttpEntity<>(json.toString(), headers);  // new HttpEntity<>(body, headers)
        
        RestTemplate restTemplate = new RestTemplate();  // use restTemplate to send request to another project
        ResponseEntity<Object> responseEntity =          // and receive response back from another project
                restTemplate.postForEntity("http://localhost:8083/saveReview", request, Object.class);
        Object obj = responseEntity.getBody();  // get body of response
        
        ObjectMapper mapper = new ObjectMapper();  // use objectMapper to convert body to json.
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);
        return returnObj;
    }
    
    public JsonNode findAllReviewsByHotelId(int hotelId) {
        // RestTemplate can make requests to another project on another port.
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<Object> responseEntity =  // get reseponseEntity from API of another project (microservice)
                restTemplate.getForEntity("http://localhost:8083/findAllReviewsByHotelId/" + hotelId, Object.class);  // Response is List<Review>
        Object obj = responseEntity.getBody();  // get body of responseEntity
        
        ObjectMapper mapper = new ObjectMapper();  // let mapper to convert it to json
        JsonNode returnObj = mapper.convertValue(obj, JsonNode.class);  // JsonNode can represent any json.
        return returnObj;
    }
    
}
