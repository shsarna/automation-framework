package com;

import com.controller.listener.MessageListener;
import com.controller.listener.ToolingMessageListener;
import com.model.message.model.DomContentServiceMessagingSchema;
import com.model.message.model.DomUiDataServiceMessagingSchema;
import com.model.message.model.DomcontentservicepackagesSchemaMessage;
import com.model.message.model.DomuidataservicemessagingSchemaMessageData;
import com.model.message.model.GeneralOaMessagingSchema;
import com.model.message.model.OaContentServiceMessagingSchema;
import com.model.message.model.OaServiceAndMessageReferenceSchema;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.cucumber.datatable.DataTable;
import org.junit.Assert;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import static com.IntegrationStepDefinitions.BASE_TEST_PATH;

@Component
public class MessageValidation {
    private static final Logger LOGGER = LoggerFactory.getLogger(MessageValidation.class);

    @Autowired
    MessageListener MessageListener;
    @Autowired
    ToolingMessageListener toolingMessageListener;
    @Autowired
    ObjectMapper objectMapper;
    @Autowired
    MessagesSuffixAdapter messagesSuffixAdapter;

    public void validateMessage(String messagePath, String exchange)
            throws InterruptedException, IOException {
        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);
        int SECONDS_TO_WAIT = 400;
        for (int i = 0; i < SECONDS_TO_WAIT; i++) {
            if (!toolingMessageListener.isDomContentPackageCreationMessageReceived()) {
                Thread.sleep(1100);
            } else {
                break;
            }
        }
        Assert.assertTrue("The message was not received.",
                toolingMessageListener.isDomContentPackageCreationMessageReceived());

        String expectedMessage = Files.readString(Paths.get(BASE_TEST_PATH + messagePath));
        DomcontentservicepackagesSchemaMessage expectedPackageMessage = objectMapper.readValue(expectedMessage, DomcontentservicepackagesSchemaMessage.class);
        LOGGER.info("\n\n Print expected package message: {}", expectedPackageMessage.toString());
//        expectedPackageMessage = messagesSuffixAdapter.changeSuffix(expectedPackageMessage);
        expectedPackageMessage = removeDates(expectedPackageMessage);

        DomcontentservicepackagesSchemaMessage actualPackageMessage = toolingMessageListener.domContentPackageCreationMessages()
                .get(0);
        actualPackageMessage = removeDates(actualPackageMessage);

        final String actualAsString = objectMapper.writeValueAsString(actualPackageMessage);
        final String expectedAsString = objectMapper.writeValueAsString(expectedPackageMessage);

