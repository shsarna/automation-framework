package com.model.oaimportdb;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "xxxml_import", schema = "xxxml_v10_import")
public class XxxmlImport {

    @Column(name = "status_message")
    private String statusMessage;

    @Column(name = "callback_arki_after_import_status",
            nullable = false)
    private Integer callbackAfterCoreImportStatus;

    @Column(name = "callback_arki_after_sync_status",
            nullable = false)
    private Integer callbackAfterSyncImportStatus;

    @Column(name = "callback_arki_after_import_timestamp")
    private Timestamp callbackAfterCoreImportTimestamp;

    @Column(name = "callback_arki_after_sync_timestamp")
    private Timestamp callbackAfterSyncImportTimestamp;

    @Column(name = "business_line")
    private String businessLine;

    @Column(name = "device_market")
    private String deviceMarket;

    @Column(name = "device_model")
    private String deviceModel;

    @Column(name = "device_model_variant")
    private String deviceModelVariant;

    @Column(name = "device_name")
    private String deviceName;

    @Column(name = "dom_content_sync_status",
            nullable = false)
    private Integer domContentSyncStatus;

    @Column(name = "dom_content_sync_timestamp",
            nullable = false)
    private Timestamp domContentSyncTimestamp;

    @Column(name = "dom_ui_data_sync_status",
            nullable = false)
    private Integer domUiDataSyncStatus;

    @Column(name = "dom_ui_data_sync_timestamp",
            nullable = false)
    private Timestamp domUiDataSyncTimestamp;

    @Id
    @SequenceGenerator(name = "xxxml_import_id_seq_gen",
            sequenceName = "xxxml_v10_import.xxxml_import_xxxml_import_id_seq",
            allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE,
            generator = "xxxml_import_id_seq_gen")
    @Column(name = "xxxml_import_id")
    private Long importId;

    @Column(name = "xxxml_import_service_status",
            nullable = false)
    private Integer importServiceStatus;

    @Column(name = "core_status")
    private Integer coreStatus;

    @Column(name = "xxxml_import_service_timestamp",
            nullable = false)
    private Timestamp importServiceTimestamp;

    @Column(name = "sync_status")
    private Integer syncStatus;

    @Column(name = "language",
            length = 5)
    private String language;

    @Column(name = "locale",
            length = 5)
    private String locale;

    @Column(name = "market")
    private String market;

    @Column(name = "masterdata_normalization_status",
            nullable = false)
    private Integer masterdataNormalizationStatus;

    @Column(name = "masterdata_normalization_timestamp",
            nullable = false)
    private Timestamp masterdataNormalizationTimestamp;

    @Column(name = "masterdata_post_bulk_status",
            nullable = false)
    private Integer masterdataPostBulkStatus;

    @Column(name = "masterdata_post_bulk_timestamp",
            nullable = false)
    private Timestamp masterdataPostBulkTimestamp;

    @Column(name = "oa_content_post_bulk_status",
            nullable = false)
    private Integer oaContentBulkStatus;

    @Column(name = "oa_content_post_bulk_timestamp",
            nullable = false)
    private Timestamp oaContentBulkTimestamp;

    @Column(name = "request_message",
            nullable = false)
    private String requestMessage;

    @Column(name = "request_timestamp",
            nullable = false)
    private Timestamp requestTimestamp;

    @Column(name = "request_type",
            nullable = false,
            length = 1)
    private String requestType;

    @Column(name = "response_message",
            nullable = false)
    private String responseMessage;

    @Column(name = "response_timestamp",
            nullable = false)
    private Timestamp responseTimestamp;

    @Column(name = "user_id",
            nullable = false,
            length = 50)
    private String userId;

    @Column(name = "vehicle_line")
    private String vehicleLine;

    @Column(name = "vehicle_market")
    private String vehicleMarket;

    public String getStatusMessage() {
        return statusMessage;
    }

    public XxxmlImport setStatusMessage(String statusMessage) {
        this.statusMessage = statusMessage;
        return this;
    }

    public Integer getCallbackAfterCoreImportStatus() {
        return callbackAfterCoreImportStatus;
    }

