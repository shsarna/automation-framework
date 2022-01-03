@RegressionAll   @Regression_Set1 @realstdchange
@SP67_TEST11455_TEST11465 @DDIBA-11465 @DDIBA-11455

Feature: Verify DOM Content Service and Dom Ui Data Service  request the PSE for product specific data after every OA Core synchronization

  Scenario Outline: Verify that dom-content-service requests the new or changed elements (disclaimer) from BA platform when notification about change in elements is received
    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the 'BA-platform' is available

    When the command convert is executed at standalone adaptor with argument './standalone-adapter/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__en_gb/jobe2fcd6f09560915d0ac2a8ea7b887c96.xml '
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange
    And wait for 60 seconds

    And dom-content-service publishes the Ba-sync message in the queues bind to 'dom-content-v1-basync_exchange'

    Then the database table 'dom_content.dom_ba_sync' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/dom_ba_sync.json'
    And dom-ui-data-service publishes the LanguageList, Identifier and Disclaimer Ba-sync messages in the queues bind to exchanges 'dom-ui-data-v1-basync_exchange'
    And the number of entries in the database table 'dom_content.element' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/element-disclaimer-count.json'
    And the database table 'dom_content.element' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/element-disclaimer.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/validity-count.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/validity4.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/validity8.json'
    And the number of entries in the database table 'dom_content.node' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/node_element-count.json'
    And the number of entries in the database table 'dom_content.node_validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/node_validity-count.json'
    And the database table 'domui_data_service.ba_sync' should contain a row with values in '<test_folder>/then/domui-data-db/ba_sync1.json'
    And the database table 'domui_data_service.ba_sync' should contain a row with values in '<test_folder>/then/domui-data-db/ba_sync2.json'
    And the database table 'domui_data_service.ba_sync' should contain a row with values in '<test_folder>/then/domui-data-db/ba_sync3.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_valuemapping' should be as specified in the file '<test_folder>/then/domui-data-db/resource_domui_valuemapping-count.json'
    And the number of entries in the database table 'domui_data_service.domui_valuemapping' should be as specified in the file '<test_folder>/then/domui-data-db/domui_valuemapping-count.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/resource_domui_language-count.json'
    And the number of entries in the database table 'domui_data_service.domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/domui_language-count.json'
    And the number of entries in the database table 'domui_data_service.domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/domui_language-1-count.json'
    And the number of entries in the database table 'domui_data_service.domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/domui_language-2-count.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/resource4.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/resource6.json'
    And the number of entries in the database table 'domui_data_service.domui_text' should be as specified in the file '<test_folder>/then/domui-data-db/domui_text-identifier-count.json'

    Examples:
      | test_folder                                       |
      | /testData/ba_platform_integrations_with_services  |