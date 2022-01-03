package com.controller.listener;

import com.model.message.model.OaContentServiceMessagingSchema;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller
public class MessageListener {

    private static final Logger LOGGER = LoggerFactory.getLogger(MessageListener.class);

    private final ObjectMapper objectMapper;

    private boolean oaContentBulkMessageReceived;
    private boolean domUiOaContentQueryMessageReceived;
    private boolean domContentOaContentQueryMessageReceived;
    public String oaContentBulkMessage;
    public String domUiOaContentQueryMessage;
    public String domContentOaContentQueryMessage;
    private boolean arki4importMessageReceived;
    public String arki4importMessage;

    @Autowired
    public MessageListener(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    @RabbitListener(
            queues = "${oa-content-bulk.queue}",
            containerFactory = "coreRabbitListenerContainerFactory"
    )
    public void oaContentBulkMessage(final OaContentServiceMessagingSchema message) {
        LOGGER.info("Message received from queue oa-content-bulk");
        oaContentBulkMessageReceived = true;
        oaContentBulkMessage = message.toString();

    }


    @RabbitListener(
            queues = "${oa-content-query.dom-ui-queue}",
            containerFactory = "coreRabbitListenerContainerFactory"
    )
    public void domUiOaContentQueryMessage(final OaContentServiceMessagingSchema message) {
        LOGGER.info("Message received from queue oa-content-query");
        domUiOaContentQueryMessageReceived = true;
        domUiOaContentQueryMessage = message.toString();
    }

    @RabbitListener(
            queues = "${xxxml-import-arki4import_queue}",
            containerFactory = "coreRabbitListenerContainerFactory"
    )
    public void xxxmlArkiQueryMessage(final Object message) {
        LOGGER.info("Message received from queue xxxml-import-arki4import_queue");
        arki4importMessageReceived = true;
        arki4importMessage = message.toString();

    }

    @RabbitListener(
            queues = "${oa-content-query.dom-content-queue}",
            containerFactory = "coreRabbitListenerContainerFactory"
    )
    public void domContentOaContentQueryMessage(final OaContentServiceMessagingSchema message) {
        LOGGER.info("Message received from queue oa-content-query");
        domContentOaContentQueryMessageReceived = true;
        domContentOaContentQueryMessage = message.toString();
    }

    public boolean isOaContentBulkMessageReceived() {
        return oaContentBulkMessageReceived;
    }

    public boolean isDomUiOaContentQueryMessageReceived() {
        return domUiOaContentQueryMessageReceived;
    }

    public boolean isxxxmlimportarki4importQueryMessageReceived() {
        return arki4importMessageReceived;
    }

    public boolean isDomContentOaContentQueryMessageReceived() {
        return domContentOaContentQueryMessageReceived;
    }

    public String getOacontentBulkMessage() {
        return oaContentBulkMessage;
    }

    public String domuioacontentQueryMessage() {
        return domUiOaContentQueryMessage;
    }

    public String domContentoacontentQueryMessage() {
        return domContentOaContentQueryMessage;
    }

    public String xxxmlArki4QueryMessage() {
        return arki4importMessage;
    }


    public void reset() {
        oaContentBulkMessageReceived = false;
        domUiOaContentQueryMessageReceived = false;
        domContentOaContentQueryMessageReceived = false;
    }
}
