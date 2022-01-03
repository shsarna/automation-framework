@RegressionAll  @Regression_Set1
@SP70_US_11820_TEST12163_test @redeployDomUIDB
Feature: Verify DOM ui data Service behavior when error occurs while requesting the PSE from BA Platform when notification about 'change' operation is received

  Scenario Outline: Verify DOM ui data Service response when SQL error(db is not available) occurs during BA Platform synchronization

    Given the 'dom-ui-data-service' is available
    And the 'BA-platform' is available
    And database 'dom-ui-data-db' contains '<test_folder>/given/dom_ui_data_db/drop_tables_dom_ui_db.sql' data

    When BA-platform publishes the notification message '<test_folder>/when/MessagesTOPublish/dom_ui_data_service/synchronized_notification.json' in the queues bind to PSE_exchange
    And wait for 60 seconds

    Then dom-ui-data-service publishes the ba sync message '<test_folder>/then/messages/ba_sync_status_message_sql_error1.json' in the queues bind to 'dom-ui-data-v1-basync_exchange'
    And dom-ui-data-service publishes the ba sync message '<test_folder>/then/messages/ba_sync_status_message_sql_error2.json' in the queues bind to 'dom-ui-data-v1-basync_exchange'
    And dom-ui-data-service publishes the ba sync message '<test_folder>/then/messages/ba_sync_status_message_sql_error3.json' in the queues bind to 'dom-ui-data-v1-basync_exchange'

    Examples:
      |test_folder                                        |
      |/testData/ba_platform_integrations_with_services   |

