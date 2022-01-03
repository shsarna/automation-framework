package com;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
@CucumberOptions(
        features = {"classpath:features/"},


        tags = {"@test"},


        glue = "com",
        monochrome = true,
        plugin = {"pretty",
                "json:target/cucumber-reports/cucumber-automated-integration.json",
                "html:target/cucumber-reports"
        }
)
public class CucumberRunnerTest {
}
