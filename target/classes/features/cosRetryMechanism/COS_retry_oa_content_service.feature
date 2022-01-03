@RegressionAll @Regression_Set1
 #below mentioned tag is for hooks.
@revertCosInstancIdInOAContent
Feature: OA content service retry mechanism when uploading of the log file to IBM COS

  @SP72_US_11797 @DDIBA-11406 @DDIBA-12690
  Scenario Outline: Verify OA content service retry mechanism when uploading of the log file to IBM COS fails
    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the configmap 'oa-content-service-tsy-integration-configmap' has the property 'cos.service.instance.id' value set to 'crn:v1:bluemix:public:cloud-object-storage:global:a/testa0bc45d6ffa644a3b517dcaa7c18e6b7:5aa05176-5ac6-4166-95e5-b6685e8776e4::' in 'application.properties'
    And the deployment 'oa-content-service-tsy-integration' is restarted

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 3
      | Superxml_foldername   | job_name   |
      | <Superxml_foldername> | <job_name> |

    Then the logs of 'oa-content-service' are same with file '<test_folder>/serviceLogs/cosNotAvailabble_oaContentServiceLogs.txt'
    And the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/import_db/oa_content_service_cos_retry.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/oa-backend-db/content_sync_upload_failed.json'
    And xxxml-import-service publishes sync message in the queues bind to 'xxxml-import-v1-arki4import_exchange'

    Examples:
      | test_folder                      | Superxml_foldername                                            | job_name                                |
      | /testData/cosRetryMechanism/then | standalone-adapter/MH-DASTI-007.1_ECE_ROW_NTG7.0_Premium_de_DE | job91d26eb7270e26ce0ac27f3479c90d2e.xml |
