DROP TABLE IF EXISTS xxxml_v10_import.oa_resource CASCADE
;

DROP TABLE IF EXISTS xxxml_v10_import.xxxml_import CASCADE
;

DROP TABLE IF EXISTS xxxml_v10_import.sys_param CASCADE
;

CREATE TABLE xxxml_v10_import.oa_resource
(
	oa_resource_id bigserial NOT NULL,
	xxxml_import_id bigint NOT NULL,
	resource_type text NOT NULL,
	resource_id bigint NOT NULL,
	resource_location text NOT NULL
)
;

CREATE TABLE xxxml_v10_import.xxxml_import
(
	xxxml_import_id bigserial NOT NULL,
	request_type char(1) NOT NULL,
	request_message text NOT NULL,
	response_message text NULL,
	request_timestamp timestamp(6) with time zone NOT NULL,
	response_timestamp timestamp(6) with time zone NULL,
	user_id varchar(50) NOT NULL,
	xxxml_import_service_status smallint NOT NULL   DEFAULT 0,
	xxxml_import_service_timestamp timestamp(6) with time zone NULL,
	oa_content_post_bulk_status smallint NOT NULL   DEFAULT 0,	-- Status of the POST /bulk request to OA Content Service for the objects with payload and their relations  (second transaction within the POST /bulk request). Possible values:  0 = NEW: to be processed, 2 = COMPLETED: POST /bulk request to OA Content Service for the objects with payload (second transaction) has completed successfully, 3 = FAILED: POST /bulk request to OA Content Service for the objects with payload (second transaction) has failed.
	oa_content_post_bulk_timestamp timestamp(6) with time zone NULL,	-- Timestamp, when OA_CONTENT_POST_BULK_STATUS was set to either COMPLETED or FAILED.
	oa_content_post_bulk_message text NULL,	-- Status message that is sent in cases of failure as described in the service specification. e.g. the column will be populated, if the POST /bulk of the OA Content Service has failed.
	oa_content_post_bulk_type smallint NULL,	-- This column shows the status on code level based on the Common Service Definitions.   Possible values are: 1 = information (success) 2 = warning (success) 3 = business error (failure) 4 = system error (failure)
	dom_content_sync_status smallint NOT NULL   DEFAULT 0,	-- Status of sync from OA Content Service to DOM Content Service. Possible values:  0 = NEW: to be processed, 2 = COMPLETED: sync to DOM Content Service has completed successfully, 3 = FAILED: sync to DOM Content Service has failed.
	dom_content_sync_timestamp timestamp(6) with time zone NULL,	-- Timestamp, when DOM_CONTENT_SYNC_STATUS was set to either COMPLETED or FAILED.
	dom_content_sync_message text NULL,	-- Status message that is sent in cases of failure as described in the service specification. e.g. the column will be populated, if the sync to DOM Content Service has failed.
	dom_content_sync_type smallint NULL,	-- This column shows the status on code level based on the Common Service Definitions.   Possible values are: 1 = information (success) 2 = warning (success) 3 = business error (failure) 4 = system error (failure)
	dom_ui_data_sync_status smallint NOT NULL   DEFAULT 0,	-- Status of sync from OA Content Service to DOM UI Data Service. Possible values:  0 = NEW: to be processed, 2 = COMPLETED: sync to DOM UI Data Service has completed successfully, 3 = FAILED: sync to DOM UI Data Service has failed.
	dom_ui_data_sync_timestamp timestamp(6) with time zone NULL,	-- Timestamp, when DOM_UI_DATA_SYNC_STATUS was set to COMPLETED or FAILED.
	dom_ui_data_sync_message text NULL,	-- Status message that is sent in cases of failure as described in the service specification. e.g. the column will be populated, if the sync to DOM UI Data Service has failed.
	dom_ui_data_sync_type smallint NULL,	-- This column shows the status on code level based on the Common Service Definitions.   Possible values are: 1 = information (success) 2 = warning (success) 3 = business error (failure) 4 = system error (failure)
	pa_id text NULL,	-- The PA-ID of the pub-edition, for which the owners manual is intended for. (In german: "Publikationsausgabe") Example normalized to lower case: pa180559
	business_line text NULL,	-- Business Line validity for the imported SuperXML.  As Masterdata Query service doesn't have the BUSINESS_LINE, the value is copied from the konverter.xml file and then converted to lower case. Example: 'p'
	vehicle_line text NULL,	-- Vehicle Line validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and afterwards converted to lower case. Example: "223.1".
	vehicle_market text NULL,	-- Vehicle Line Market validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and afterwards converted to lower case.  E.g. "ma-ece/row".
	state_of_construction text NULL,	-- The state-of-construction, for which the owners manual is intended for. (In german: "Bauzustand") Example: 808+059
	market text NULL,	-- Market validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and afterwards converted to lower case. E.g. "ece/row".
	device_name text NULL,	-- Device name validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and afterwards converted to lower case. E.g "ntg".
	device_model text NULL,	-- Device model validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and afterwards converted to lower case. E.g. "7.0".
	device_model_variant text NULL,	-- Device model variant validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and then converted to lower case.  Examples: "premium" or "mid".
	device_market text NULL,	-- Device market validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and afterwards converted to lower case. E.g. "hu-ece/row".
	language varchar(5) NULL,	-- Language of the imported SuperXML. First part of language/locale string, normalized via Mastadata Query Service and afterwards converted to lower case. Part before the '_'. Example: 'en_GB' => LANGUAGE = 'en'.
	locale varchar(5) NULL,	-- Locale of the imported SuperXML. Second part of language/locale string, normalized via Mastadata Query Service and afterwards converted to lower case. Part after the '_'. Example: 'en_GB' => LOCALE = 'gb'.
	masterdata_normalization_status smallint NOT NULL   DEFAULT 0,	-- Status of the masterdata query to BA-Stamm Service for the normalization of the metadata extracted from the konverter.xml file. Possible values:  0 = NEW: to be processed, 2 = COMPLETED: processing of masterdata query to BA-Stamm  has completed successfully, 3 = FAILED: masterdata-query request to BA-Stamm Service  has failed.
	masterdata_normalization_timestamp timestamp(6) with time zone NULL,	-- Timestamp, when MASTERDATA_NORMALIZATION_STATUS was set to either COMPLETED or FAILED.
	masterdata_post_bulk_status smallint NOT NULL   DEFAULT 0,	-- Status of the  POST /bulk request to OA Content Service for persisting the masterdata objects. Possible values:  0 = NEW: to be processed, 2 = COMPLETED: POST /bulk request to OA Content Service for the masterdata objects has completed successfully, 3 = FAILED: POST /bulk request to OA Content Service for the masterdata objects has failed.
	masterdata_post_bulk_timestamp timestamp(6) with time zone NULL,	-- Timestamp, when MASTERDATA_POST_BULK_STATUS was set to either COMPLETED or FAILED.
	status_message text NULL,	-- Status message sent to ARKI in cases of failure as described in the service specification. E.g. the column will be populated, if the masterdata normalization via BA Platform has failed.
	callback_arki_after_import_status smallint NOT NULL   DEFAULT 0,	-- Status of the callback to ARKI after the import into OA Core has finished:  0 = NEW: Callback to ARKI4 is yet to be performed, 2 = COMPLETED: Callback to ARKI4 has completed successfully, 3 = FAILED: Callback to ARKI4 has failed.  It depends on the configuration, if the callback to ARKI is performed after the import into OA Core and/or after the sync with NTG7 Tooling. Also the fact, if the import is successful or not, influences if and when the ARKI callback is performed.
	callback_arki_after_import_timestamp timestamp(6) with time zone NULL,	-- Timestamp, when CALLBACK_ARKI_AFTER_IMPORT_STATUS was set to either COMPLETED or FAILED.
	callback_arki_after_sync_status smallint NOT NULL   DEFAULT 0,	-- Status of the callback to ARKI after the synchronisation with NTG7 Tooling has finished, i.e. after the synchronisation with DOM Content Service and the synchronisation with DOM UI Data Service have finished.  0 = NEW: Callback to ARKI4 is yet to be performed, 2 = COMPLETED: Callback to ARKI4 has completed successfully, 3 = FAILED: Callback to ARKI4 has failed.  It depends on the configuration, if the callback to ARKI is performed after the import into OA Core and/or after the sync with NTG7 Tooling. Also the fact, if the import is successful or not, influences if and when the ARKI callback is performed.
	callback_arki_after_sync_timestamp timestamp(6) with time zone NULL,	-- Timestamp, when CALLBACK_ARKI_AFTER_SYNC_STATUS was set to either COMPLETED or FAILED.
	core_status smallint NOT NULL   DEFAULT 0,	-- Status of the import into OA Core. Possible values:  0 = NEW: to be processed, 1 = IN_PROGRESS: processing of XXXML V10 Import Service or/and OA Content Service POST /bulk is in progress, 2 = COMPLETED:  processing of XXXML V10 Import Service and OA Content Service POST /bulk has completed successfully, 3 = FAILED: processing of XXXML V10 Import Service or OA Content Service POST /bulk has failed.
	sync_status smallint NOT NULL   DEFAULT 0,	-- Status of the sync with NTG7 Tooling. Possible values:  0 = NEW: to be processed, 1 = IN_PROGRESS: processing of DOM Content Service or/and DOM UI Data Service is in progress, 2 = COMPLETED:  processing of DOM Content Service and DOM UI Data Service has completed successfully, 3 = FAILED: processing of DOM Content Service or DOM UI Data Service has failed.
	fail_reason text NULL	-- Optional text field to add a reason in case of an error. Possible constants will be defined in the xxxml-import-service specification.  Example value: BA_PLATFORM_NOT_REACHABLE
)
;

