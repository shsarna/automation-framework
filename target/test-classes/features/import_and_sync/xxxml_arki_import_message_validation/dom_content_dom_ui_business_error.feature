@RegressionAll
@Regression_Set1 @SP72_US_10575
Feature: Provide import/sync details in message pushed by XXXML Import Service

  @redeployOaVeBackendDb @redeployDomUIDB @DDIBA-12609
  Scenario Outline: Provide import/sync details in message pushed by XXXML Import Service (Import: success , dom content synchronization: business error and dom ui synchronization :business error)

    Given the Superxml file 'standalone-adapter/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__en_gb/jobe2fcd6f09560915d0ac2a8ea7b887c96_unique_deeplink.xml' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the sql file '<test_folder>/given/oa-vehicle-backend-db/delete_column_data_id_from_source.sql' will be executed on database 'oa-ve-backend-db'
    And the sql file '<test_folder>/given/domui-data-db/delete_column_id_from_source.sql' will be executed on database 'dom-ui-data-db'

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 3
      | Superxml_foldername                                 | job_name                                                |
      | standalone-adapter/Media_007.1_MA-CN__Premium_de_de | jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml |

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_dom_content_business_error_dom_ui_business_error.json'
    And the database table 'xxxml_v10_import.oa_resource' should contain a row with values in '<test_folder>/then/import-db/oa_resource1.json'
    And the database table 'xxxml_v10_import.oa_resource' should contain a row with values in '<test_folder>/then/import-db/oa_resource2.json'
    And the database table 'xxxml_v10_import.oa_resource' should contain a row with values in '<test_folder>/then/import-db/oa_resource3.json'
    And xxxml-import-service publishes sync message in the queues bind to 'xxxml-import-v1-arki4import_exchange'

    Examples:
      | test_folder               |
      | /testData/import_and_sync |

