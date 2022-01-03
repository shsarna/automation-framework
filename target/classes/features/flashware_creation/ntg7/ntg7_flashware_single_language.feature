@RegressionAll  @Regression_Set1
@RegressionFlashareCreation @fwCreation
Feature: Flashware creation single language

  @RunThis
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
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/oa-import-db/xxxml_import.json'
    And the number of entries in the database table 'dom_content.media' should be as specified in the file '<test_folder>/then/backend_databases/oa-vehicle-backend-db/media-count.json'

    Examples:
      | test_folder                                                              |
      | /testData/flashware_creation/ntg7/ntg7_flashware_single_language/offline |


  @SP76_US_12351_DDIBA-12174 @DDIBA-12174 @DDIBA-11309 @DDIBA-13011 @DDIBA-11936 @DDIBA-10402 @DDIBA-10557 @DDIBA-12174 @DDIBA-11931  @DDIBA-10543  @DDIBA-11343
  Scenario Outline: Verify DOM Validation Service validates topics of single SuperXML against a flashware and warning message references, titles in SQLite DB when dom-content-service publishes a FW creation success message
  #Verify Media files are downloaded from MediaHub/ARKI using the mediaURL in MEDIA table for flashware and Adapt DOM Content Service for OIDC changes in MediaHub

    Given the configmap 'dom-content-service-tsy-integration-configmap' has the property 'download.media.from.cos' value set to 'true' in 'application.properties'
    And the deployment 'dom-content-service-tsy-integration' is restarted
    And the 'dom-container-service' is available
    And the 'dom-validation-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And cos file 'dom-validation/dom-rulesets/ruleset.json' from bucket 'ba-oacore-test-resource-storage' has the same content as '<test_folder>/then/cos/rule-set.json'
    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-media/MEDIA_PA200033_007.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__de_de.zip' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.3.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-symb/mbsymb_NTG7.0.zip' is present on bucket 'ba-ntg7-test-resource-storage'


    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_eStand_280.json'
    And the response is started
    And the flashware creation is finished

    Then Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers.txt'
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response1.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_package_creation_media_data.json' in the queues bind to 'dom-content-v1-package_exchange'
    And dom-container-service publishes the artifacts creation message '<test_folder>/then/message_published/dom_container_queue_message.json' in the queues bind to dom-container-container_queue
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package.json'
    And the database table 'dom_container.dom_container' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/dom_container.json'
    And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/dom_container_resource1_estand_280.json'
    And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/dom_container_resource2_estand_280.json'
    And cos file 'dom-flashware/<package_path>/<odx-f_file>' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/ntg7_odx_dom1.odx-f'
    And cos file 'dom-flashware/<package_path>/README.md' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/README.md'
    And file from path 'data/info.txt' in cos file 'dom-flashware/<package_path>/OA.zip' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/info.txt'
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-flashware/<package_path>/DOM.zip' for ntg7 device
    And the file '2782f892b2807bf9ac190d2b3b84825a_1_-----.JPEG_DIBA55hi' on path 'media' is present in dom zip
    And the file '4fe22bb631dcf15dac190d2b2a814d07_1_-----.GIF' on path 'media' is present in dom zip
    And the file '18d58f5bd4f07a1a354ae3654d1077f9_1_-----.JPEG_DIBA55hi' on path 'media' is present in dom zip
    And the file '5519.jpg' on path 'media' is present in dom zip
    And the file 'mbsymb_sys_002f.png' on path 'assets\mbsymb' is present in dom zip
    And the logs of 'dom-container-service' are similar with file '<test_folder>/then/logs_validation/log_dom_container_service.txt'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service.txt'
    And the logs of 'dom-validation-service' are similar with file '<test_folder>/then/logs_validation/log_dom_validation_service.txt'
    And file content of cos file '<dom-validation_result_path>' from bucket 'ba-oacore-test-resource-storage' has the same content as '<test_folder>/then/cos/result.json'
    And logs of 'dom-content-service' having 2 unique trace ids

    Examples:
      | test_folder                                                              | package_path      | odx-f_file                                                 | dom-validation_result_path                          |
      | /testData/flashware_creation/ntg7/ntg7_flashware_single_language/offline | 300030_3333003011 | PREFULL_NTG7_007_HU7_E012_0_DOM1_P_3333003011_300030.odx-f | dom-validation-result/300030_3333003011/result.json |
     # | /testData/flashware_creation/ntg7/ntg7_flashware_single_language/online  | dom-flashware/300030_3333003012  |PREFULL_NTG7_007_HU7_E280_0_DOM1_P_3333003012_300030.odx-f|dom-validation-result/300030_3333003012/result.json|


  @SP78_US_13376_DDIBA-13562 @DDIBA-13562
  Scenario Outline: Verify DOM Content Service doesn't accept a retrigger for the same flashware, when a flashware creation for a given partnumber/sw version is already triggered

    Given the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And the 'dom-container-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-media/MEDIA_PA200033_007.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__de_de.zip' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.3.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-symb/mbsymb_NTG7.0.zip' is present on bucket 'ba-ntg7-test-resource-storage'
    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_eStand_280.json'
    And the response is started
    And the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_eStand_280.json'
    And Verify response status is: 'ClientErrorException'
    And the flashware creation is finished

    Then Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers.txt'
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_fw_retrigger.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_fw_retrigger.txt'

    Examples:
      | test_folder                                                              |
      | /testData/flashware_creation/ntg7/ntg7_flashware_single_language/offline |

  @RunThis
  @SP78_US_13376_DDIBA-13563 @DDIBA-13563
  Scenario Outline: Verify DOM Content Service aborts the first flashware creation and accepts the second trigger when a flashware creation for a given partnumber/sw version is exceeding the maximum set limit

    Given the configmap 'dom-content-service-tsy-integration-configmap' has the property 'fw.retrigger.wait.limit' value set to '1000' in 'application.properties'
    And the configmap 'dom-content-service-tsy-integration-configmap' has the property 'fw.retrigger.check.interval' value set to '500' in 'application.properties'
    And the deployment 'dom-content-service-tsy-integration' is restarted
    And the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And the 'dom-container-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-media/MEDIA_PA180554_223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__en_gb.zip' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.1.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-symb/mbsymb_NTG7.0.zip' is present on bucket 'ba-ntg7-test-resource-storage'

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_eStand_280_aborted.json'
    And the response is started
    And wait for 1 seconds
    And the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_eStand_280_aborted.json'
    And the response is started
    And the flashware creation is finished

    Then Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_package_creation_media_data2.json' in the queues bind to 'dom-content-v1-package_exchange'
    And dom-container-service publishes the artifacts creation message '<test_folder>/then/message_published/dom_container_queue_message_id3.json' in the queues bind to dom-container-container_queue
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_aborted.json'
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_completed.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_fw_retrigger_aborted.txt'

    Examples:
      | test_folder                                                              |
      | /testData/flashware_creation/ntg7/ntg7_flashware_single_language/offline |

  @SP77_US_13164_DDIBA-13450
  Scenario Outline: Verify that DOM UI Data Service extracts the MB symbol alongside the text as warning message title

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Prodspec-service' is available
    And the 'Masterdata Query Service' is available

    When the command convert is executed at standalone adaptor with argument './standalone-adapter/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__en_gb/jobe2fcd6f09560915d0ac2a8ea7b887c96_unique_deeplink.xml'
    And wait for sync status '2' and core status '2'
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange

    Then the number of entries in the database table 'domui_data_service.domui_text' should be as specified in the file '<test_folder>/then/backend_databases/domui_data_service/count_text_value_mbSymb_warning_msg.json'
    And the database table 'domui_data_service.domui_text' should contain a row with values in '<test_folder>/then/backend_databases/domui_data_service/text_value_mbSymb_warning_msg.json'
    And the database table 'domui_data_service.domui_text' should contain a row with values in '<test_folder>/then/backend_databases/domui_data_service/text_value_multipleMbSymb_warning_msg.json'

    Examples:
      | test_folder                                                              |
      | /testData/flashware_creation/ntg7/ntg7_flashware_single_language/offline |


  @SP77_US_13164_DDIBA-13462 @DDIBA-13462
  Scenario Outline: Verify icons alongside the text as warning message title are present in domui_text table of dom-ui-data.db of a flashware

    Given the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And the 'dom-container-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-media/MEDIA_PA180554_223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__en_gb.zip' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.1.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-symb/mbsymb_NTG7.0.zip' is present on bucket 'ba-ntg7-test-resource-storage'

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_en_gb.json'
    And the response is started
    And the flashware creation is finished

    Then Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-flashware/<package_path>/OA.zip' for ntg7 device
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicle_databases/dom-ui-data-db/count_text_value_mbSymb_warning_msg.json'
    And the sql-lite database 'dom-ui-data' table 'domui_text' should contain a rows with values '<test_folder>/then/vehicle_databases/dom-ui-data-db/text_value_mbSymb_warning_msg.json'
    And the sql-lite database 'dom-ui-data' table 'domui_text' should contain a rows with values '<test_folder>/then/vehicle_databases/dom-ui-data-db/text_value_multipleMbSymb_warning_msg.json'

    Examples:
      | test_folder                                                              | package_path      |
      | /testData/flashware_creation/ntg7/ntg7_flashware_single_language/offline | 300030_3333003011 |
      | /testData/flashware_creation/ntg7/ntg7_flashware_single_language/online  | 300030_3333003012 |


  @SP78_US_13373_DDIBA-13456 @SP77_US_13370_TEST_13458 @DDIBA-13458 @DDIBA-13456 @OIDCTest @revertOIDCCM
  Scenario Outline:Verify data provisioning during flashware creation process after OIDC is integrated in DOM UI data service

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the configmap 'dom-content-service-tsy-integration-configmap' has the property 'dom.ui.data.service.base.path' value set to 'https://ntg7.om-systems-test.cloud.corpintra.net/dom-ui-data-service/v1' in 'application.properties'
    And the deployment 'dom-content-service-tsy-integration' is restarted

    And the configmap 'dom-ui-data-service-configmap' has the property 'spring.datasource.url' value set to 'jdbc:postgresql://e1c7d4e2-3bf9-4cf5-945d-046bce53b1bf.bc28ac43cf10402584b5f01db462d330.private.databases.appdomain.cloud:32232/dom_ui_data_db-tsy-integration?ssl=true&sslmode=verify-full&sslrootcert=/etc/ssl/icd.crt' in 'application.properties'
    And the deployment 'dom-ui-data-service' is restarted

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
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange

    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.1.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_eStand_280.json'
    And the response is started
    And the flashware creation is finished

    Then the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/oidc_log_dom_content_service.txt'
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_oidc.json'
    Examples:
      | test_folder                                                              |
      | /testData/flashware_creation/ntg7/ntg7_flashware_single_language/offline |