CREATE TABLE xxxml_v10_import.sys_param
(
	sys_param_id bigserial NOT NULL,	-- Internal Id. Primary key of the table.
	par_name varchar(100) NOT NULL,	-- Name of the parameter.  This must be unique for all rows in the table.
	par_value varchar(300) NOT NULL,	-- Value of the parameter.
	par_description varchar(300) NULL	-- Description of the parameter. It should describe the meaning of the specific parameter or for what purpose the parameter is needed.
)
;



ALTER TABLE xxxml_v10_import.oa_resource ADD CONSTRAINT pk_oa_resource
	PRIMARY KEY (oa_resource_id)
;

CREATE INDEX ixfk_oa_resource_xxxml_import ON xxxml_v10_import.oa_resource (xxxml_import_id ASC)
;

ALTER TABLE xxxml_v10_import.xxxml_import ADD CONSTRAINT pk_xxxml_import
	PRIMARY KEY (xxxml_import_id)
;

CREATE INDEX ix_xxxml_import_request_timestamp ON xxxml_v10_import.xxxml_import (request_timestamp ASC)
;

CREATE INDEX ix_xxxml_import_response_timestamp ON xxxml_v10_import.xxxml_import (response_timestamp ASC)
;

CREATE INDEX ix_xxxml_import_import_service_status ON xxxml_v10_import.xxxml_import (xxxml_import_service_status ASC)
;

