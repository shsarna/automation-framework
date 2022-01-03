#merged with oa_content_logs_importing_existing_superxml.feature

Feature: Verify oa-content-service logs for a successful import of already existing data

  Scenario Outline: Verify oa-content-service logs for a successful import of already existing data

    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the command convert is executed at standalone adaptor with argument './<Superxml_foldername>/<job_name>'
    And wait for sync status '2' and core status '2'
    And the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import.json'

    When the command convert is executed at standalone adaptor with argument './<Superxml_foldername>/<job_name>'
    And wait for sync status '2' and core status '2'

    Then oa-content-service publishes the bulk message in the queues bind to 'oa-content-v1-bulk_exchange'
    And oa-content-service publishes the query message in the queues bind to 'oa-content-v1-query_exchange'
    And the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_2.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync4.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync5.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync6.json'
    And the logs of 'oa-content-service-tsy-integration' are similar with file '<test_folder>/then/logs_validation/log_oa_content_service_existing_superxml_import.txt'

    Examples:
      | test_folder                  | Superxml_foldername                                           | job_name                                |
      | /testData/oa_content_service | standalone-adapter/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__en_gb | jobe2fcd6f09560915d0ac2a8ea7b887c96.xml |


