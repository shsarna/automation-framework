@RegressionAll   @Regression_Set1
@SP70_US_11820 @DDIBA-12162 @redeployOaVeBackendDb
Feature: Verify DOM content Service behavior when error occurs while requesting the PSE from BA Platform when notification about 'change' operation is received

  Scenario Outline: Verify DOM Content Service response when SQL error occurs during BA Platform synchronization
    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And database 'oa-ve-backend-db' contains '<test_folder>/given/oa-vehicle-backend-db/delete_column_element_type_from_source.sql' data
    And the 'dom-content-service' is available
    And the 'BA-platform' is available

    When BA-platform publishes the notification message '<test_folder>/when/MessagesTOPublish/dom_content_service/<message_to_published>.json' in the queues bind to PSE_exchange
    And wait for 60 seconds

    Then dom-content-service publishes the ba sync message '<test_folder>/then/messages/dom_content_ba_platform_sql_error.json' in the queues bind to 'dom-content-v1-basync_exchange'
    And the database table 'dom_content.dom_ba_sync' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/dom_ba_sync_sql_error.json'


    Examples:
      |message_to_published             |test_folder|
      |disclaimer_change_notification   |/testData/ba_platform_integrations_with_services|
      |synchronized_notification        |/testData/ba_platform_integrations_with_services|

