package com;

import io.cucumber.java.en.And;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class ArchivedIntegrationStepDefinitions {
import io.cucumber.java.en.And;

    @And("oa-content-service publishes the bulk message {string} in the queues bind to {string}")
    public void oaContentServicePublishesBulkMessages(String messagePath, String exchange) throws InterruptedException, IOException {
//        messageValidation.validateOaContentBulkMessageWithContentValidation(messagePath, exchange);
        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);

        for (int i = 0; i < 300; i++) {
            if (!MessageListener.isOaContentBulkMessageReceived()) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }
        String expectedMessage = Files.readString(Paths.get(BASE_TEST_PATH + messagePath)).replaceAll(TIMESTAMP1REGEX, "date").replaceAll(TIMESTAMP2REGEX, "date");
        ;
        String actualMessage = MessageListener.getOacontentBulkMessage().replaceAll(TIMESTAMP1REGEX, "date").replaceAll(TIMESTAMP2REGEX, "date");

        System.out.println("Actual message is : " + actualMessage);

        String expectedMessageAfterSplitting[] = expectedMessage.split("\n");

        for (int i = 0; i < expectedMessageAfterSplitting.length; i++) {
            System.out.println("validating line number" + i + "result is : " + actualMessage.contains(expectedMessageAfterSplitting[i]));
            Assert.assertTrue(actualMessage.contains(expectedMessageAfterSplitting[i]));
        }
    }

    @And("oa-content-service publishes the query message {string} in the queues bind to {string}")
    public void oaContentServicePublishesqueryMessages(String messagePath, String exchange) throws InterruptedException, IOException {
        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);

        for (int i = 0; i < 300; i++) {
            if (!MessageListener.isDomUiOaContentQueryMessageReceived()) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }
        String expectedMessage = Files.readString(Paths.get(BASE_TEST_PATH + messagePath));
        expectedMessage = expectedMessage.substring(expectedMessage.indexOf("info"));
        String actualMessage = MessageListener.domuioacontentQueryMessage();

        expectedMessage = UCImportSupportStepDef.modifyMessage(expectedMessage);
        actualMessage = UCImportSupportStepDef.modifyMessage(actualMessage);

        Assert.assertTrue("!!!FAIL: Message verification failed for Exchange: " +
                        "Expected msg : " + expectedMessage
                        + "Actual msg: " + actualMessage,
                actualMessage.contains(expectedMessage));
    }

    @And("xxxml-import-service publishes the import message {string} in the queues bind to {string}")
    public void xxxmImportArki4import(String messagePath, String exchange) throws InterruptedException, IOException {
        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);

        for (int i = 0; i < 300; i++) {
            if (!MessageListener.isxxxmlimportarki4importQueryMessageReceived()) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }
        String expectedMessage = Files.readString(Paths.get(BASE_TEST_PATH + messagePath)).replaceAll(TIMESTAMP1REGEX, "date");
        String actualMessage = MessageListener.xxxmlArki4QueryMessage().replaceAll(TIMESTAMP1REGEX, "date");
        System.out.println("xxxml arki4 message is : " + actualMessage);

        String expectedMessageAfterSplitting[] = expectedMessage.split("\n");

        for (int i = 0; i < expectedMessageAfterSplitting.length; i++) {
            System.out.println("validating line number" + i + "result is : " + actualMessage.contains(expectedMessageAfterSplitting[i]));
            //Assert.assertTrue(actualMessage.contains(expectedMessageAfterSplitting[i]));
        }
    }

    @And("xxxml-import-service publishes the import message {string} in the queues bind to the {string}")
    public void xxxmImportArki4imports(String messagePath, String exchange) throws InterruptedException, IOException {
        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);

        for (int i = 0; i < 300; i++) {
            if (!MessageListener.isxxxmlimportarki4importQueryMessageReceived()) {
                Thread.sleep(1000);
            } else {
                LOGGER.info("Message on {} received.", exchange);
                break;
            }
        }
        Assert.assertTrue(MessageListener.isxxxmlimportarki4importQueryMessageReceived());
    }

    @And("oa-content-service publishes the dom content query message {string} in the queues bind to {string}")
    public void oaContentServicePublishesdomcontentqueryMessages(String messagePath, String exchange) throws InterruptedException, IOException {
        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);

        for (int i = 0; i < 300; i++) {
            if (!MessageListener.isDomContentOaContentQueryMessageReceived()) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }
        String expectedMessage = Files.readString(Paths.get(BASE_TEST_PATH + messagePath));
        String actualdomContentMessage = MessageListener.domContentoacontentQueryMessage();
        expectedMessage = expectedMessage.replaceAll(TIMESTAMP1REGEX, "date");
        System.out.println("Oa query message is : " + actualdomContentMessage);
        actualdomContentMessage = actualdomContentMessage.replaceAll(TIMESTAMP1REGEX, "date");

        Assert.assertTrue(actualdomContentMessage.contains(expectedMessage));
    }

    @And("oa-content-service publishes the dom ui query message {string} in the queues bind to {string}")
    public void oaContentServicePublishesdomuiqueryMessages(String messagePath, String exchange) throws InterruptedException, IOException {
        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);

        for (int i = 0; i < 300; i++) {
            if (!MessageListener.isDomUiOaContentQueryMessageReceived()) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }
        String expectedMessage = Files.readString(Paths.get(BASE_TEST_PATH + messagePath));
        String actualdomContentMessage = MessageListener.domuioacontentQueryMessage();
        expectedMessage = expectedMessage.replaceAll(TIMESTAMP1REGEX, "date");
        System.out.println("Oa query message is : " + actualdomContentMessage);
        actualdomContentMessage = actualdomContentMessage.replaceAll(TIMESTAMP1REGEX, "date");

        Assert.assertTrue(actualdomContentMessage.contains(expectedMessage));
    }


}








