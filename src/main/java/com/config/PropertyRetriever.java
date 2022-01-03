package com.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * This class is used to read application properties. Central point for @Value injection,
 * in order to not modify in several classes, in case of property renaming.
 */
@Component
public class PropertyRetriever {

    @Value("${core.amqp.server.url}")
    private String coreAmqpServerUrl;

    @Value("${core.amqp.server.port}")
    private int coreAmqpServerPort;

    @Value("${core.amqp.server.user-name}")
    private String coreAmqpServerUsername;

    @Value("${core.amqp.server.password}")
    private String coreAmqpServerPassword;

    @Value("${tooling.amqp.server.url}")
    private String toolingAmqpServerUrl;

    @Value("${tooling.amqp.server.port}")
    private int toolingAmqpServerPort;

    @Value("${tooling.amqp.server.user-name}")
    private String toolingAmqpServerUsername;

    @Value("${tooling.amqp.server.password}")
    private String toolingAmqpServerPassword;

    @Value("${amqp.server-certification-validation}")
    private boolean serverCertificationValidation;

    @Value("${rabbit.ssl}")
    private String sslAlgorithm;

    @Value("${rabbit.keystore.name}")
    private String keystore;

    @Value("${rabbit.keystore.password}")
    private String keystorePassword;

    @Value("${rabbit.truststore}")
    private String truststore;

    @Value("${rabbit.truststore.password}")
    private String truststorePassword;

    @Value("${oa-content-bulk.exchange}")
    private String oaContentBulkExchange;

    @Value("${oa-content-bulk.queue}")
    private String oaContentBulkQueue;

    @Value("${oa-content-query.exchange}")
    private String oaContentQueryExchange;

    @Value("${oa-content-query.dom-ui-queue}")
    private String domUiOaContentQueryQueue;

    @Value("${oa-content-query.dom-content-queue}")
    private String domContentOaContentQueryQueue;

    @Value("${dom-content-sync.exchange}")
    private String domContentSyncExchange;

    @Value("${dom-content-sync.queue}")
    private String domContentSyncQueue;

    @Value("${dom-content-flashware.exchange}")
    private String domContentFlashwareExchange;

    @Value("${dom-content-flashware.queue}")
    private String domContentFlashwareQueue;

    @Value("${dom-content-basync.exchange}")
    private String domContentBaSyncExchange;

    @Value("${dom-content-basync.queue}")
    private String domContentBaSyncQueue;

    @Value("${dom-ui-data-sync.exchange}")
    private String domUiDataSyncExchange;

    @Value("${dom-ui-data-sync.queue}")
    private String domUiDataSyncQueue;

    @Value("${dom-ui-data-basync.exchange}")
    private String domUiDataBaSyncExchange;

    @Value("${dom-ui-data-basync.queue}")
    private String domUiDataBaSyncQueue;

    @Value("${dom-container-service.dom-container.exchange}")
    private String domContainerServiceBinCompletedExchange;

    @Value("${dom-container-service.dom-container.queue}")
    private String domContainerServiceBinCompletedQueue;

    @Value("${xxxml-import-arki4import.exchange}")
    private String xxxmlImportArki4ImportExchange;

    @Value("${xxxml-import-arki4import.queue}")
    private String xxxmlImportArki4ImportQueue;

    //@Value("${dom-online-package-exchange}")
    // private String domOnlinePackageExchange;

    // @Value("${dom-content-database_exchange}")
    //  private String domContentDatabaseExchange;

//    @Value("${dom-online-package-queue}")
//    private String domOnlinePackageQueue;

    @Value("${dom-content-database_queue}")
    private String domContentDBQueue;

    @Value("${spring.oa-import-db.datasource.password}")
    private String oaImportDbPassword;

    @Value("${spring.oa-backend-db.datasource.password}")
    private String oaBackendDbPassword;

    @Value("${spring.oa-vehicle-backend-db.datasource.password}")
    private String oaVehicleBackendDbPassword;

    @Value("${spring.dom-ui-data-db.datasource.password}")
    private String domUiDataDbPassword;

    @Value("${spring.oa-import-db.datasource.jdbcUrl}")
    private String oaImportDbUrl;

    @Value("${spring.oa-backend-db.datasource.jdbcUrl}")
    private String oaBackendDbUrl;

    @Value("${spring.dom-ui-data-db.datasource.jdbcUrl}")
    private String domUiDataDbUrl;

    @Value("${spring.oa-vehicle-backend-db.datasource.jdbcUrl}")
    private String oaVehicleBackendDbUrl;

    @Value("${spring.arki-dom-preview-db.datasource.jdbcUrl}")
    private String arkiDomPreviewDbUrl;

    @Value("${spring.oa-backend-db.datasource.username}")
    private String oaImportDbUser;

