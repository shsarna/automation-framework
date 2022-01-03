@RegressionAll @Regression_Set1
@SP70_US_11820_TEST12163_test  @redeployOaVeBackendDb

Feature: Verify DOM content Service behavior when error occurs while requesting the PSE from BA Platform when notification about 'change' and ''synchronised' operation is received

  Scenario Outline: Verify DOM Content Service response when SQL error occurs (db is not available) during BA Platform synchronization

    Given the 'dom-content-service' is available
    And the 'BA-platform' is available
    And database 'oa-ve-backend-db' contains '<test_folder>/given/oa-vehicle-backend-db/drop_tables_oa_vehicle_backend_db.sql' data

    When BA-platform publishes the notification message '<test_folder>/when/MessagesTOPublish/dom_content_service/<message_to_published>.json' in the queues bind to PSE_exchange
    And wait for 90 seconds

    Then dom-content-service publishes the ba sync message '<test_folder>/then/messages/dom_content_ba_sync_exchange_message_sql_error.json' in the queues bind to 'dom-content-v1-basync_exchange'

    Examples:
      |message_to_published             |test_folder|
      |disclaimer_change_notification   |/testData/ba_platform_integrations_with_services|
      |synchronized_notification        |/testData/ba_platform_integrations_with_services|

