@RegressionAll
@Regression_Set1 @SP_72_US_12256_Test_12826 @DDIBA-12826
Feature: Verify the Sync process when Information product is not provided in the bulk message of OA Content Service and data in DB is valid for information product IP_DIBA

  Background: : Verify Dom Content and DOM UI Data Service synchronizes data that is valid for information product IP_DIBA only

    Given the Superxml file 'standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE/job9a7e95024a7869740ac27f3a7e5bb76f.xml' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername                                         | job_name                                |
      | standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE | job9a7e95024a7869740ac27f3a7e5bb76f.xml |

    Then dom-content-service publishes the sync message '/testData/import_and_sync/then/message_published/dom_content_sync_ipdiba.json' in the queues bind to dom-content-contentsync_exchange
    And dom-ui-service publishes the sync message '/testData/import_and_sync/then/message_published/dom_ui_sync_ipdiba.json' in the queues bind to dom-ui-contentsync_exchange
    And xxxml-import-service publishes sync message in the queues bind to 'xxxml-import-v1-arki4import_exchange'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '/testData/import_and_sync/then/oa-vehicle-backend-db/validity-count.json'
    And the number of entries in the database table 'dom_content.element' should be as specified in the file '/testData/import_and_sync/then/oa-vehicle-backend-db/element-count.json'
    And the database table 'dom_content.dom_content_sync' should contain a row with values in '/testData/import_and_sync/then/oa-vehicle-backend-db/dom_content_sync.json'
    And the database table 'dom_content.dom_content_sync_reference' should contain a row with values in '/testData/import_and_sync/then/oa-vehicle-backend-db/dom_content_sync_reference1.json'
    And the database table 'dom_content.dom_content_sync_reference' should contain a row with values in '/testData/import_and_sync/then/oa-vehicle-backend-db/dom_content_sync_reference2.json'
    And the database table 'dom_content.dom_content_sync_reference' should contain a row with values in '/testData/import_and_sync/then/oa-vehicle-backend-db/dom_content_sync_reference3.json'
    And the database table 'domui_data_service.content_sync' should contain a row with values in '/testData/import_and_sync/then/domui-data-db/DOMUI-content_sync.json'
    And the database table 'domui_data_service.content_sync_reference' should contain a row with values in '/testData/import_and_sync/then/domui-data-db/DOMUI-content_sync_reference1.json'
    And the database table 'domui_data_service.content_sync_reference' should contain a row with values in '/testData/import_and_sync/then/domui-data-db/DOMUI-content_sync_reference2.json'
    And the database table 'domui_data_service.content_sync_reference' should contain a row with values in '/testData/import_and_sync/then/domui-data-db/DOMUI-content_sync_reference3.json'
    And the number of entries in the database table 'domui_data_service.domui_text' should be as specified in the file '/testData/import_and_sync/then/domui-data-db/domui_text-identifier-count.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_text' should be as specified in the file '/testData/import_and_sync/then/domui-data-db/resource_domui_text-count.json'
    And the number of entries in the database table 'domui_data_service.resource_menu_item' should be as specified in the file '/testData/import_and_sync/then/domui-data-db/resource_domui_menu_item-count.json'
    And the number of entries in the database table 'domui_data_service.domui_warningmessage' should be as specified in the file '/testData/import_and_sync/then/domui-data-db/domui_warningmessage-count.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_warningmessage' should be as specified in the file '/testData/import_and_sync/then/domui-data-db/resource_domui_warning-message-count.json'
    And the number of entries in the database table 'domui_data_service.n_tuple' should be as specified in the file '/testData/import_and_sync/then/domui-data-db/ip_is_ip_diba/n_tuple-count.json'
    And the number of entries in the database table 'domui_data_service.validity_n_tuple' should be as specified in the file '/testData/import_and_sync/then/domui-data-db/validity_n_tuple-count.json'
    And the number of entries in the database table 'domui_data_service.validity' should be as specified in the file '/testData/import_and_sync/then/domui-data-db/DOMUI-validity-count.json'
    And the number of entries in the database table 'domui_data_service.domui_text_key' should be as specified in the file '/testData/import_and_sync/then/domui-data-db/domui_text_key-count.json'
    And the number of entries in the database table 'domui_data_service.domui_text_type' should be as specified in the file '/testData/import_and_sync/then/domui-data-db/domui_text_type-count.json'

  Scenario Outline: Verify Dom Content and DOM UI Data Service synchronizes data when there is not information product in bulk message and data in DB is valid for information product IP_DIBA

    Given the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/given/import-db/xxxml_import_ip_diba.json'

    When the POST bulk request is made with request body '<test_folder>/when/post_request_body/oa_post_bulk_request_with_no_ip.json'
    And oa-content-service publishes the query message in the queues bind to 'oa-content-v1-query_exchange'
    And wait for 60 seconds

    Then Verify status code of bulk '202' for given request
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/validity-count.json'
    And the number of entries in the database table 'dom_content.element' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/ip_is_ip_diba/element-count.json'
    And the database table 'dom_content.dom_content_sync' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/ip_is_ip_diba/dom_content_sync.json'
    And the database table 'dom_content.dom_content_sync_reference' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/dom_content_sync_reference4.json'
    And the database table 'dom_content.dom_content_sync_reference' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/dom_content_sync_reference5.json'
    And the database table 'dom_content.dom_content_sync_reference' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/dom_content_sync_reference6.json'
    And the database table 'domui_data_service.content_sync' should contain a row with values in '<test_folder>/then/domui-data-db/ip_is_ip_diba/DOMUI-content_sync2.json'
    And the database table 'domui_data_service.content_sync_reference' should contain a row with values in '<test_folder>/then/domui-data-db/DOMUI-content_sync_reference4.json'
    And the database table 'domui_data_service.content_sync_reference' should contain a row with values in '<test_folder>/then/domui-data-db/DOMUI-content_sync_reference5.json'
    And the number of entries in the database table 'domui_data_service.domui_text' should be as specified in the file '<test_folder>/then/domui-data-db/domui_text-identifier-count.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_text' should be as specified in the file '<test_folder>/then/domui-data-db/ip_is_ip_diba/resource_domui_text-count.json'
    And the number of entries in the database table 'domui_data_service.resource_menu_item' should be as specified in the file '<test_folder>/then/domui-data-db/ip_is_ip_diba/resource_domui_menu_item-count.json'
    And the number of entries in the database table 'domui_data_service.domui_warningmessage' should be as specified in the file '<test_folder>/then/domui-data-db/domui_warningmessage-count.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_warningmessage' should be as specified in the file '<test_folder>/then/domui-data-db/ip_is_ip_diba/resource_domui_warning-message-count.json'
    And the number of entries in the database table 'domui_data_service.n_tuple' should be as specified in the file '<test_folder>/then/domui-data-db/ip_is_ip_diba/n_tuple-count.json'
    And the number of entries in the database table 'domui_data_service.validity_n_tuple' should be as specified in the file '<test_folder>/then/domui-data-db/validity_n_tuple-count.json'
    And the number of entries in the database table 'domui_data_service.validity' should be as specified in the file '<test_folder>/then/domui-data-db/DOMUI-validity-count.json'
    And the number of entries in the database table 'domui_data_service.domui_text_key' should be as specified in the file '<test_folder>/then/domui-data-db/domui_text_key-count.json'
    And the number of entries in the database table 'domui_data_service.domui_text_type' should be as specified in the file '<test_folder>/then/domui-data-db/domui_text_type-count.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/dom_content_service_logs_ip_diba_is_ip_diba.txt'
    And the logs of 'dom-ui-data-service' are similar with file '<test_folder>/then/logs_validation/dom_ui_service_logs_ip_diba_is_ip_diba.txt'


    Examples:
      | test_folder               |
      | /testData/import_and_sync |