    public XxxmlImport setCallbackAfterCoreImportStatus(Integer callbackAfterCoreImportStatus) {
        this.callbackAfterCoreImportStatus = callbackAfterCoreImportStatus;
        return this;
    }

    public Integer getCallbackAfterSyncImportStatus() {
        return callbackAfterSyncImportStatus;
    }

    public XxxmlImport setCallbackAfterSyncImportStatus(Integer callbackAfterSyncImportStatus) {
        this.callbackAfterSyncImportStatus = callbackAfterSyncImportStatus;
        return this;
    }

    public Timestamp getCallbackAfterCoreImportTimestamp() {
        return callbackAfterCoreImportTimestamp;
    }

    public XxxmlImport setCallbackAfterCoreImportTimestamp(Timestamp callbackAfterCoreImportTimestamp) {
        this.callbackAfterCoreImportTimestamp = callbackAfterCoreImportTimestamp;
        return this;
    }

    public Timestamp getCallbackAfterSyncImportTimestamp() {
        return callbackAfterSyncImportTimestamp;
    }

    public XxxmlImport setCallbackAfterSyncImportTimestamp(Timestamp callbackAfterSyncImportTimestamp) {
        this.callbackAfterSyncImportTimestamp = callbackAfterSyncImportTimestamp;
        return this;
    }

    public String getBusinessLine() {
        return businessLine;
    }

    public XxxmlImport setBusinessLine(String businessLine) {
        this.businessLine = businessLine;
        return this;
    }

    public String getDeviceMarket() {
        return deviceMarket;
    }

    public XxxmlImport setDeviceMarket(String deviceMarket) {
        this.deviceMarket = deviceMarket;
        return this;
    }

    public String getDeviceModel() {
        return deviceModel;
    }

    public XxxmlImport setDeviceModel(String deviceModel) {
        this.deviceModel = deviceModel;
        return this;
    }

    public String getDeviceModelVariant() {
        return deviceModelVariant;
    }

