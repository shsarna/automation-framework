package com;

import com.config.rabbitmq.notificators.basync.BAPublishMessage;
import com.config.rabbitmq.notificators.basync.OACorePublishMessage;
import com.controller.listener.MessageListener;
import com.controller.listener.ToolingMessageListener;
import com.cos.CosProviderImpl;
import com.model.AssertCountModel;
import com.model.FlashwareRequestBody;
import com.model.arkidompreviwdb.PreviewProperty;
import com.model.domswdb.DomSwRelease;
import com.model.oacontentdb.ContentRequest;
import com.model.oaimportdb.XxxmlImport;
import com.model.rest.OaContentServiceBulkRequestSchema;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.Before;
import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.fabric8.kubernetes.client.*;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.PropertiesConfiguration;
import org.apache.commons.configuration.PropertiesConfigurationLayout;
import org.apache.commons.io.FileUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.junit.After;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.*;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import java.io.*;
import java.math.BigInteger;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Consumer;

import static java.nio.charset.StandardCharsets.UTF_8;
import static java.util.Map.entry;
import static org.apache.commons.lang3.StringUtils.EMPTY;
import static org.apache.commons.lang3.StringUtils.isEmpty;
import static org.junit.Assert.assertEquals;
import static org.springframework.http.HttpMethod.GET;
import static org.springframework.http.HttpMethod.POST;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT, classes = Application.class)
@ActiveProfiles("test")
@RunWith(SpringRunner.class)
public class IntegrationStepDefinitions {


    public static final String BASE_TEST_PATH = "src/test/resources";
    public static final String TIMESTAMP1REGEX = "\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}.\\d{3}(Z|\\+\\d{2}:\\d{2})";
    public static final String WORD1REGEX = "\\w{32}";
    public static final String WORD2REGEX = "\\w{31}";
    public static final String WORD3REGEX = "\\w{30}";
    private static final Logger LOGGER = LoggerFactory.getLogger(IntegrationStepDefinitions.class);
   
    public static String serviceName = null;
    public static String propertyName = null;
    public static String propertyValue = null;

    @Value("${endpoint.service}")
    String serviceBasePath;
   
    @Autowired
    RestTemplate restTemplate;
    @Autowired
    MessageListener messageListener;
    @Autowired
    DatabaseUtility databaseUtility;
    @Autowired
    ObjectMapper objectMapper;
    @Autowired
    RestClient restClient;
    @Autowired
    MessageValidation messageValidation;
    @Autowired
    private LogsVerifier logVerifier;
    @Autowired
    private KubernetesUtils kubernetesUtils;
    private String responseJsononlinepackage;
    private boolean responseWithError;
    private HttpStatus responseStatus;

    @Given("full text")
    public void given() {
        System.out.println("full text");
    }
    
    @Given("^partial text$")
    public void partial() {
        System.out.println("partial text");

    }

}


