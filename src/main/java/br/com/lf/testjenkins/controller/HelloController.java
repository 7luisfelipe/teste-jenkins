package br.com.lf.testjenkins.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/hello", produces = MediaType.APPLICATION_JSON_VALUE)
public class HelloController {

    @GetMapping
    public ResponseEntity<String> getHello(){
        return new ResponseEntity<>(
                "Successo - Aplicação rodando no jenkins",
                HttpStatus.OK
        );
    }

}
