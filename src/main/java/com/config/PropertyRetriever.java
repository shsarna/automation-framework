package com.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * This class is used to read application properties. Central point for @Value injection,
 * in order to not modify in several classes, in case of property renaming.
 */
@Component
public class PropertyRetriever {

    @Value("${server.url}")
    private String serverUrl;


    public String getServerUrl() {
        return serverUrl;
    }

}