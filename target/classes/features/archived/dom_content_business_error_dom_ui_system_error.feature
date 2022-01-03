@SP72_US_10575_Test_12611
Feature: Provide import/sync details in message pushed by XXXML Import Service

  @redeployOaVeBackendDb @redeployDomUIDB
  Scenario Outline: Provide import/sync details in message pushed by XXXML Import Service (Import: success , dom content synchronization: business error and dom ui synchronization :system error)

    Given the Superxml file 'standalone-adapter/MH-DASTI-007.1_ECE_ROW_NTG7.0_Premium_de_DE/job91d26eb7270e26ce0ac27f3479c90d2e.xml' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the sql file '<test_folder>/given/oa-vehicle-backend-db/delete_column_data_id_from_source.sql' will be executed on database 'oa-ve-backend-db'
    And the sql file '<test_folder>/given/domui-data-db/drop_tables_dom_ui_db.sql' will be executed on database 'dom-ui-data-db'

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 0
      | Superxml_foldername                                            | job_name                                |
      | standalone-adapter/MH-DASTI-007.1_ECE_ROW_NTG7.0_Premium_de_DE | job91d26eb7270e26ce0ac27f3479c90d2e.xml |

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_dom_content_business_error_dom_ui_system_error.json'
    And the database table 'xxxml_v10_import.oa_resource' should contain a row with values in '<test_folder>/then/import-db/oa_resource1.json'
    And the database table 'xxxml_v10_import.oa_resource' should contain a row with values in '<test_folder>/then/import-db/oa_resource2.json'
    And xxxml-import-service publishes sync message in the queues bind to 'xxxml-import-v1-arki4import_exchange'

    Examples:
      | test_folder               |
      | /testData/import_and_sync |

