package ua.com.hellomoto.brotherhood.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
//@EnableAutoConfiguration
public class WelcomeController {

    //for test external property file
//    @Value("${level.advanced.score}")
//    private double ADVANCED_SCORE;

    @RequestMapping("/app/")
    public String index() {
        return "Welcome to Brotherhood Application!!! version 0.0.1";
//                + ADVANCED_SCORE;

    }

}