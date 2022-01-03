@RegressionFlashareCreation @SP65_TEST_11309 @SP74_US_12818_TEST_13011
@SP70_US_11814_TEST_12174  @SP70_US_12177_TEST_12174  @SP69_US_11757_TEST11931
@SP75_US_12931_DDIBA-10543  @SP75_US_12931_DDIBA-11343
@Regression_SP77
Feature: Verify Media files are downloaded from MediaHub/ARKI using the mediaURL in MEDIA table for flashware and Adapt DOM Content Service for OIDC changes in MediaHub

  @SP69_US_11757 @DDIBA-11936 @DDIBA-10402 @DDIBA-10557
  Scenario Outline: Verify import and sync completed successfully for NTG7.0 device model

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Prodspec-service' is available
    And the 'Masterdata Query Service' is available

    When the command convert is executed at standalone adaptor with argument './standalone-adapter/Media_007.1_MA-CN__Premium_de_de/jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml'
    And wait for sync status '2' and core status '2'
    And BA-platform publishes the notification message '<test_folder>/given/messages_to_publish/dom_content_service/disclaimer.json' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '<test_folder>/given/messages_to_publish/dom_content_service/identifier.json' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '<test_folder>/given/messages_to_publish/dom_content_service/language.json' in the queues bind to PSE_exchange

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/oa-import-db/xxxml_import.json'
    And the number of entries in the database table 'dom_content.media' should be as specified in the file '<test_folder>/then/backend_databases/oa-vehicle-backend-db/media-count.json'

    Examples:
      | test_folder                               |
      | /testData/flashware_creation/ntg7/offline |


  Scenario Outline: Verify Media files are downloaded from MediaHub/ARKI using the mediaURL in MEDIA table for flashware and Adapt DOM Content Service for OIDC changes in MediaHub

    Given the configmap 'dom-content-service-tsy-integration-configmap' has the property 'download.media.from.cos' value set to 'true' in 'application.properties'
    And the deployment 'dom-content-service-tsy-integration' is restarted
    And the 'dom-container-service' is available
    And the 'dom-validation-service' is available
    And the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And cos file 'dom-validation/dom-rulesets/ruleset.json' from bucket 'ba-oacore-test-resource-storage' has the same content as '<test_folder>/then/cos/rule-set.json'
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-media/MEDIA_PA200033_007.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__de_de.zip' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.1.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-symb/mbsymb_NTG7.0.zip' is present on bucket 'ba-ntg7-test-resource-storage'
    And database 'dom-sw-db' contains '<test_folder>/given/backend_databases/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '<test_folder>/given/backend_databases/oa_gw_insert_data.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_eStand_280.json'

    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers.txt'
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response1.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_package_creation_media_data.json' in the queues bind to 'dom-content-v1-package_exchange'
    #And dom-container-service publishes the artifacts creation message '<test_folder>/then/message_published/dom_container_queue_message.json' in the queues bind to dom-container-container_queue
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package.json'
    And the database table 'dom_content.dom_package_resource' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_resource1.json'
    And the database table 'dom_content.dom_package_resource' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_resource2.json'
    And the database table 'dom_content.dom_package_resource' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_resource3.json'
    #And the database table 'dom_container.dom_container' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/dom_container.json'
    #And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/dom_container_resource1_estand_280.json'
    #And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/dom_container_resource2_estand_280.json'
    And cos file '<package_path>/README.md' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/README.md'
    And file from path 'data/info.txt' in cos file '<package_path>/OA.zip' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/info.txt'
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath '<package_path>/DOM.zip' for ntg7 device
    And the file '2782f892b2807bf9ac190d2b3b84825a_1_-----.JPEG_DIBA55hi' on path 'media' is present in dom zip
    And the file '4fe22bb631dcf15dac190d2b2a814d07_1_-----.GIF' on path 'media' is present in dom zip
    And the file '5519.jpg' on path 'media' is present in dom zip
    And the file 'mbsymb_sys_002f.png' on path 'assets\mbsymb' is present in dom zip
    And the logs of 'dom-container-service' are similar with file '<test_folder>/then/logs_validation/log_dom_container_service.txt'
    ##And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service.txt'
    And logs of 'dom-content-service' having 2 unique trace ids


    Examples:
      | test_folder                               | package_path                     |odx-f_file                                                |dom-validation_result_path                         |
      | /testData/flashware_creation/ntg7/offline | dom-flashware/300030_3333003011  |PREFULL_NTG7_007_HU7_E280_0_DOM1_P_3333003011_300030.odx-f|dom-validation-result/300030_3333003011/result.json|
     # | /testData/flashware_creation/ntg7/online  | dom-flashware/300030_3333003012  |PREFULL_NTG7_007_HU7_E280_0_DOM1_P_3333003012_300030.odx-f|dom-validation-result/300030_3333003012/result.json|


#The same scenario is available also in ntg7_flashwares_error_scenarios.feature file
#  Scenario Outline: Verify that the flashware creation is aborted after configurable retry when any media files is missing from COS,MediaHub or ARKI.
#
#    Given database 'oa-ve-backend-db' contains '<test_folder>/given/oa-vehicle-backend-db/update_mediahub_url_from_table_media.sql' data
#
#    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data.json'
#
#    Then the response is started
#    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
#    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_package_error_wrong_media_url.json' in the queues bind to 'dom-content-v1-package_exchange'
#    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
#    #And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_media_url_error.txt'
#
#    Examples:
#      | test_folder                               |
#      | /testData/flashware_creation/ntg7/offline |






