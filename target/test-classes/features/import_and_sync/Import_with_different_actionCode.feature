@RegressionAll
#If the POST /arki-cms-imports endpoint of XXXML Import Service is called with the action code "publish", XXXML Import Service imports data as usual.
@Regression_Set1
Feature: Import and sync with different action code

  @SP75_US_12865 @DDIBA-13179
  Scenario Outline: Verify xxxml import service imports data correctly when publish code is sent in the post request (arki-cms-imports)

    Given the Superxml file 'standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE/job9a7e95024a7869740ac27f3a7e5bb76f.xml' is available at standalone adapter
    And properties file 'batch.properties' from '/standalone-adapter/data/configuration' should be updated with propertyName 'BATCH_ACTION_CODE' and value 'publish'
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the 'BA-platform' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername                                         | job_name                                |
      | standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE | job9a7e95024a7869740ac27f3a7e5bb76f.xml |

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_DASTI_DE_xml.json'
    And xxxml-import-service publishes sync message in the queues bind to 'xxxml-import-v1-arki4import_exchange'

    Examples:
      | test_folder               |
      | /testData/import_and_sync |


  @SP75_US_12865 @DDIBA-13174 @revertStandaloneConfig
 #If the POST /arki-cms-imports endpoint of XXXML Import Service is called with the action code "preview",
 # XXXML Import Service doesn't start the import, but logs the text "Service was called with action code "preview". ARKI DOM Preview is currently not supported.".

  Scenario Outline: Verify xxxml import service doesn't import anything when preview code is sent in the post request (arki-cms-imports)

    Given the Superxml file 'standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE/job9a7e95024a7869740ac27f3a7e5bb76f.xml' is available at standalone adapter
    And properties file 'batch.properties' from '/standalone-adapter/data/configuration' should be updated with propertyName 'BATCH_ACTION_CODE' and value 'preview'
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available

    When the command convert is executed at standalone adaptor with argument 'standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE/job9a7e95024a7869740ac27f3a7e5bb76f.xml'

    Then the logs of 'xxxml-import-service' are similar with file '<test_folder>/then/action_code/log/xxxml-import-service.txt'
    And the number of entries in the database table 'xxxml_v10_import.xxxml_import' should be as specified in the file '<test_folder>/then/action_code/xxxml_import_count.json'

    Examples:
      | test_folder               |
      | /testData/import_and_sync |