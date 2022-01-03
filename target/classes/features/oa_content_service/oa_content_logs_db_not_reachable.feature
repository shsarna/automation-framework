@RegressionAll @Regression_Set1 @SP_72_US_11797 @DDIBA-12417 @DDIBA-12410
#below tag is for hooks
@redeployOaContentDb
Feature: Verify oa-content-service logs when database is not reachable during import

  Scenario Outline: Verify oa-content-service logs when database is not reachable during import

    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And database 'oa-backend-db' contains '<test_folder>/given/oa-backend-db/delete_oa_content_db_tables.sql' data
    And the deployment 'oa-content-service-tsy-integration' is restarted

    When the imports are triggered and wait for 1 imports to be successful with core status as 3 and sync status as 0
      | Superxml_foldername   | job_name   |
      | <Superxml_foldername> | <job_name> |

    And the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_db_not_reachable.json'
    And verify the logs of 'oa-content-service' are similar with file '<test_folder>/then/logs_validation/log_oa_content_service_db_not_reachable.txt'

    Examples:
      | test_folder                  | Superxml_foldername                                 | job_name                                                |
      | /testData/oa_content_service | standalone-adapter/Media_007.1_MA-CN__Premium_de_de | jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml |


