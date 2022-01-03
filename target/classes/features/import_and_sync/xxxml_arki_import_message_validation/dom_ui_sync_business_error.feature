@RegressionAll @SP72_US_10575_Test_12614 @Regression_Set1
Feature: Provide import/sync details in message pushed by XXXML Import Service

  @redeployDomUIDB
  Scenario Outline: Provide import/sync details in message pushed by XXXML Import Service (Import: success , dom content synchronization: success and dom ui synchronization :business error)

    Given the Superxml file 'standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE/job9a7e95024a7869740ac27f3a7e5bb76f.xml' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the sql file '<test_folder>/given/domui-data-db/delete_column_id_from_source.sql' will be executed on database 'dom-ui-data-db'

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 3
      | Superxml_foldername                                         | job_name                                |
      | standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE | job9a7e95024a7869740ac27f3a7e5bb76f.xml |


    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_dom_ui_business_error.json'
    And the database table 'xxxml_v10_import.oa_resource' should contain a row with values in '<test_folder>/then/import-db/oa_resource1.json'
    And the database table 'xxxml_v10_import.oa_resource' should contain a row with values in '<test_folder>/then/import-db/oa_resource2.json'
    And the database table 'xxxml_v10_import.oa_resource' should contain a row with values in '<test_folder>/then/import-db/oa_resource3.json'
    And xxxml-import-service publishes sync message in the queues bind to 'xxxml-import-v1-arki4import_exchange'

    Examples:
      | test_folder               |
      | /testData/import_and_sync  |

