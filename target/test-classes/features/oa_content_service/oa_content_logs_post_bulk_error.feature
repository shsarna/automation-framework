@RegressionAll @Regression_Set1 @SP_72_US_11797

@redeployOaContentDb @DDIBA-12443 @DDIBA-12414 @DDIBA-12413 @DDIBA-12412
Feature: Verify oa-content-service logs when data could not be saved to object table or xml_data or search_meta of OA Backend DB during POST bulk

  Scenario Outline: Verify oa-content-service logs when data could not be saved to object table or xml_data or search_meta of OA Backend DB during POST bulk
    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the Superxml file 'standalone-adapter/MH-DASTI-007.1_ECE_ROW_NTG7.0_Premium_de_DE/job91d26eb7270e26ce0ac27f3479c90d2e.xml' is available at standalone adapter
    And the 'xxxml-import-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And database 'oa-backend-db' contains '<test_folder>/given/oa-backend-db/<column_to_be_deleted>' data

    When the imports are triggered and wait for 1 imports to be successful with core status as 3 and sync status as 0
      | Superxml_foldername                                            | job_name                                |
      | standalone-adapter/MH-DASTI-007.1_ECE_ROW_NTG7.0_Premium_de_DE | job91d26eb7270e26ce0ac27f3479c90d2e.xml |

    Then oa-content-service publishes the bulk message in the queues bind to '/testData/rabbitMqMessages/oaContentBulkMessages/sql_error_message.json'
    And the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_OAContent_SQLError.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync_sql_error.json'
    And validate the content of logfile in cos bucket 'ba-oacore-test-logfiles' for importId 1 has the same content as file '<test_folder>/then/cos_files/protocol_post_bulk_failed.json'
    And wait for 40 seconds
    And the logs of 'oa-content-service' are similar with file '<test_folder>/then/logs_validation/log_oa_content_service_sql_error.txt'

    Examples:
      | test_folder                  | column_to_be_deleted                    | table_column_not_exist                         |
      | /testData/oa_content_service | delete_column_object_id_from_source.sql | log_oa_content_service_object_table_error      |
      | /testData/oa_content_service | delete_column_data_id_from_source.sql   | log_oa_content_service_xml_data_table_error    |
      | /testData/oa_content_service | delete_column_search_meta_id.sql        | log_oa_content_service_search_meta_table_error |