    @Value("${spring.oa-backend-db.datasource.username}")
    private String oaBackendDbUser;

    @Value("${spring.dom-ui-data-db.datasource.username}")
    private String domUiDataDbUser;

    @Value("${spring.oa-vehicle-backend-db.datasource.username}")
    private String oaVehicleBackendDbUser;

    @Value("${spring.arki-dom-preview-db.datasource.username}")
    private String arkiDomPreviewDbUser;


    public String getCoreAmqpServerUrl() {
        return coreAmqpServerUrl;
    }

    public int getCoreAmqpServerPort() {
        return coreAmqpServerPort;
    }

    public String getCoreAmqpServerUsername() {
        return coreAmqpServerUsername;
    }

    public String getCoreAmqpServerPassword() {
        return coreAmqpServerPassword;
    }

    public String getToolingAmqpServerUrl() {
        return toolingAmqpServerUrl;
    }

    public int getToolingAmqpServerPort() {
        return toolingAmqpServerPort;
    }

    public String getToolingAmqpServerUsername() {
        return toolingAmqpServerUsername;
    }

    public String getToolingAmqpServerPassword() {
        return toolingAmqpServerPassword;
    }

    public boolean isServerCertificationValidation() {
        return serverCertificationValidation;
    }

    public String getSslAlgorithm() {
        return sslAlgorithm;
    }

    public String getKeystore() {
        return keystore;
    }

    public String getKeystorePassword() {
        return keystorePassword;
    }

    public String getTruststore() {
        return truststore;
    }

    public String getTruststorePassword() {
        return truststorePassword;
    }

    public String getOaContentBulkExchange() {
        return oaContentBulkExchange;
    }

    public String getOaContentBulkQueue() {
        return oaContentBulkQueue;
    }

    public String getOaContentQueryExchange() {
        return oaContentQueryExchange;
    }

    public String getDomUiOaContentQueryQueue() {
        return domUiOaContentQueryQueue;
    }

    public String getDomContentOaContentQueryQueue() {
        return domContentOaContentQueryQueue;
    }

    public String getDomContentSyncExchange() {
        return domContentSyncExchange;
    }

    public String getDomContentSyncQueue() {
        return domContentSyncQueue;
    }

    public String getDomContentBaSyncExchange() {
        return domContentBaSyncExchange;
    }

    public String getDomContentBaSyncQueue() {
        return domContentBaSyncQueue;
    }

    public String getDomUiDataSyncExchange() {
        return domUiDataSyncExchange;
    }

    public String getDomUiDataSyncQueue() {
        return domUiDataSyncQueue;
    }

    public String getDomUiDataBaSyncExchange() {
        return domUiDataBaSyncExchange;
    }

    public String getDomUiDataBaSyncQueue() {
        return domUiDataBaSyncQueue;
    }

    public String getXxxmlImportArki4ImportExchange() {
        return xxxmlImportArki4ImportExchange;
    }

    public String getXxxmlImportArki4ImportQueue() {
        return xxxmlImportArki4ImportQueue;
    }

    public String getOaImportDbPassword() {
        return oaImportDbPassword;
    }

    public String getOaImportDbUrl() {
        return oaImportDbUrl;
    }

    public String getOaImportDbUser() {
        return oaImportDbUser;
    }

    public String getDomOnlinePackageDBPassword() {
        return "hGWeMzzpnBLZMlKe";
    }

    public String getOaBackendDbPassword() {
        return oaBackendDbPassword;
    }

    public String getOaBackendDbUrl() {
        return oaBackendDbUrl;
    }

    public String getOaBackendDbUser() {
        return oaBackendDbUser;
    }

    public String getOaVehicleBackendDbPassword() {
        return oaVehicleBackendDbPassword;
    }

    public String getOaVehicleBackendDbUrl() {
        return oaVehicleBackendDbUrl;
    }

    public String getOaVehicleBackendDbUser() {
        return oaVehicleBackendDbUser;
    }

    public String getDomUiDataDbPassword() {
        return domUiDataDbPassword;
    }

    public String getDomUiDataDbUrl() {
        return domUiDataDbUrl;
    }

    public String getDomUiDataDbUer() {
        return domUiDataDbUser;
    }

    public String arkiDomPreviewDbUrl() {
        return arkiDomPreviewDbUrl;
    }

    public String arkiDomPreviewDbUser() {
        return arkiDomPreviewDbUser;
    }

    public String getDomContainerServiceBinCompletedExchange() {
        return domContainerServiceBinCompletedExchange;
    }

    public String getDomContainerServiceBinCompletedQueue() {
        return domContainerServiceBinCompletedQueue;
    }

    public String getDomContentFlashwareExchange() {
        return domContentFlashwareExchange;
    }

    public String getDomContentFlashwareQueue() {
        return domContentFlashwareQueue;
    }
}