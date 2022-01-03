@RegressionAll @Regression_Set2
@DDIBA-13339 @SP76_US_13339
Feature: Externalize request log in DOM UI DB

  @DDIBA-13361 @SP76_US_13339_TEST_13361
  Scenario Outline: Verify the json files for dom ui sync are uploaded to COS at reference locations present at request_log table of dom UI data db

    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available

    When the command convert is executed at standalone adaptor with argument './<Superxml_foldername>/<job_name>'
    And wait for sync status '2' and core status '2'

    Then the database table 'domui_data_service.content_sync' should contain a row with values in '<test_folder>/then/dom_ui_db/dom_ui_content_sync.json'
    And the database table 'domui_data_service.request_log' should contain a row with values in '<test_folder>/then/dom_ui_db/dom_ui_request_content.json'
    And the database table 'domui_data_service.request_log' should contain a row with values in '<test_folder>/then/dom_ui_db/dom_ui_response_content.json'
    And file content of cos file 'dom-ui-data-service/request_log/1/1_message_content.json' from bucket 'ba-ntg7-test-protocolling' has the same content as '<test_folder>/then/cos_files/request_message_content.json'
    And file content of cos file 'dom-ui-data-service/request_log/1/1_request_content.json' from bucket 'ba-ntg7-test-protocolling' has the same content as '<test_folder>/then/cos_files/request_content.json'
    And file content of cos file 'dom-ui-data-service/request_log/2/2_response_content.json' from bucket 'ba-ntg7-test-protocolling' has the same content as '<test_folder>/then/cos_files/response_content.json'
    And file content of cos file 'dom-ui-data-service/request_log/2/2_message_content.json' from bucket 'ba-ntg7-test-protocolling' has the same content as '<test_folder>/then/cos_files/response_message_content.json'
    And dom-ui-service publishes the sync message '<test_folder>/then/message/dom_ui_data_success.json' in the queues bind to dom-ui-contentsync_exchange
    And the logs of 'dom-ui-data-service' are similar with file '<test_folder>/then/logs_validation/log_dom_ui_data_service_success.txt'

    Examples:
      | test_folder                        |Superxml_foldername                                             | job_name                                |
      | /testData/dom_ui_data_service      | standalone-adapter/MH-DASTI-007.1_ECE_ROW_NTG7.0_Premium_de_DE | job91d26eb7270e26ce0ac27f3479c90d2e.xml |


  @DDIBA-13371 @SP76_US_13339_TEST_13371 @revertDomUICosChange
  Scenario Outline: Verify Dom UI Data service retry mechanism when uploading of the JSON files to IBM COS fails
    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the configmap 'dom-ui-data-service-tsy-integration-configmap' has the property 'cos.service.instance.id' value set to 'crn:v1:bluemix:public:cloud-object-storage:global:a/testa0bc45d6ffa644a3b517dcaa7c18e6b7:8f07bf19-9b73-4595-95c5-5537b8ce8e73::' in 'application.properties'
    And the deployment 'dom-ui-data-service-tsy-integration' is restarted

    When the command convert is executed at standalone adaptor with argument './<Superxml_foldername>/<job_name>'
    And wait for sync status '2' and core status '2'

    Then the database table 'domui_data_service.content_sync' should contain a row with values in '<test_folder>/then/dom_ui_db/dom_ui_content_sync_cos_upload_fail.json'
    And the database table 'domui_data_service.request_log' should contain a row with values in '<test_folder>/then/dom_ui_db/dom_ui_request_content_cos_upload_fail.json'
    And the database table 'domui_data_service.request_log' should contain a row with values in '<test_folder>/then/dom_ui_db/dom_ui_response_content_cos_upload_fail.json'
    And dom-ui-service publishes the sync message '<test_folder>/then/message/dom_ui_data_success.json' in the queues bind to dom-ui-contentsync_exchange
    And the logs of 'dom-ui-data-service' are similar with file '<test_folder>/then/logs_validation/log_dom_ui_data_service_cos_retry_and_error.txt'
       Examples:
      | test_folder                    | Superxml_foldername                                                 | job_name                                |
      | /testData/dom_ui_data_service  | standalone-adapter/MH-DASTI-007.1_ECE_ROW_NTG7.0_Premium_de_DE      | job91d26eb7270e26ce0ac27f3479c90d2e.xml |



