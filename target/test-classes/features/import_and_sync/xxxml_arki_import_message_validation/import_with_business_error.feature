@RegressionAll @SP72_US_10575_Test_12600  @DDIBA_11338 @Regression_Set1

Feature: Provide import/sync details in message pushed by XXXML Import Service

  Scenario Outline: Provide import/sync details in message pushed by XXXML Import Service (Import: business error )
    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' '<clean>'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'BA-platform' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 3 and sync status as 0
      | Superxml_foldername   | job_name   |
      | <Superxml_foldername> | <job_name> |

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_MediawithNofilename.json'
    And xxxml-import-service publishes sync message in the queues bind to 'xxxml-import-v1-arki4import_exchange'


    Examples:
      | test_folder               | Superxml_foldername                                          | job_name                                    | clean |
      | /testData/import_and_sync | standalone-adapter/Modified_MediaReferenceTestData_withError | modified_super_NoFilename_Animation-gif.xml | true  |


