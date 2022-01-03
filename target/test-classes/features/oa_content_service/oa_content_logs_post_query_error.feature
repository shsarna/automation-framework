@RegressionAll @Regression_Set1

@redeployOaContentDb @SP_71_US_11797 @DDIBA-12444 @DDIBA-12515
Feature: Verify oa-content-service logs when SQL error occurs while saving data in OA Backend DB during POST query - DOM Content or Dom Ui

  Scenario Outline: Verify oa-content-service logs when SQL error occurs while saving data in OA Backend DB during POST query - DOM Content or Dom Ui

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername                                            | job_name                                |
      | standalone-adapter/MH-DASTI-007.1_ECE_ROW_NTG7.0_Premium_de_DE | job91d26eb7270e26ce0ac27f3479c90d2e.xml |
    And database 'oa-backend-db' contains '<test_folder>/given/oa-backend-db/delete_column_object_id_from_source.sql' data
    And the POST query request is made with request body '<test_folder>/when/post_request/oa_query_request.json' for '<routing-key>'

    Then Verify status code '202' for given request
    And Verify response json with content '<test_folder>/then/json_response/oa_query_response.json'
    And wait for 30 seconds
    And oa-content-service publishes the bulk message in the queues bind to '/testData/rabbitMqMessages/<oa_query_message_sql_error>'
    And the logs of 'oa-content-service' are similar with file '<test_folder>/then/logs_validation/log_oa_content_service_post_query_error.txt'

    Examples:
      | test_folder                  | routing-key         | oa_query_message_sql_error                        |
#      | /testData/oa_content_service | dom-content | domContentOaContentQueryMessages/sql_error_message.json |
      | /testData/oa_content_service | dom-ui-data-service | domUiOaContentQueryMessages/post_query_error.json |