package com.qualifier;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;
import java.util.HashMap;
import java.util.Map;

@SpringBootApplication
public class Application implements CommandLineRunner {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        // setup basic stuff
        RestTemplate client = new RestTemplate();
        ObjectMapper jsonMapper = new ObjectMapper();

        System.out.println("Starting Bajaj Finserv qualifier...");
        
        // step 1: get webhook
        String apiUrl = "https://bfhldevapigw.healthrx.co.in/hiring/generateWebhook/JAVA";
        
        Map<String, String> userData = new HashMap<>();
        userData.put("name", "Aniket Srivastava");
        userData.put("regNo", "1RV22ET064");
        userData.put("email", "anikets.et22@rvce.edu.in");

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Map<String, String>> request = new HttpEntity<>(userData, headers);
        
        ResponseEntity<String> response = client.postForEntity(apiUrl, request, String.class);
        JsonNode responseJson = jsonMapper.readTree(response.getBody());
        
        String webhookUrl = responseJson.get("webhook").asText();
        String authToken = responseJson.get("accessToken").asText();
        
        System.out.println("Webhook received: " + webhookUrl);
        
        // step 2: my regNo ends with 64 (even) so question 2
        String sql = "SELECT e1.EMP_ID, e1.FIRST_NAME, e1.LAST_NAME, d.DEPARTMENT_NAME, " +
                     "COUNT(e2.EMP_ID) AS YOUNGER_EMPLOYEES_COUNT " +
                     "FROM EMPLOYEE e1 " +
                     "JOIN DEPARTMENT d ON e1.DEPARTMENT = d.DEPARTMENT_ID " +
                     "LEFT JOIN EMPLOYEE e2 ON e1.DEPARTMENT = e2.DEPARTMENT AND e2.DOB > e1.DOB " +
                     "GROUP BY e1.EMP_ID, e1.FIRST_NAME, e1.LAST_NAME, d.DEPARTMENT_NAME " +
                     "ORDER BY e1.EMP_ID DESC";
        
        System.out.println("SQL query ready for question 2");
        
        // step 3: submit answer
        Map<String, String> answer = new HashMap<>();
        answer.put("finalQuery", sql);
        
        HttpHeaders submitHeaders = new HttpHeaders();
        submitHeaders.setContentType(MediaType.APPLICATION_JSON);
        submitHeaders.set("Authorization", authToken);
        
        HttpEntity<Map<String, String>> submitRequest = new HttpEntity<>(answer, submitHeaders);
        ResponseEntity<String> submitResponse = client.postForEntity(webhookUrl, submitRequest, String.class);
        
        System.out.println("Answer submitted!");
        System.out.println("Server response: " + submitResponse.getBody());
        
        System.exit(0);
    }
}