CREATE INDEX ix_xxxml_import_oa_content_post_bulk_status ON xxxml_v10_import.xxxml_import (oa_content_post_bulk_status ASC)
;

CREATE INDEX ix_xxxml_import_dom_content_sync_status ON xxxml_v10_import.xxxml_import (dom_content_sync_status ASC)
;

CREATE INDEX ix_xxxml_import_dom_ui_data_sync_status ON xxxml_v10_import.xxxml_import (dom_ui_data_sync_status ASC)
;

CREATE INDEX ix_xxxml_import_callback_arki_after_import_status ON xxxml_v10_import.xxxml_import (callback_arki_after_import_status ASC)
;

CREATE INDEX ix_xxxml_import_masterdata_normalization_status ON xxxml_v10_import.xxxml_import (masterdata_normalization_status ASC)
;

CREATE INDEX ix_xxxml_import_masterdata_post_bulk_status ON xxxml_v10_import.xxxml_import (masterdata_post_bulk_status ASC)
;

CREATE INDEX ix_xxxml_import_callback_arki_after_sync_status ON xxxml_v10_import.xxxml_import (callback_arki_after_sync_status ASC)
;

CREATE INDEX ix_xxxml_import_core_status ON xxxml_v10_import.xxxml_import (core_status ASC)
;