        Assert.assertTrue("The messages are not similar. Actual is: " + actualAsString + " expected is: " + expectedAsString,
                actualPackageMessage.equals(expectedPackageMessage));
    }

    public void validateDomContentPackagesMessage(String exchange, DataTable dt)
            throws InterruptedException, IOException {

        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);

        List<String> dataTableList = dt.asList();
        for (int i = 0; i < 300; i++) {
            if (!(dataTableList.size() - 1 > toolingMessageListener.domContentPackageCreationMessages().size())) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }

        Assert.assertEquals("Failed because the number of expected messages was: " + (dataTableList.size() - 1) + "\n but only " + toolingMessageListener.domContentPackageCreationMessages().size() + " arrived.",
                dataTableList.size() - 1, toolingMessageListener.domContentPackageCreationMessages().size());

        for (int i = 1; i < dataTableList.size(); i++) {
            final String expectedMessageAsString = Files.readString(Paths.get(BASE_TEST_PATH + dataTableList.get(i)));
            DomcontentservicepackagesSchemaMessage expectedMessage = objectMapper.readValue(expectedMessageAsString, DomcontentservicepackagesSchemaMessage.class);

            DomcontentservicepackagesSchemaMessage actualMessage = toolingMessageListener.domContentPackageCreationMessages().get(i - 1);


            final String expectedAsString = objectMapper.writeValueAsString(expectedMessage);
            final String actualAsString = objectMapper.writeValueAsString(actualMessage);
            //System.out.println("validating line number " + i + " result is : " + actualdomContentMessage.contains(expectedAfterSplitting[i]));
            Assert.assertEquals("Failed because expected result was: " + expectedAsString + "\n but was found: " + actualAsString,
                    expectedMessage, actualMessage);
        }

    }

    private DomcontentservicepackagesSchemaMessage removeDates(DomcontentservicepackagesSchemaMessage packageMessage) {
        packageMessage.getInfo()
                .forEach(f -> f.setTimestamp(null));
        return packageMessage;
    }

    public void validateDomContentSyncMessage(String exchange) throws InterruptedException, JsonProcessingException {

        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);

        for (int i = 0; i < 300; i++) {
            if (!toolingMessageListener.isDomContentSyncMessageReceived()) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }

        Assert.assertTrue("content-sync message did not arrive.", toolingMessageListener.isDomContentSyncMessageReceived());
    }

    public void validateDomContentSyncMessageWithContentValidation(String messagePath, String exchange)
            throws InterruptedException, IOException {
        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);

        for (int i = 0; i < 300; i++) {
            if (!toolingMessageListener.isDomContentSyncMessageReceived()) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }

        String expecteddomContentSyncMessage = Files.readString(Paths.get(BASE_TEST_PATH + messagePath));
        DomContentServiceMessagingSchema expected = objectMapper.readValue(expecteddomContentSyncMessage, DomContentServiceMessagingSchema.class);

        DomContentServiceMessagingSchema actual = toolingMessageListener.domContentSyncMessage().get(0);

        Assert.assertTrue("Sync message did not arrive.", toolingMessageListener.isDomContentSyncMessageReceived());

        expected = messagesSuffixAdapter.changeSuffix(expected);
        prepareMessageForComparison(expected);
        prepareMessageForComparison(actual);

        String actualAsString = objectMapper.writeValueAsString(actual);
        String expectedAsString = objectMapper.writeValueAsString(expected);

        Assert.assertEquals("The expected message: " + expectedAsString + " does not match the actual message " + actualAsString,
                expected, actual);
    }

    private void prepareMessageForComparison(DomContentServiceMessagingSchema pojo) {
        pojo.getMessage().getInfo().forEach(f -> f.setTimestamp(null));
        if (pojo.getMessage().getData() != null
                && pojo.getMessage().getData().getData() != null
                && pojo.getMessage().getData().getData().getResourceChanges() != null) {

            // remove ids because order they might not match from one run to another
            pojo.getMessage().getData().getData().getResourceChanges()
                    .forEach(f -> f.id(null).location(null));
            // sort the list to preserve order
            pojo.getMessage().getData().getData().getResourceChanges()
                    .sort(Comparator.comparing(a -> (a.getData().getObjectIdFromSrc() + a.getType())));

            List<OaServiceAndMessageReferenceSchema> references = pojo.getMessage().getData().getReferences();
            if (references != null) {
                removeIdsFromReferences(references);
            }
        }
    }

    public void validateDomContentBaSyncMessageReceived(String exchange) throws InterruptedException {
        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);

        for (int i = 0; i < 300; i++) {
            if (!toolingMessageListener.isDomContentBaSyncMessageReceived()) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }
        Assert.assertTrue("ba-sync message was not received on " + exchange,
                toolingMessageListener.isDomContentBaSyncMessageReceived());
    }

    public void validateDomContentBaSyncMessageContent(String messagePath, String exchange)
            throws IOException, InterruptedException {
        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);

        for (int i = 0; i < 300; i++) {
            if (!toolingMessageListener.isDomContentBaSyncMessageReceived()) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }

        Assert.assertTrue(toolingMessageListener.isDomContentBaSyncMessageReceived());

        String expecteddomContentSyncMessage = Files.readString(Paths.get(BASE_TEST_PATH + messagePath));
        DomContentServiceMessagingSchema expected = objectMapper.readValue(expecteddomContentSyncMessage, DomContentServiceMessagingSchema.class);

        DomContentServiceMessagingSchema actual = toolingMessageListener.domContentbaSyncMessage().get(0);

        expected = messagesSuffixAdapter.changeSuffix(expected);
        prepareMessageForComparison(expected);
        prepareMessageForComparison(actual);

        Assert.assertTrue("ba-sync message was not received on " + exchange,
                toolingMessageListener.isDomContentBaSyncMessageReceived());

        final String actualAsString = objectMapper.writeValueAsString(actual);
        final String expectedAsString = objectMapper.writeValueAsString(expected);

        Assert.assertEquals("The expected message: " + expectedAsString + " does not match the actual message " + actualAsString,
                expected, actual);
    }

    public void validateDomUiContentSyncMessage(String messagePath, String exchange) throws InterruptedException, IOException {
        for (int i = 0; i < 300; i++) {
            if (!toolingMessageListener.isDomUiDataSyncMessageReceived()) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }
        Assert.assertTrue("Dom ui content synce message did not arrive",
                toolingMessageListener.isDomUiDataSyncMessageReceived());

        String expectedDomUiSyncMessage = Files.readString(Paths.get(BASE_TEST_PATH + messagePath));
        GeneralOaMessagingSchema expected = objectMapper.readValue(expectedDomUiSyncMessage, GeneralOaMessagingSchema.class);
        removeDatesAndIdSpecifics(expected);
        GeneralOaMessagingSchema actual = toolingMessageListener.dom_ui_ContentSyncMessage().get(0);
        removeDatesAndIdSpecifics(actual);

        expected = messagesSuffixAdapter.changeSuffix(expected);
        String expectedAsString = objectMapper.writeValueAsString(expected);
        String actualAsString = objectMapper.writeValueAsString(actual);

        Assert.assertEquals("The expected message: " + expectedAsString + " does not match the actual message " + actualAsString,
                expected, actual);
    }

    private void removeDatesAndIdSpecifics(GeneralOaMessagingSchema expected) {
        expected.getMessage().getInfo().forEach(f -> f.setTimestamp(null));
        if (expected.getMessage().getData() != null && expected.getMessage().getData().getReferences() != null) {
            removeIdsFromReferences(expected.getMessage().getData().getReferences());
        }
    }

    private void removeIdsFromReferences(List<OaServiceAndMessageReferenceSchema> references) {
        references.forEach(c -> {
            c.setId(null);
            int rootLocationIndex = c.getLocation().lastIndexOf('/');
            final String lastPartOfLocation = c.getLocation().substring(rootLocationIndex + 1);
            if (lastPartOfLocation.matches("\\d*")) {
                String locationWithoutId = c.getLocation().substring(0, rootLocationIndex);
                c.setLocation(locationWithoutId);
            }
        });
    }

    public void validateDomUiBaSyncMessagesCount(String exchanges) throws InterruptedException {
        LOGGER.info("Verifying the messages sent on queues bound to exchanges: {} .", exchanges);

        for (int i = 0; i < 300; i++) {
            if (toolingMessageListener.getDomUiBaSyncMessageCount() < 3) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }
        Assert.assertEquals("dom-ui baSync message count did not match.", 3, toolingMessageListener.getDomUiBaSyncMessageCount());
    }

    public void validateDomUiBaSyncMessages(String messagePath, String exchange) throws InterruptedException, IOException {
        LOGGER.info("Verifying the messages sent on queues bound to exchanges: {} .", exchange);

        for (int i = 0; i < 300; i++) {
            if (toolingMessageListener.getDomUiBaSyncMessageCount() == 0) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }
        Assert.assertFalse("No dom-ui baSync message was received.", toolingMessageListener.dom_ui_BaSyncMessages().isEmpty());

        String expectedDomUiBaSyncMessage = Files.readString(Paths.get(BASE_TEST_PATH + messagePath));
        DomUiDataServiceMessagingSchema expected = objectMapper.readValue(expectedDomUiBaSyncMessage, DomUiDataServiceMessagingSchema.class);
        removeDatesAndIdSpecifics(expected);
        List<DomUiDataServiceMessagingSchema> actual = toolingMessageListener.dom_ui_BaSyncMessages();
        actual.forEach(this::removeDatesAndIdSpecifics);

        expected = messagesSuffixAdapter.changeSuffix(expected);

        final String expectedAsString = objectMapper.writeValueAsString(expected);
        final String actualAsString = actual.stream().map(m -> {
            try {
                return objectMapper.writeValueAsString(m);
            } catch (JsonProcessingException e) {
                return "error while printing the baSync";
            }
        }).collect(Collectors.joining(";"));

        boolean foundMatchingMessage = false;
        for (DomUiDataServiceMessagingSchema message : actual) {
            if (expected.equals(message)) {
                foundMatchingMessage = true;
                break;
            }
        }

        Assert.assertTrue("No matching message was found for baSync. Expected " + expectedAsString + " but received: [" + actualAsString + "]",
                foundMatchingMessage);
    }

    private void removeDatesAndIdSpecifics(DomUiDataServiceMessagingSchema expected) {
        expected.getMessage().getInfo().forEach(f -> f.setTimestamp(null));
        DomuidataservicemessagingSchemaMessageData data = expected.getMessage().getData();
        if (data != null) {
            data.setId(null);
            int rootLocationIndex = data.getLocation().lastIndexOf('/');
            final String lastPartOfLocation = data.getLocation().substring(rootLocationIndex + 1);
            if (lastPartOfLocation.matches("\\d*")) {
                String locationWithoutId = data.getLocation().substring(0, rootLocationIndex);
                data.setLocation(locationWithoutId);
            }
        }
    }

    public void validateDomContainerMessage(String messagePath) throws InterruptedException, IOException {
        LOGGER.info("Verifying the message sent on queue bound to exchange: {}");

        for (int i = 0; i < 300; i++) {
            if (!toolingMessageListener.isDomContainerBinCreationMessageReceived()) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }

        Assert.assertTrue("dom-container message did not arrive", toolingMessageListener.isDomContainerBinCreationMessageReceived());

        String expectedMessage = Files.readString(Paths.get(BASE_TEST_PATH + messagePath));
        GeneralOaMessagingSchema expected = objectMapper.readValue(expectedMessage, GeneralOaMessagingSchema.class);
        removeDatesAndIdSpecifics(expected);
        GeneralOaMessagingSchema actual = toolingMessageListener.domContainerBinCreationMessage().get(0);
        removeDatesAndIdSpecifics(actual);

        expected = messagesSuffixAdapter.changeSuffix(expected);

        String expectedAsString = objectMapper.writeValueAsString(expected);
        String actualAsString = objectMapper.writeValueAsString(actual);

        Assert.assertEquals("No matching message was found for baSync. Expected " + expectedAsString + " but received: [" + actualAsString + "]",
                expected, actual);
    }

    public void validateOaContentBulkMessageWithContentValidation(String messagePath, String exchange)
            throws InterruptedException, IOException {
        LOGGER.info("Verifying the message sent on queue bound to exchange: {}", exchange);

        for (int i = 0; i < 300; i++) {
            if (!MessageListener.isOaContentBulkMessageReceived()) {
                Thread.sleep(1000);
            } else {
                break;
            }
        }

        String expectedOaContentBulkMessage = Files.readString(Paths.get(BASE_TEST_PATH + messagePath));
        final OaContentServiceMessagingSchema expected = objectMapper.readValue(expectedOaContentBulkMessage, OaContentServiceMessagingSchema.class);
        removeDates(expected);

        OaContentServiceMessagingSchema actual = objectMapper.readValue(MessageListener.getOacontentBulkMessage(), OaContentServiceMessagingSchema.class);
        removeDates(actual);

        Assert.assertTrue("Sync message did not arrive.", MessageListener.isOaContentBulkMessageReceived());

        String actualAsString = objectMapper.writeValueAsString(actual);
        String expectedAsString = objectMapper.writeValueAsString(expected);

        Assert.assertEquals("The expected message: " + expectedAsString + " does not match the actual message " + actualAsString,
                expected, actual);
    }

    private void removeDates(OaContentServiceMessagingSchema expected) {
        expected.getMessage().getInfo().forEach(f -> f.setTimestamp(null));
    }

}
