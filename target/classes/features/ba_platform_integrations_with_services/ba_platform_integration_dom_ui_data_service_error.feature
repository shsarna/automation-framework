@RegressionAll @Regression_Set2 @domUIerror
@DDIBA-11499 @SP70_US_11820_TEST11499 @revertDomUiBACM
#Not to execute with all test cases

Feature: Verify DOM ui data Service behavior when error occurs while requesting the PSE from BA Platform when notification about 'change' operation is received

  Scenario Outline: Verify DOM ui data Service behavior when error occurs while requesting the PSE from BA Platform
    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'BA-platform' is available
    And the configmap 'dom-ui-data-service-tsy-integration-configmap' has the property 'ba.prod.base.path' value set to 'http://testprodspec.ba-bap:80' in 'application.properties'
    And the deployment 'dom-ui-data-service-tsy-integration' is restarted
    And the 'dom-ui-data-service' is available

    When BA-platform publishes the notification message '<test_folder>/when/MessagesTOPublish/dom_ui_data_service/<message_to_published>.json' in the queues bind to PSE_exchange
    And wait for 60 seconds

    Then dom-ui-data-service publishes the ba sync message '<test_folder>/then/messages/<ba_sync_status_message>' in the queues bind to 'dom-ui-data-v1-basync_exchange'
    And the number of entries in the database table 'domui_data_service.ba_sync' should be as specified in the file '<test_folder>/then/domui-data-db/ba_sync_change_notification_error_count1.json'

    Examples:
    |message_to_published             |test_folder                                     |ba_sync_status_message                              |
    |disclaimer_change_notification   |/testData/ba_platform_integrations_with_services|ba_sync_status_message_domuiservice_sync_error1.json|
    |identifier_change_notification   |/testData/ba_platform_integrations_with_services|ba_sync_status_message_domuiservice_sync_error2.json|
    |language_change_notification     |/testData/ba_platform_integrations_with_services|ba_sync_status_message_domuiservice_sync_error3.json|




  Scenario Outline: Verify DOM ui data Service behavior when error occurs while requesting the PSE from BA Platform when notification about 'Synchronize' operation is received
    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'BA-platform' is available
    And the configmap 'dom-ui-data-service-tsy-integration-configmap' has the property 'ba.prod.base.path' value set to 'http://testprodspec.ba-bap:80' in 'application.properties'
    And the deployment 'dom-ui-data-service-tsy-integration' is restarted

    When BA-platform publishes the notification message '<test_folder>/when/MessagesTOPublish/dom_ui_data_service/synchronized_notification.json' in the queues bind to PSE_exchange
    And wait for 60 seconds

    Then dom-ui-data-service publishes the ba sync message '<test_folder>/then/messages/ba_sync_status_message_domuicm_sync_error.json' in the queues bind to 'dom-ui-data-v1-basync_exchange'
    And the number of entries in the database table 'domui_data_service.ba_sync' should be as specified in the file '<test_folder>/then/domui-data-db/ba_sync_synchronized_notification_error_count.json'

    Examples:
      |test_folder                                        |
      |/testData/ba_platform_integrations_with_services   |