CREATE INDEX ix_xxxml_import_sync_status ON xxxml_v10_import.xxxml_import (sync_status ASC)
;

ALTER TABLE xxxml_v10_import.sys_param ADD CONSTRAINT pk_sys_param
	PRIMARY KEY (sys_param_id)
;

ALTER TABLE xxxml_v10_import.sys_param
  ADD CONSTRAINT uk_sys_param_sec_key UNIQUE (par_name)
;



ALTER TABLE xxxml_v10_import.oa_resource ADD CONSTRAINT fk_oa_resource_xxxml_import
	FOREIGN KEY (xxxml_import_id) REFERENCES xxxml_v10_import.xxxml_import (xxxml_import_id) ON DELETE No Action ON UPDATE No Action
;



COMMENT ON TABLE xxxml_v10_import.oa_resource
	IS 'This table stores all OA resources that are connected to one XXXML Import resource.

For example:
type: urn:com:mercedes-benz:oa:oa-content-service:bulk
id: 1
location: http://oa.daimler.com/oa-content-service/v1/bulk/1

type: urn:com:mercedes-benz:oa:dom-content-service:contentsync
id: 1
location: http://oa.daimler.com/dom-content-service/v1/contentsync/1

type: urn:com:mercedes-benz:oa:dom-ui-data-service:contentsync
id: 1
location: http://oa.daimler.com/dom-ui-data-service/v1/contentsync/1'
;

COMMENT ON COLUMN xxxml_v10_import.oa_resource.oa_resource_id
	IS 'Internal ID of the table OA_RESOURCE.
Used as PK.'
;

COMMENT ON COLUMN xxxml_v10_import.oa_resource.xxxml_import_id
	IS 'ID of the XXXML Import resource.
Reference to the associated row in the table XXXML_IMPORT.'
;

COMMENT ON COLUMN xxxml_v10_import.oa_resource.resource_type
	IS 'Unique resource name to identify the resource type.

General composition: urn::oa:::'
;

COMMENT ON COLUMN xxxml_v10_import.oa_resource.resource_id
	IS 'ID of the referenced resource.'
;

COMMENT ON COLUMN xxxml_v10_import.oa_resource.resource_location
	IS 'Location of the referenced resource.

Example: http://oa.daimler.com/[service]/v1/[resource]/20'
;



COMMENT ON TABLE xxxml_v10_import.xxxml_import
	IS 'This table belongs to the XXXML_V10_IMPORT schema, which is owned by the "XXXML V10 Import Service".

This table is a protocol and status table, in which the "XXXML V10 Import Service" logs which user has initiated the import of which data.
One row in the table represents an imports resource, that means one import of a SuperXML file from ARKI to the OA System. There are several columns that provide information about the status of the whole import - including processing by the "XXXML V10 Import Service", "OA Content Service", "DOM Content Service", "DOM UI Data Service" and the masterdata query to BA-Stamm Service.
The table also contains columns for the validities extracted from the konverter.xml and for the language attributes.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.xxxml_import_id
	IS 'Internal Id of the import. PK of the table.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.request_type
	IS 'Type of the request. Possible values:
"A" = ARKI4 CMS,
"N" = New Protocol'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.request_message
	IS 'Request Message, formatted as JSON.

Example for a ARKI4 CMS request message (request_type = ''A''):

{"actionCode":["PREVIEW","PUBLISH"],
"basePath":"http://standalone-adapter:8090/diba-standalone-proxy/InputServlet/a8adbdbb529b40d1b5918f29cac62a0e/",
"pid":"a8adbdbb529b40d1b5918f29cac62a0e",
"responseURL":"http://standalone-adapter:8090/diba-standalone-proxy/CallbackServlet/a8adbdbb529b40d1b5918f29cac62a0e"}'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.response_message
	IS 'Response message formatted as JSON.
It is initially set to NULL, when the row with the request is inserted into the table.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.request_timestamp
	IS 'Timestamp, when the request was sent.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.response_timestamp
	IS 'Timestamp, when the response was inserted into the table.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.user_id
	IS 'User, who initiated the request. This should be provided from the service context.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.xxxml_import_service_status
	IS 'Status of the imports request to the XXXML V10 Import Service. Possible values:

0 = NEW: to be processed,
1 = IN_PROGRESS: processing of XXXML V10 Import Service is in progress,
2 = COMPLETED: request to XXXML V10 Import Service has completed successfully,
3 = FAILED: request to  XXXML V10 Import Service has failed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.xxxml_import_service_timestamp
	IS 'Timestamp, when XXXML_IMPORT_SERVICE_STATUS was set to either COMPLETED or FAILED.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.oa_content_post_bulk_status
	IS 'Status of the POST /bulk request to OA Content Service for the objects with payload and their relations  (second transaction within the POST /bulk request). Possible values:

0 = NEW: to be processed,
2 = COMPLETED: POST /bulk request to OA Content Service for the objects with payload (second transaction) has completed successfully,
3 = FAILED: POST /bulk request to OA Content Service for the objects with payload (second transaction) has failed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.oa_content_post_bulk_timestamp
	IS 'Timestamp, when OA_CONTENT_POST_BULK_STATUS was set to either COMPLETED or FAILED.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.oa_content_post_bulk_message
	IS 'Status message that is sent in cases of failure as described in the service specification.
e.g. the column will be populated, if the POST /bulk of the OA Content Service has failed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.oa_content_post_bulk_type
	IS 'This column shows the status on code level based on the Common Service Definitions.

Possible values are:
1 = information (success)
2 = warning (success)
3 = business error (failure)
4 = system error (failure)'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.dom_content_sync_status
	IS 'Status of sync from OA Content Service to DOM Content Service. Possible values:

0 = NEW: to be processed,
2 = COMPLETED: sync to DOM Content Service has completed successfully,
3 = FAILED: sync to DOM Content Service has failed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.dom_content_sync_timestamp
	IS 'Timestamp, when DOM_CONTENT_SYNC_STATUS was set to either COMPLETED or FAILED.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.dom_content_sync_message
	IS 'Status message that is sent in cases of failure as described in the service specification.
e.g. the column will be populated, if the sync to DOM Content Service has failed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.dom_content_sync_type
	IS 'This column shows the status on code level based on the Common Service Definitions.

Possible values are:
1 = information (success)
2 = warning (success)
3 = business error (failure)
4 = system error (failure)'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.dom_ui_data_sync_status
	IS 'Status of sync from OA Content Service to DOM UI Data Service. Possible values:

0 = NEW: to be processed,
2 = COMPLETED: sync to DOM UI Data Service has completed successfully,
3 = FAILED: sync to DOM UI Data Service has failed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.dom_ui_data_sync_timestamp
	IS 'Timestamp, when DOM_UI_DATA_SYNC_STATUS was set to COMPLETED or FAILED.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.dom_ui_data_sync_message
	IS 'Status message that is sent in cases of failure as described in the service specification.
