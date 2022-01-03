@RegressionAll @Regression_Set1

Feature: XXXML import service retry mechanism when uploading of the SuperXML and konverter.xml to IBM COS

     #beloe mentioned tag is for hooks.
  @CosRetry @revertCosInstancIdInXxxml
    @DDIBA-11405
  Scenario Outline: Verify XXXML import service retry mechanism when uploading of the SuperXML and konverter.xml to IBM COS fails

    Given the 'BA-platform' is available
    And the 'xxxml-import-service' is available
    And the configmap 'xxxml-import-service-tsy-integration-configmap' has the property 'cos.service.instance.id' value set to 'crn:v1:bluemix:public:cloud-object-storage-TEST:global:a/a0bc45d6ffa644a3b517dcaa7c18e6b7:5aa05176-5ac6-4166-95e5-b6685e8776e4::' in 'application.properties'
    And the deployment 'xxxml-import-service-tsy-integration' is restarted
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And all the STD files are available at standalone adapter
      | Superxml_foldername | job_name |
      | <Superxml>          | <job>    |

    When the imports are triggered and wait for 1 imports to be successful with core status as 3 and sync status as 0
      | Superxml_foldername | job_name |
      | <Superxml>          | <job>    |

    Then the database table 'xxxml_v10_import.xxxml_import' should contain all the rows
      | <test_folder>/import_db/xxxml_import_Service_cos_retry.json |
    And the logs of 'xxxml-import-service' are same with file '<test_folder>/serviceLogs/cosNotAvailabble_xxxmlServiceLogs.txt'


    Examples:
      | Superxml                                                       | job                                     | test_folder                      |
      | standalone-adapter/MH-DASTI-007.1_ECE_ROW_NTG7.0_Premium_de_DE | job91d26eb7270e26ce0ac27f3479c90d2e.xml | /testData/cosRetryMechanism/then |
