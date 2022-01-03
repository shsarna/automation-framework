@RegressionAll  @Regression_Set1
@SP70_US_11820 @DDIBA-12121 @DDIBA-12124

Feature: Verify DOM Content Service and Dom Ui Data Service  request the PSE for product specific data when notification about 'Synchronize' operation is received

  Scenario Outline: Verify DOM Content Service and Dom Ui Data Service  request the PSE for product specific data when notification about 'Synchronize' operation is received
    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'BA-platform' is available

    When BA-platform publishes the notification message '<test_folder>/when/MessagesTOPublish/dom_content_service/synchronized_notification.json' in the queues bind to PSE_exchange
    And wait for 60 seconds

    Then dom-content-service publishes the Ba-sync message in the queues bind to 'dom-content-v1-basync_exchange'
    And the database table 'dom_content.dom_ba_sync' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/dom_ba_sync.json'
    And the number of entries in the database table 'dom_content.element' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/element-disclaimer-count.json'
    And the database table 'dom_content.element' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/element-disclaimer.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/validity-count.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/validity_ntg7.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/validity_gen20x.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/validity_hu.json'
    And the number of entries in the database table 'dom_content.node' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/node_element-count.json'
    And the number of entries in the database table 'dom_content.node_validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/node_validity-count.json'
    And dom-ui-data-service publishes the LanguageList, Identifier and Disclaimer Ba-sync messages in the queues bind to exchanges 'dom-ui-data-v1-basync_exchange'
    And the database table 'domui_data_service.ba_sync' should contain a row with values in '<test_folder>/then/domui-data-db/ba_sync1.json'
    And the database table 'domui_data_service.ba_sync' should contain a row with values in '<test_folder>/then/domui-data-db/ba_sync2.json'
    And the database table 'domui_data_service.ba_sync' should contain a row with values in '<test_folder>/then/domui-data-db/ba_sync3.json'
    And the number of entries in the database table 'domui_data_service.n_tuple' should be as specified in the file '<test_folder>/then/domui-data-db/n_tuple-count.json'
    And the number of entries in the database table 'domui_data_service.n_tuple' should be as specified in the file '<test_folder>/then/domui-data-db/n_tuple-count_ntg7.json'
    And the number of entries in the database table 'domui_data_service.n_tuple' should be as specified in the file '<test_folder>/then/domui-data-db/n_tuple-count_gen20x.json'
    And the number of entries in the database table 'domui_data_service.validity' should be as specified in the file '<test_folder>/then/domui-data-db/DOMUI-validity-count.json'
    And the number of entries in the database table 'domui_data_service.validity' should be as specified in the file '<test_folder>/then/domui-data-db/DOMUI-validity_gen20x.json'
    And the number of entries in the database table 'domui_data_service.validity' should be as specified in the file '<test_folder>/then/domui-data-db/DOMUI-validity_ntg7.json'
    And the number of entries in the database table 'domui_data_service.validity' should be as specified in the file '<test_folder>/then/domui-data-db/DOMUI-validity_hu.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/resource_languageList_ntg7.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/resource_languageList_gen20x.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/resource_value_mapping_ntg7.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/resource_value_mapping_gen20x.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/resource_text_ntg7.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/resource_text_gen20x.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_valuemapping' should be as specified in the file '<test_folder>/then/domui-data-db/resource_domui_valuemapping-count.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_valuemapping' should be as specified in the file '<test_folder>/then/domui-data-db/resource_domui_valuemapping_ntg7-count.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_valuemapping' should be as specified in the file '<test_folder>/then/domui-data-db/resource_domui_valuemapping_gen20x-count.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/resource_domui_language_ntg7-count.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/resource_domui_language_gen20x-count.json'
    And the number of entries in the database table 'domui_data_service.domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/domui_language-count.json'
    And the number of entries in the database table 'domui_data_service.domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/domui_language_reading_direction1-count.json'
    And the number of entries in the database table 'domui_data_service.domui_language' should be as specified in the file '<test_folder>/then/domui-data-db/domui_language_reading_direction2-count.json'
    And the number of entries in the database table 'domui_data_service.domui_text' should be as specified in the file '<test_folder>/then/domui-data-db/domui_text-identifier-count.json'

    Examples:
      | test_folder                                       |
      | /testData/ba_platform_integrations_with_services  |