    public XxxmlImport setDeviceModelVariant(String deviceModelVariant) {
        this.deviceModelVariant = deviceModelVariant;
        return this;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public XxxmlImport setDeviceName(String deviceName) {
        this.deviceName = deviceName;
        return this;
    }

    public Integer getDomContentSyncStatus() {
        return domContentSyncStatus;
    }

    public XxxmlImport setDomContentSyncStatus(Integer domContentSyncStatus) {
        this.domContentSyncStatus = domContentSyncStatus;
        return this;
    }

    public Timestamp getDomContentSyncTimestamp() {
        return domContentSyncTimestamp;
    }

    public XxxmlImport setDomContentSyncTimestamp(Timestamp domContentSyncTimestamp) {
        this.domContentSyncTimestamp = domContentSyncTimestamp;
        return this;
    }

    public Integer getDomUiDataSyncStatus() {
        return domUiDataSyncStatus;
    }

    public XxxmlImport setDomUiDataSyncStatus(Integer domUiDataSyncStatus) {
        this.domUiDataSyncStatus = domUiDataSyncStatus;
        return this;
    }

    public Timestamp getDomUiDataSyncTimestamp() {
        return domUiDataSyncTimestamp;
    }

    public XxxmlImport setDomUiDataSyncTimestamp(Timestamp domUiDataSyncTimestamp) {
        this.domUiDataSyncTimestamp = domUiDataSyncTimestamp;
        return this;
    }

    public Long getImportId() {
        return importId;
    }

    public XxxmlImport setImportId(Long importId) {
        this.importId = importId;
        return this;
    }

    public Integer getImportServiceStatus() {
        return importServiceStatus;
    }

    public XxxmlImport setImportServiceStatus(Integer importServiceStatus) {
        this.importServiceStatus = importServiceStatus;
        return this;
    }

    public Integer getCoreStatus() {
        return coreStatus;
    }

    public XxxmlImport setCoreStatus(Integer coreStatus) {
        this.coreStatus = coreStatus;
        return this;
    }

    public Timestamp getImportServiceTimestamp() {
        return importServiceTimestamp;
    }

    public XxxmlImport setImportServiceTimestamp(Timestamp importServiceTimestamp) {
        this.importServiceTimestamp = importServiceTimestamp;
        return this;
    }

    public Integer getSyncStatus() {
        return syncStatus;
    }

    public XxxmlImport setSyncStatus(Integer syncStatus) {
        this.syncStatus = syncStatus;
        return this;
    }

    public String getLanguage() {
        return language;
    }

    public XxxmlImport setLanguage(String language) {
        this.language = language;
        return this;
    }

    public String getLocale() {
        return locale;
    }

    public XxxmlImport setLocale(String locale) {
        this.locale = locale;
        return this;
    }

    public String getMarket() {
        return market;
    }

    public XxxmlImport setMarket(String market) {
        this.market = market;
        return this;
    }

    public Integer getMasterdataNormalizationStatus() {
        return masterdataNormalizationStatus;
    }

    public XxxmlImport setMasterdataNormalizationStatus(Integer masterdataNormalizationStatus) {
        this.masterdataNormalizationStatus = masterdataNormalizationStatus;
        return this;
    }

    public Timestamp getMasterdataNormalizationTimestamp() {
        return masterdataNormalizationTimestamp;
    }

    public XxxmlImport setMasterdataNormalizationTimestamp(Timestamp masterdataNormalizationTimestamp) {
        this.masterdataNormalizationTimestamp = masterdataNormalizationTimestamp;
        return this;
    }

    public Integer getMasterdataPostBulkStatus() {
        return masterdataPostBulkStatus;
    }

    public XxxmlImport setMasterdataPostBulkStatus(Integer masterdataPostBulkStatus) {
        this.masterdataPostBulkStatus = masterdataPostBulkStatus;
        return this;
    }

    public Timestamp getMasterdataPostBulkTimestamp() {
        return masterdataPostBulkTimestamp;
    }

    public XxxmlImport setMasterdataPostBulkTimestamp(Timestamp masterdataPostBulkTimestamp) {
        this.masterdataPostBulkTimestamp = masterdataPostBulkTimestamp;
        return this;
    }

    public Integer getOaContentBulkStatus() {
        return oaContentBulkStatus;
    }

    public XxxmlImport setOaContentBulkStatus(Integer oaContentBulkStatus) {
        this.oaContentBulkStatus = oaContentBulkStatus;
        return this;
    }

    public Timestamp getOaContentBulkTimestamp() {
        return oaContentBulkTimestamp;
    }

    public XxxmlImport setOaContentBulkTimestamp(Timestamp oaContentBulkTimestamp) {
        this.oaContentBulkTimestamp = oaContentBulkTimestamp;
        return this;
    }

    public String getRequestMessage() {
        return requestMessage;
    }

    public XxxmlImport setRequestMessage(String requestMessage) {
        this.requestMessage = requestMessage;
        return this;
    }

    public Timestamp getRequestTimestamp() {
        return requestTimestamp;
    }

    public XxxmlImport setRequestTimestamp(Timestamp requestTimestamp) {
        this.requestTimestamp = requestTimestamp;
        return this;
    }

    public String getRequestType() {
        return requestType;
    }

    public XxxmlImport setRequestType(String requestType) {
        this.requestType = requestType;
        return this;
    }

    public String getResponseMessage() {
        return responseMessage;
    }

    public XxxmlImport setResponseMessage(String responseMessage) {
        this.responseMessage = responseMessage;
        return this;
    }

    public Timestamp getResponseTimestamp() {
        return responseTimestamp;
    }

    public XxxmlImport setResponseTimestamp(Timestamp responseTimestamp) {
        this.responseTimestamp = responseTimestamp;
        return this;
    }

    public String getUserId() {
        return userId;
    }

    public XxxmlImport setUserId(String userId) {
        this.userId = userId;
        return this;
    }

    public String getVehicleLine() {
        return vehicleLine;
    }

    public XxxmlImport setVehicleLine(String vehicleLine) {
        this.vehicleLine = vehicleLine;
        return this;
    }

    public String getVehicleMarket() {
        return vehicleMarket;
    }

    public XxxmlImport setVehicleMarket(String vehicleMarket) {
        this.vehicleMarket = vehicleMarket;
        return this;
    }
}
