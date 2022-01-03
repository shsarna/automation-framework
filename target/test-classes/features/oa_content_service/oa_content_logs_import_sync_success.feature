@RegressionAll @Regression_Set1
@SP_72_US_11797 @DDIBA-12386 @DDIBA-12397

Feature: oa-content-service console logs after completion of successful import and sync

  Scenario Outline: oa-content-service console logs after import and sync

    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername   | job_name   |
      | <Superxml_foldername> | <job_name> |

    Then oa-content-service publishes the bulk message in the queues bind to '/testData/rabbitMqMessages/oaContentBulkMessages/import_success_message.json'
    And oa-content-service publishes the query message in the queues bind to '/testData/rabbitMqMessages/domUiOaContentQueryMessages/import_success_message.json'

    And the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync1.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync2.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync3.json'
    And validate the content of logfile in cos bucket 'ba-oacore-test-logfiles' for importId 1 has the same content as file '<test_folder>/then/cos_files/protocol_1.json'
    And the logs of 'oa-content-service' are similar with file '<test_folder>/then/logs_validation/log_oa_content_service_success.txt'

    When the imports are triggered and wait for 2 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername   | job_name   |
      | <Superxml_foldername> | <job_name> |

    Then oa-content-service publishes the bulk message in the queues bind to '/testData/rabbitMqMessages/oa_bulk_existing_import_success_message.json'
    And oa-content-service publishes the query message in the queues bind to '/testData/rabbitMqMessages/oa_query_existing_import_success_message.json'
    And the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_2.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync4.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync5.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync6.json'
    And validate the content of logfile in cos bucket 'ba-oacore-test-logfiles' for importId 2 has the same content as file '<test_folder>/then/cos_files/protocol_4.json'
    And the logs of 'oa-content-service' are similar with file '<test_folder>/then/logs_validation/log_oa_content_service_existing_superxml_import.txt'

    Examples:
      | test_folder                  | Superxml_foldername                                            | job_name                                |
      | /testData/oa_content_service | standalone-adapter/MH-DASTI-007.1_ECE_ROW_NTG7.0_Premium_de_DE | job91d26eb7270e26ce0ac27f3479c90d2e.xml |


