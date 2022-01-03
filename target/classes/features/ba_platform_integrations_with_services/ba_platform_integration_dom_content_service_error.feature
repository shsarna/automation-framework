@RegressionAll @Regression_Set2
@SP70_US_11820_TEST11498 @DDIBA-11498 #Not to execute with all test cases
#below tag is for hooks
@revertOaVaBackendBACM


Feature: Verify DOM content Service behavior when error occurs while requesting the PSE from BA Platform

  Scenario Outline: Verify DOM content Service behavior when error occurs while requesting the PSE from BA Platform
    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'dom-content-service' is available
    And the 'BA-platform' is available
    And the configmap 'dom-content-service-tsy-integration-configmap' has the property 'ba.platform.base.path' value set to 'http://testprodspec.ba-bap:80' in 'application.properties'
    And the deployment 'dom-content-service-tsy-integration' is restarted

    When BA-platform publishes the notification message '/testData/ba_platform_integrations_with_services/when/MessagesTOPublish/dom_content_service/<message_to_published>.json' in the queues bind to PSE_exchange
    And wait for 60 seconds

    Then dom-content-service publishes the ba sync message '/testData/ba_platform_integrations_with_services/then/messages/dom_content_ba_sync_exchange_message_error.json' in the queues bind to 'dom-content-v1-basync_exchange'
    And the database table 'dom_content.dom_ba_sync' should contain a row with values in '/testData/ba_platform_integrations_with_services/then/oa-vehicle-backend-db/dom_ba_sync_error.json'


   Examples:
      |message_to_published             |
      |disclaimer_change_notification   |
      |synchronized_notification        |

