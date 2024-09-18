package com.example.greetings;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GreetController {
    @GetMapping("/greet")
    public String greet(){
        System.out.println("Hello endpoint was called!");
        return "Good Evening Folks!";
    }

}
