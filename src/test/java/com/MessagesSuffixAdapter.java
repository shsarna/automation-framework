package com;

import com.model.message.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class MessagesSuffixAdapter {

    private static final Logger LOGGER = LoggerFactory.getLogger(MessagesSuffixAdapter.class);

    @Value("${environment.suffix}")
    private String environmentSuffix;

    public DomcontentservicepackagesSchemaMessage changeSuffix(DomcontentservicepackagesSchemaMessage message) {
        LOGGER.info("\n\n This is the info message: {}", message.getInfo());
        LOGGER.info("\n\n This is the data message: {}", message.getData());
        if (!message.getData().getLocation().isEmpty()) {
            String location = message.getData().getLocation();
            String updatedSuffix = location.replaceAll("tsy-integration", environmentSuffix);
            message.getData().setLocation(updatedSuffix);
        } else
            LOGGER.info("Location is empty");

        return message;
    }

    public DomContentServiceMessagingSchema changeSuffix(DomContentServiceMessagingSchema message) {
        try {
            String location = message.getMessage().getData().getLocation();
            String updatedSuffix = location.replaceAll("tsy-integration", environmentSuffix);
            message.getMessage().getData().setLocation(updatedSuffix);
        } catch (NullPointerException ex) {
            LOGGER.info("Message doesn't contain suffix");
        }
        return message;
    }

    public GeneralOaMessagingSchema changeSuffix(GeneralOaMessagingSchema message) {
        String location = message.getMessage().getData().getLocation();
        String updatedSuffix = location.replaceAll("tsy-integration", environmentSuffix);

        List<OaServiceAndMessageReferenceSchema> references = message.getMessage().getData().getReferences();
        references.forEach(f -> {
            String refLocation = f.getLocation();
            String updateRefLocation = refLocation.replaceAll("tsy-integration", environmentSuffix);
            f.setLocation(updateRefLocation);
        });

        message.getMessage().getData().setLocation(updatedSuffix);
        message.getMessage().getData().setReferences(references);
        return message;
    }

    public DomUiDataServiceMessagingSchema changeSuffix(DomUiDataServiceMessagingSchema message) {
        try {
            String location = message.getMessage().getData().getLocation();
            String updatedSuffix = location.replaceAll("tsy-integration", environmentSuffix);
            message.getMessage().getData().setLocation(updatedSuffix);
        } catch (NullPointerException ex) {
            LOGGER.info("Message doesn't contain suffix");
        }
        return message;
    }
}
