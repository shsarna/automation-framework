package com;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@ComponentScan(basePackages = "com")
@EnableTransactionManagement
@EnableAutoConfiguration
public class Application {

    public static void main(final String[] args) {
        new SpringApplication(Application.class).run(args);
    }
}
