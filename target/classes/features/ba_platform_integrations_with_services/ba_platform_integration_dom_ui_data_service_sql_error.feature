@RegressionAll  @Regression_Set1 @domUIerror
@SP70_US_11820_TEST12163 @redeployDomUIDB @DDIBA-12163 @pbd
Feature: Verify DOM ui data Service behavior when error occurs while requesting the PSE from BA Platform when notification about 'synchronised' operation is received

  Scenario Outline: Verify DOM ui data Service response when SQL error occurs during BA Platform synchronization when notification about 'synchronised' operation is received

    Given database 'dom-ui-data-db' contains '<test_folder>/given/dom_ui_data_db/delete_column_id_from_source.sql' data
    And the 'dom-ui-data-service' is available
    And the 'BA-platform' is available

    When BA-platform publishes the notification message '<test_folder>/when/MessagesTOPublish/dom_ui_data_service/synchronized_notification.json' in the queues bind to PSE_exchange
    And wait for 60 seconds

    Then dom-ui-data-service publishes the ba sync message '<test_folder>/then/messages/ba_sync_status_message_domuiservice_sync_error1.json' in the queues bind to 'dom-ui-data-v1-basync_exchange'
    And dom-ui-data-service publishes the ba sync message '<test_folder>/then/messages/ba_sync_status_message_domuiservice_sync_error2.json' in the queues bind to 'dom-ui-data-v1-basync_exchange'
    And dom-ui-data-service publishes the ba sync message '<test_folder>/then/messages/ba_sync_status_message_domuiservice_sync_error3.json' in the queues bind to 'dom-ui-data-v1-basync_exchange'
    And the number of entries in the database table 'domui_data_service.ba_sync' should be as specified in the file '<test_folder>/then/domui-data-db/ba_sync_synchronized_notification_error_count.json'

    Examples:
      |test_folder                                        |
      |/testData/ba_platform_integrations_with_services   |



  Scenario Outline: Verify DOM ui data Service response when SQL error occurs during BA Platform synchronization when notification about 'change' operation is received

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And database 'dom-ui-data-db' contains '<test_folder>/given/dom_ui_data_db/delete_column_id_from_source.sql' data
    And the 'dom-ui-data-service' is available
    And the 'BA-platform' is available

    When BA-platform publishes the notification message '<test_folder>/when/MessagesTOPublish/dom_ui_data_service/<message_to_published>.json' in the queues bind to PSE_exchange
    And wait for 60 seconds

    Then dom-ui-data-service publishes the ba sync message '<test_folder>/then/messages/<ba_sync_status_message>' in the queues bind to 'dom-ui-data-v1-basync_exchange'
    And the number of entries in the database table 'domui_data_service.ba_sync' should be as specified in the file '<test_folder>/then/domui-data-db/ba_sync_change_notification_error_count.json'
    And the number of entries in the database table 'domui_data_service.resource' should be as specified in the file '<test_folder>/then/domui-data-db/resource_error-count.json'
    And database 'dom-ui-data-db' contains '<test_folder>/then/domui-data-db/add_column_id_from_source.sql' data

    Examples:
      |message_to_published             |test_folder                                     |ba_sync_status_message                              |
      |disclaimer_change_notification   |/testData/ba_platform_integrations_with_services|ba_sync_status_message_domuiservice_sync_error1.json|
      |identifier_change_notification   |/testData/ba_platform_integrations_with_services|ba_sync_status_message_domuiservice_sync_error2.json|
      |language_change_notification     |/testData/ba_platform_integrations_with_services|ba_sync_status_message_domuiservice_sync_error3.json|

