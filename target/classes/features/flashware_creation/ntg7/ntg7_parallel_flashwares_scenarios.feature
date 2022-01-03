@RegressionAll @Regression_Set1
@parallelFlashware @RegressionFlashareCreation @DDIBA-10162
Feature: Parallel Flashware creation

  Scenario Outline: Verify parallel flashware creation for NTG7.0 device model

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Prodspec-service' is available
    And the 'Masterdata Query Service' is available
    And the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And the 'dom-container-service' is available
    And the 'dom-validation-service' is available

    When the command convert is executed at standalone adaptor with argument './standalone-adapter/Media_007.1_MA-CN__Premium_de_de/jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml'
    And wait for sync status '2' and core status '2'

    When the command convert is executed at standalone adaptor with argument './standalone-adapter/Media_007.1_MA-CN__Premium_de_de_gen20x/jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml'
    And wait for sync status '2' and core status '2'

    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange

    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.1.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_eStand_280.json'
    And the response is started
    And the POST 'packages' request is made with request body '<test_folder2>/when/post_packages_request_media_data_dom1.json'
    And the response is started

    Then the flashware creation is finished
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_package_creation_media_data.json' in the queues bind to 'dom-content-v1-package_exchange'
    And dom-content-service publishes the package creation message '<test_folder2>/then/message_published/message_package_creation_media_data2.json' in the queues bind to 'dom-content-v1-package_exchange'
  Examples:
      | test_folder                                                              |test_folder2                                |
      | /testData/flashware_creation/ntg7/ntg7_flashware_single_language/offline | /testData/flashware_creation/gen20x/offline|
