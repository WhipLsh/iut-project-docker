package org.example.iutprojectdocker;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {


    @GetMapping("/")
    public String hello() {
        try {
            return "Hello World";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
}