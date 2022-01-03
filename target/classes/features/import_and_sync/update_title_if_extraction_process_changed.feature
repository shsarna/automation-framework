@RegressionAll @Regression_Set1 @SP_70_US_11206_TEST_12131
Feature: Update titles if extraction method has changed

  Scenario Outline: Verify if the extraction method of the titles has changed, the latest title is stored in OA Backend DB and changed title is forwarded to NTG7 Tooling

    Given the STD file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' '<clean>'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'BA-platform' is available
    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername   | job_name   |
      | <Superxml_foldername> | <job_name> |
    And the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_ntg7.json'
    And the database table 'oa_content.xml_data' should contain a row with values in '<test_folder>/given/oa-backend-db/xml_data_title_media.json'
    And the database table 'dom_content.element' should contain a row with values in '<test_folder>/given/oa-vehicle-backend-db/element_title_media.json'

    When database 'oa-backend-db' contains '<test_folder>/when/oa-backend-db/update_title_xml_data_DDIBA-11206.sql' data
    And database 'oa-ve-backend-db' contains '<test_folder>/when/oa-vehicle-backend-db/update_title_element_DDIBA-11206.sql' data
    When the imports are triggered and wait for 2 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername   | job_name   |
      | <Superxml_foldername> | <job_name> |

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_ntg7_importId_2.json'
    And the database table 'oa_content.xml_data' should contain a row with values in '<test_folder>/then/oa-backend-db/xml_data_title_media.json'
    And the database table 'dom_content.element' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/element_title_media.json'

    Examples:
      | test_folder               | Superxml_foldername                                 | job_name                                                | clean |
      | /testData/import_and_sync | standalone-adapter/Media_007.1_MA-CN__Premium_de_de | jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml | true  |


