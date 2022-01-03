@RegressionAll @Regression_Set1 @exe15Oct2021
Feature: Extract dom_deep_link-diba as additional information of a topic and Verify DOM UI Data Service provides the deeplink information in case the valuemappings are requested during FW creation

  @SP_74_US_12714_TEST @DDIBA-13010 @SP_74_US_12715 @DDIBA-13018
  Scenario Outline: XXXML Import Service extract dom_deep_link-diba as additional information of a topic and Verify DOM UI Data Service creates a valuemapping with the extracted the dom_deep-link-diba value and the topic id in DOM UI Data DB attached to a full validity set

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername                                               | job_name                                                 |
      | standalone-adapter/Deeplink_223.0_MA-ECE_ROW_NTG7.0_Premium_de_DE | job3e929e806a83978d0ac2a8ea7d90432e_UniqueDeeplinkss.xml |


    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_deeplink.json'
    And the database table 'oa_content.xml_data' should contain a row with values in '<test_folder>/then/oa-backend-db/xml_data_deeplink_description.json'
    And the database table 'oa_content.object' should contain a row with values in '<test_folder>/then/oa-backend-db/object_deeplink_description.json'
    And the database table 'oa_content.xml_data' should contain a row with values in '<test_folder>/then/oa-backend-db/xml_data_deeplink_instruction.json'
    And the database table 'oa_content.object' should contain a row with values in '<test_folder>/then/oa-backend-db/object_deeplink_instruction.json'

    And dom-ui-data-service publishes the sync message '<test_folder>/then/message_published/dom_ui_sync_deeplink.json' in the queues bind to dom-ui-data-contentsync_exchange
    And the database table 'domui_data_service.content_sync' should contain a row with values in '<test_folder>/then/domui-data-db/DOMUI-content_sync.json'
    And the database table 'domui_data_service.content_sync_reference' should contain a row with values in '<test_folder>/then/domui-data-db/DOMUI-content_sync_reference1.json'
    And the database table 'domui_data_service.content_sync_reference' should contain a row with values in '<test_folder>/then/domui-data-db/DOMUI-content_sync_reference2.json'
    And the database table 'domui_data_service.content_sync_reference' should contain a row with values in '<test_folder>/then/domui-data-db/DOMUI-content_sync_reference3.json'
    And the database table 'domui_data_service.resource_domui_valuemapping' should contain a row with values in '<test_folder>/then/domui-data-db/resoure_valuemapping_deeplink.json'
    And the database table 'domui_data_service.domui_valuemapping' should contain a row with values in '<test_folder>/then/domui-data-db/domui_valuemapping_deeplink.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_valuemapping' should be as specified in the file '<test_folder>/then/domui-data-db/resource_domui_valuemapping_deeplink_count.json'
    And the number of entries in the database table 'domui_data_service.domui_valuemapping' should be as specified in the file '<test_folder>/then/domui-data-db/domui_valuemapping_deeplink_count.json'
    And the number of entries in the database table 'domui_data_service.domui_valuemapping' should be as specified in the file '<test_folder>/then/domui-data-db/domui_valuemapping_deeplink_context-link_count.json'
    And the number of entries in the database table 'domui_data_service.v_resource_ntuple_validity' should be as specified in the file '<test_folder>/then/domui-data-db/v_resource_ntuple_validity_deeplink.json'
    And the database table 'domui_data_service.n_tuple' should contain a row with values in '<test_folder>/then/domui-data-db/domui_ntuple_deeplink.json'
    And the logs of 'dom-ui-data-service' are similar with file '<test_folder>/then/logs_validation/dom_ui_service_logs.txt'

    Examples:
      | test_folder               |
      | /testData/import_and_sync |

  @SP_74_US_12715 @DDIBA-13033
  Scenario Outline: Verify DOM UI Data Service provides the deeplink information in case the valuemappings are requested during FW creation

    Given database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_deeplink.json'
    And the response is started
    And the flashware creation is finished

    Then Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response1.txt'
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package.json'
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-flashware/<package_path>/OA.zip' for ntg7 device
    And the sql-lite database 'dom-ui-data' table 'domui_param' should contain a rows with values '<test_folder>/then/vehicle_databases/dom-ui-data-db/dom-ui-data_domui_param_deeplink.json'
    And the sql-lite database 'dom-content-data' table 'node' should contain a rows with values '<test_folder>/then/vehicle_databases/dom-content-data-db/dom-content-data_node_deeplink_topic.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicle_databases/dom-content-data-db/dom-content-data_element_deeplink_topic.json'


    Examples:
      | test_folder                               | package_path      |
      | /testData/flashware_creation/ntg7/offline | 300030_3333003019 |
#      | /testData/flashware_creation/ntg7/online  | 300030_3333003018 |


#  @SP_74_US_12715 @DDIBA-13063
#  Scenario Outline: Verify DOM UI Data Service sync fails when duplicate deeplinks are present in the superxml
#
#    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
#    And the Superxml file 'standalone-adapter/Media_007.1_MA-CN__Premium_de_de/jobab1d30dabe36158a354aeb2c2e4c9c72_duplicate_deeplinks.xml' is available at standalone adapter
#    And the 'xxxml-import-service' is available
#    And the 'oa-content-service' is available
#    And the 'dom-ui-data-service' is available
#    And the 'Masterdata Query Service' is available
#
#    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 3
#      | Superxml_foldername                                 | job_name                                                    |
#      | standalone-adapter/Media_007.1_MA-CN__Premium_de_de | jobab1d30dabe36158a354aeb2c2e4c9c72_duplicate_deeplinks.xml |
#
#
#    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_deeplink_error.json'
#
#    And dom-ui-data-service publishes the sync message '<test_folder>/then/message_published/dom_ui_sync_deeplink_error.json' in the queues bind to dom-ui-data-contentsync_exchange
#    And the database table 'domui_data_service.content_sync' should contain a row with values in '<test_folder>/then/domui-data-db/DOMUI-content_sync_failed.json'
#    And the database table 'domui_data_service.content_sync_reference' should contain a row with values in '<test_folder>/then/domui-data-db/DOMUI-content_sync_reference1.json'
#    And the database table 'domui_data_service.content_sync_reference' should contain a row with values in '<test_folder>/then/domui-data-db/DOMUI-content_sync_reference2.json'
#    And the database table 'domui_data_service.content_sync_reference' should contain a row with values in '<test_folder>/then/domui-data-db/DOMUI-content_sync_reference3.json'
#    And the number of entries in the database table 'domui_data_service.resource_domui_valuemapping' should be as specified in the file '<test_folder>/then/domui-data-db/resource_valuemapping_count_error.json'
#    And the number of entries in the database table 'domui_data_service.domui_valuemapping' should be as specified in the file '<test_folder>/then/domui-data-db/domui_valuemapping-count_error.json'
##    And the logs of 'dom-ui-data-service' are similar with file '<test_folder>/then/logs_validation/dom_ui_service_logs_duplicate_deeplink.txt'
##    And the logs of 'dom-ui-data-service' are same with file '<test_folder>/then/logs_validation/dom_ui_service_logs_duplicate_deeplink.txt'
#    And verify the logs of 'dom-ui-data-service' are similar with file '<test_folder>/then/logs_validation/dom_ui_service_logs_duplicate_deeplink.txt'
#
#    Examples:
#      | test_folder               |
#      | /testData/import_and_sync |


