@RegressionAll  @Regression_Set1
@SP_67_US_10416
Feature: Verify DOM Content Service and Dom Ui Data Service  request the PSE for product specific data after every OA Core synchronization

  @DDIBA-11483 @DDIBA-11482 @Test_11482_11483
  Scenario Outline: Verify DOM Content Service and Dom Ui Data Service do not request the PSE for product specific data after every OA Core synchronization

    Given the STD file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' '<clean>'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available

    When the command convert is executed at standalone adaptor with argument './<Superxml_foldername>/<job_name>'
    And wait for sync status '2' and core status '2'

    Then dom-content-service publishes the sync message in the queues bind to 'dom-content-v1-contentsync_exchange'
    And dom-ui-data-service publishes the sync message in the queues bind to 'dom-ui-data-v1-contentsync_exchange'
   # dom_content DB validationtestData
    And the database table 'dom_content.dom_content_sync' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/dom_content_sync1.json'
    #dom_ba_sync table - No new entries should be made in ba_sync table
    And the number of entries in the database table 'dom_content.dom_ba_sync' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/dom_ba_sync-count.json'
   # domui_data_service DB validationtestData
    And the database table 'domui_data_service.content_sync' should contain a row with values in '<test_folder>/then/domui-data-db/DOMUI-content_sync.json'

    Examples:
      | test_folder                                          | Superxml_foldername                  | job_name           | clean |
      | /testData/ba_platform_integrations_with_services     | standalone-adapter/modified_superxml | modified_super.xml | true  |

#-------------------------------------*******************************---------------------------------------------------------------------------
  @DDIBA-11455 @DDIBA-11465
  Scenario Outline: Verify that dom-content-service and dom-ui-data-service requests the new or changed elements (disclaimer) from BA platform when notification about change in elements is received

    When BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange
    And wait for 60 seconds

    #dom.content Db validation
    Then dom-content-service publishes the Ba-sync message in the queues bind to 'dom-content-v1-basync_exchange'
    And dom-ui-data-service publishes the LanguageList, Identifier and Disclaimer Ba-sync messages in the queues bind to exchanges 'dom-ui-data-v1-basync_exchange'
    And the number of entries in the database table 'dom_content.element' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/element-disclaimer-count.json'
    And the database table 'dom_content.element' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/element-disclaimer.json'
    And the number of entries in the database table 'dom_content.node_validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/node_validity-count1.json'
      #domui_data_service Db validation
    And the number of entries in the database table 'domui_data_service.resource_domui_valuemapping' should be as specified in the file '<test_folder>/then/domui-data-db/resource_domui_valuemapping-count.json'
    And the number of entries in the database table 'domui_data_service.domui_valuemapping' should be as specified in the file '<test_folder>/then/domui-data-db/domui_valuemapping-count.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/resource_domui_language-count.json'
    And the number of entries in the database table 'domui_data_service.domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/domui_language-count.json'
    And the number of entries in the database table 'domui_data_service.domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/domui_language-1-count.json'
    And the number of entries in the database table 'domui_data_service.domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/domui_language-2-count.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/resource4.json'
    And the number of entries in the database table 'domui_data_service.domui_text' should be as specified in the file '<test_folder>/then/domui-data-db/domui_text-identifier-count.json'

    Examples:
      | test_folder                                        |
      | /testData/ba_platform_integrations_with_services   |