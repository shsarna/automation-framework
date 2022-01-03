package com;

import io.cucumber.java.After;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.configuration.PropertiesConfigurationLayout;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.client.ResourceAccessException;

import java.io.*;

import static java.nio.charset.StandardCharsets.UTF_8;

public class HooksSupport {

    public static final String BASE_TEST_PATH = "src/test/resources";
    protected static final Logger LOGGER = LoggerFactory.getLogger(HooksSupport.class);
    @Autowired
    DatabaseUtility databaseUtility;
    @Autowired
    KubernetesUtils kubernetesUtils;
    @Autowired
    IntegrationStepDefinitions integrationStepDefinitions;

    @After("@tag")
    public void resetMethod() {
        LOGGER.info("Reset method");
    }

}