e.g. the column will be populated, if the sync to DOM UI Data Service has failed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.dom_ui_data_sync_type
	IS 'This column shows the status on code level based on the Common Service Definitions.

Possible values are:
1 = information (success)
2 = warning (success)
3 = business error (failure)
4 = system error (failure)'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.pa_id
	IS 'The PA-ID of the pub-edition, for which the owners manual is intended for.
(In german: "Publikationsausgabe")
Example normalized to lower case: pa180559'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.business_line
	IS 'Business Line validity for the imported SuperXML.
As Masterdata Query service doesn''t have the BUSINESS_LINE, the value is copied from the konverter.xml file and then converted to lower case. Example: ''p'''
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.vehicle_line
	IS 'Vehicle Line validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and afterwards converted to lower case. Example: "223.1".'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.vehicle_market
	IS 'Vehicle Line Market validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and afterwards converted to lower case.  E.g. "ma-ece/row".'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.state_of_construction
	IS 'The state-of-construction, for which the owners manual is intended for.
(In german: "Bauzustand")
Example: 808+059'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.market
	IS 'Market validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and afterwards converted to lower case. E.g. "ece/row".'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.device_name
	IS 'Device name validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and afterwards converted to lower case. E.g "ntg".'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.device_model
	IS 'Device model validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and afterwards converted to lower case. E.g. "7.0".'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.device_model_variant
	IS 'Device model variant validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and then converted to lower case.  Examples: "premium" or "mid".'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.device_market
	IS 'Device market validity for the imported SuperXML. Value, as normalized via Masterdata Query Service and afterwards converted to lower case. E.g. "hu-ece/row".'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.language
	IS 'Language of the imported SuperXML. First part of language/locale string, normalized via Mastadata Query Service and afterwards converted to lower case. Part before the ''_''. Example: ''en_GB'' => LANGUAGE = ''en''.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.locale
	IS 'Locale of the imported SuperXML. Second part of language/locale string, normalized via Mastadata Query Service and afterwards converted to lower case. Part after the ''_''. Example: ''en_GB'' => LOCALE = ''gb''.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.masterdata_normalization_status
	IS 'Status of the masterdata query to BA-Stamm Service for the normalization of the metadata extracted from the konverter.xml file. Possible values:

0 = NEW: to be processed,
2 = COMPLETED: processing of masterdata query to BA-Stamm  has completed successfully,
3 = FAILED: masterdata-query request to BA-Stamm Service  has failed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.masterdata_normalization_timestamp
	IS 'Timestamp, when MASTERDATA_NORMALIZATION_STATUS was set to either COMPLETED or FAILED.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.masterdata_post_bulk_status
	IS 'Status of the  POST /bulk request to OA Content Service for persisting the masterdata objects. Possible values:

0 = NEW: to be processed,
2 = COMPLETED: POST /bulk request to OA Content Service for the masterdata objects has completed successfully,
3 = FAILED: POST /bulk request to OA Content Service for the masterdata objects has failed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.masterdata_post_bulk_timestamp
	IS 'Timestamp, when MASTERDATA_POST_BULK_STATUS was set to either COMPLETED or FAILED.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.status_message
	IS 'Status message sent to ARKI in cases of failure as described in the service specification.
E.g. the column will be populated, if the masterdata normalization via BA Platform has failed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.callback_arki_after_import_status
	IS 'Status of the callback to ARKI after the import into OA Core has finished:

0 = NEW: Callback to ARKI4 is yet to be performed,
2 = COMPLETED: Callback to ARKI4 has completed successfully,
3 = FAILED: Callback to ARKI4 has failed.

It depends on the configuration, if the callback to ARKI is performed after the import into OA Core and/or after the sync with NTG7 Tooling.
Also the fact, if the import is successful or not, influences if and when the ARKI callback is performed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.callback_arki_after_import_timestamp
	IS 'Timestamp, when CALLBACK_ARKI_AFTER_IMPORT_STATUS was set to either COMPLETED or FAILED.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.callback_arki_after_sync_status
	IS 'Status of the callback to ARKI after the synchronisation with NTG7 Tooling has finished, i.e. after the synchronisation with DOM Content Service and the synchronisation with DOM UI Data Service have finished.

0 = NEW: Callback to ARKI4 is yet to be performed,
2 = COMPLETED: Callback to ARKI4 has completed successfully,
3 = FAILED: Callback to ARKI4 has failed.

It depends on the configuration, if the callback to ARKI is performed after the import into OA Core and/or after the sync with NTG7 Tooling.
Also the fact, if the import is successful or not, influences if and when the ARKI callback is performed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.callback_arki_after_sync_timestamp
	IS 'Timestamp, when CALLBACK_ARKI_AFTER_SYNC_STATUS was set to either COMPLETED or FAILED.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.core_status
	IS 'Status of the import into OA Core. Possible values:

0 = NEW: to be processed,
1 = IN_PROGRESS: processing of XXXML V10 Import Service or/and OA Content Service POST /bulk is in progress,
2 = COMPLETED:  processing of XXXML V10 Import Service and OA Content Service POST /bulk has completed successfully,
3 = FAILED: processing of XXXML V10 Import Service or OA Content Service POST /bulk has failed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.sync_status
	IS 'Status of the sync with NTG7 Tooling. Possible values:

0 = NEW: to be processed,
1 = IN_PROGRESS: processing of DOM Content Service or/and DOM UI Data Service is in progress,
2 = COMPLETED:  processing of DOM Content Service and DOM UI Data Service has completed successfully,
3 = FAILED: processing of DOM Content Service or DOM UI Data Service has failed.'
;

COMMENT ON COLUMN xxxml_v10_import.xxxml_import.fail_reason
	IS 'Optional text field to add a reason in case of an error.
Possible constants will be defined in the xxxml-import-service specification.

Example value: BA_PLATFORM_NOT_REACHABLE'
;



COMMENT ON TABLE xxxml_v10_import.sys_param
	IS 'This table is used to store the names and values of system parameters like the DB-Version, etc.'
;

COMMENT ON COLUMN xxxml_v10_import.sys_param.sys_param_id
	IS 'Internal Id. Primary key of the table.'
;

COMMENT ON COLUMN xxxml_v10_import.sys_param.par_name
	IS 'Name of the parameter.
This must be unique for all rows in the table. '
;

COMMENT ON COLUMN xxxml_v10_import.sys_param.par_value
	IS 'Value of the parameter.'
;

COMMENT ON COLUMN xxxml_v10_import.sys_param.par_description
	IS 'Description of the parameter. It should describe the meaning of the specific parameter or for what purpose the parameter is needed.'
;


INSERT INTO xxxml_v10_import.sys_param (sys_param_id, par_name, par_value, par_description)
   VALUES (-1, 'OA_IMPORT_DB_VERSION', '1.4.4', 'Version of the OA Import Database');


INSERT INTO xxxml_v10_import.sys_param (sys_param_id, par_name, par_value, par_description)
   VALUES (-2, 'OA_URI_SCHEME', 'urn', 'First part of URI for OA: scheme');
INSERT INTO xxxml_v10_import.sys_param (sys_param_id, par_name, par_value, par_description)
   VALUES (-3, 'OA_URI_AUTHORITY', 'com:mercedes-benz:oa', 'Second part of URI for OA: authority');
INSERT INTO xxxml_v10_import.sys_param (sys_param_id, par_name, par_value, par_description)
   VALUES (-4, 'OA_URI_SYSTEM_IDENTIFIER', 'system', 'Third part of URI for OA: only used for source systems and external systems, not for objects, where third part is the object type.');