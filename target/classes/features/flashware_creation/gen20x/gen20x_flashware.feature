@RegressionAll @Regression_Set1
@RegressionFlashareCreation @SP69_TEST_DDIBA-11984
@SP65_TEST_11309  @DDIBA-11918

Feature: Creation of Gen20x Flashware with specific folder structure, upload to SWF Artifactory , dom validation for gen20x flashware

  @execute11952
  Scenario Outline: Verify import and sync completed successfully for gen20x device model

    Given the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the 'Prodspec-service' is available
    And all the STD files are available at standalone adapter
      | Superxml_foldername                                        | job_name                                                |
      | standalone-adapter/Media_007.1_MA-CN__Premium_de_de_gen20x | jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml |
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'

    When the command convert is executed at standalone adaptor with argument './standalone-adapter/Media_007.1_MA-CN__Premium_de_de_gen20x/jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml'
    And wait for sync status '2' and core status '2'
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/oa-import-db/xxxml_import.json'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |

  @DDIBA-11984 @DDIBA-11917 @SP74_US_12938 @DDIBA-11939  @SP74_US_12818 @DDIBA-13008 @DDIBA-11309 @DDIBA-11000 @SP73_US_12704 @DDIBA-11917
  Scenario Outline: Verify creation of Gen20x package, DOM Content Service to use a specified folder structure when creating the zip-file for Gen20x, and DOM Container Service publishes Gen20x artifacts to Artifactory and Verify DOM Validation Service validates multiple SuperXMLs against a flashware when dom-content-service publishes a FW creation success message

    Given the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And the 'dom-container-service' is available
    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-media/MEDIA_PA200033_007.1_CN_MA-CN_HU-CN_GEN20X_PREMIUM__de_de.zip' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.3.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-symb/mbsymb_GEN20X.zip' is present on bucket 'ba-ntg7-test-resource-storage'

    When the POST 'packages' request is made with request body '<test_folder>/when/<post_packages_request>'
    And the response is started
    And the flashware creation is finished

    Then Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/<dom_content_headers>'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/<dom_package_creation_message>' in the queues bind to 'dom-content-v1-package_exchange'
    And dom-container-service publishes the artifacts creation message '<test_folder>/then/message_published/<dom_container_artifacts_creation_message>' in the queues bind to dom-container-container_queue
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/<dom_type>/dom_package.json'
    And the database table 'dom_content.dom_package_resource' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/<dom_type>/dom_package_resource1.json'
    And the database table 'dom_container.dom_container' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/<dom_container>.json'
    And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/<dom_container_resource_cos_odx>.json'
    And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/<dom_container_resource_odx>.json'
    And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/<dom_container_resource_dom>.json'
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-flashware/<packagepath>/DOM.zip'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_node-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_node_element-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_onlyLanguageDe_element-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-at-a-glance-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-description-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disclaimer-count.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disclaimer.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disp-diagnoses-count.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disp-diagnoses-longmessage.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disp-diagnoses-shortmessage.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-instruction-count.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-normalTopic.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-quickstart-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-warn-controls-count.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-warn-controls.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element_keyword-count.json'
    And the sql-lite database 'dom-content-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_sys_param.json'
    And the sql-lite database 'dom-ui-data' table 'domui_validity' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_validity1.json'
    And the sql-lite database 'dom-ui-data' table 'domui_validity' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_validity2.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_text-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_message_ref-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_menu_item-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_lang-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_lang2-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_lang1-count.json'
    And the sql-lite database 'dom-ui-data' table 'domui_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_param_deeplink.json'
    And the sql-lite database 'dom-ui-data' table 'domui_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_param_disclaimer.json'
    And the sql-lite database 'oa-client-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-client-data-db/oa-client-data_sys_param.json'
    And the number of entries in the sql-lite database 'oa-system-data' should be as specified in file '<test_folder>/then/vehicleDatabases/oa-system-data-db/media_data/oa-system-data_sys_param-count.json'
    And the sql-lite database 'oa-system-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-system-data-db/media_data/oa-system-data_sys_param_DB_version.json'
    And the sql-lite database 'oa-system-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-system-data-db/media_data/oa-system-data_sys_param_online_package.json'
    And verify that dom zip contains the folder or file 'ui/mbsymb'
    And verify that dom zip contains the folder or file 'ui/media'
    And verify that dom zip contains the folder or file 'oa-gw/logic'
    And verify that dom zip contains the folder or file 'oa-gw/data'
    And the file 'mbsymb_sys_0030.png' on path 'ui/mbsymb' is present in dom zip
    And the file '00a8e25766ce9a8aac190d2b70b57719_1_-----.JPEG_DIBA55hi' on path 'ui/media' is present in dom zip
    And the file '2b9c0a937642c7ec354ae3654f2e6e60_1_-----.GIF' on path 'ui/media' is present in dom zip
    And cos file 'dom-flashware/<packagepath>/<odx_file>' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/<odx_file>'
    And file from path 'README.md' in cos file 'dom-flashware/<packagepath>/DOM.zip' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/<README>.md'
    And file from path 'oa-gw/data/info.txt' in cos file 'dom-flashware/<packagepath>/DOM.zip' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/info.txt'
    And Verify 'dom-flashware/<packagepath>/<odx_file>' artifact are present in artifactory
    And Verify 'dom-flashware/<packagepath>/DOM.zip' artifact are present in artifactory
    And the logs of 'dom-container-service' are similar with file '<test_folder>/then/logs_validation/log_dom_container_service.txt'
#    And the logs of 'dom-ui-data-service' are similar with file '<test_folder>/then/logs_validation/oidclog_dom_ui_data_service_success.txt'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service.txt'
#    And logs of 'dom-content-service' having 2 unique trace ids
    #below step need to be added when dom validation will implement for Gen20x
#    And the logs of 'dom-validation-service' are similar with file '<test_folder>/then/logs_validation/log_dom_validation_service.txt'
    #And file content of cos file '<dom-validation_result_path>' from bucket 'ba-oacore-test-resource-storage' has the same content as '<test_folder>/then/cos/result.json'


    Examples:
      | test_folder                                 | packagepath       | post_packages_request                      | dom_package_creation_message              | dom_type | odx_file                                                          | dom_container_resource_odx  | dom_container_artifacts_creation_message | dom_container  | dom_container_resource_dom  | dom_container_resource_cos_odx  | dom_content_headers                 | README  | bin_file          |
      | /testData/flashware_creation/gen20x/offline | 300030_3333003011 | post_packages_request_media_data_dom1.json | message_package_creation_media_data1.json | dom1     | PREFULL_GEN20X_007_CIVIC206_E012_0_DOM1_P_3333003011_300030.odx-f | dom_container_resource_odx1 | dom_container_queue_message1.json        | dom_container1 | dom_container_resource_dom1 | dom_container_resource_cos_odx1 | dom_content_headers_package_id1.txt | README1 | 3333003011_300030 |
      | /testData/flashware_creation/gen20x/offline | 300030_3333003012 | post_packages_request_media_data_dom2.json | message_package_creation_media_data2.json | dom2     | PREFULL_GEN20X_007_CIVIC206_E012_0_DOM2_P_3333003012_300030.odx-f | dom_container_resource_odx2 | dom_container_queue_message2.json        | dom_container2 | dom_container_resource_dom2 | dom_container_resource_cos_odx2 | dom_content_headers_package_id2.txt | README2 | 3333003012_300030 |
      | /testData/flashware_creation/gen20x/offline | 300030_3333003013 | post_packages_request_media_data_dom3.json | message_package_creation_media_data3.json | dom3     | FULL_GEN20X_007_CIVIC206_E012_0_DOM3_P_3333003013_300030.odx-f    | dom_container_resource_odx3 | dom_container_queue_message3.json        | dom_container3 | dom_container_resource_dom3 | dom_container_resource_cos_odx3 | dom_content_headers_package_id3.txt | README3 | 3333003013_300030 |


  Scenario Outline: Verify creation of Gen20x package, DOM Content Service to use a specified folder structure when creating the zip-file for Gen20x, and DOM Container Service publishes Gen20x artifacts to Artifactory and Verify DOM Validation Service validates multiple SuperXMLs against a flashware when dom-content-service publishes a FW creation success message

    Given the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And the 'dom-container-service' is available
    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-media/MEDIA_PA200033_007.1_CN_MA-CN_HU-CN_GEN20X_PREMIUM__de_de.zip' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.3.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-symb/mbsymb_GEN20X.zip' is present on bucket 'ba-ntg7-test-resource-storage'

    When the POST 'packages' request is made with request body '<test_folder>/when/<post_packages_request>'
    And the response is started
    And the flashware creation is finished

    Then Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/<dom_content_headers>'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/<dom_package_creation_message>' in the queues bind to 'dom-content-v1-package_exchange'
    And dom-container-service publishes the artifacts creation message '<test_folder>/then/message_published/<dom_container_artifacts_creation_message>' in the queues bind to dom-container-container_queue
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/<dom_type>/dom_package.json'
    And the database table 'dom_content.dom_package_resource' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/<dom_type>/dom_package_resource1.json'
    And the database table 'dom_container.dom_container' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/<dom_container>.json'
    And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/<dom_container_resource_cos_odx>.json'
    And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/<dom_container_resource_odx>.json'
    And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/<dom_container_resource_dom>.json'
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-flashware/<packagepath>/DOM.zip'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_node-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_node_element-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_element-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_onlyLanguageDe_element-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_element-at-a-glance-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_element-description-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_element-disclaimer-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_element-disp-diagnoses-count.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_element-disp-diagnoses-longmessage.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_element-disp-diagnoses-shortmessage.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_element-instruction-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_element-quickstart-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_element-warn-controls-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_element_keyword-count.json'
    And the sql-lite database 'dom-content-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/media_data/dom-content-data_sys_param.json'
    And the sql-lite database 'dom-ui-data' table 'domui_validity' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_validity1.json'
    And the sql-lite database 'dom-ui-data' table 'domui_validity' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_validity2.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_text-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_message_ref-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_menu_item-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_lang-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_lang2-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_lang1-count.json'
    And the sql-lite database 'dom-ui-data' table 'domui_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_param_deeplink.json'
    And the sql-lite database 'dom-ui-data' table 'domui_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/media_data/dom-ui-data_domui_param_disclaimer.json'
    And the sql-lite database 'oa-client-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-client-data-db/oa-client-data_sys_param.json'
    And the number of entries in the sql-lite database 'oa-system-data' should be as specified in file '<test_folder>/then/vehicleDatabases/oa-system-data-db/media_data/oa-system-data_sys_param-count.json'
    And the sql-lite database 'oa-system-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-system-data-db/media_data/oa-system-data_sys_param_DB_version.json'
    And the sql-lite database 'oa-system-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-system-data-db/media_data/oa-system-data_sys_param_online_package.json'
    And verify that dom zip contains the folder or file 'oa-gw/logic'
    And verify that dom zip contains the folder or file 'oa-gw/data'
    And verify that dom zip contains the folder or file 'ui/mbsymb'
    And verify that dom zip contains the folder or file 'ui/media'
    And the file 'mbsymb_sys_0030.png' on path 'ui/mbsymb' is present in dom zip
    And the file '00a8e25766ce9a8aac190d2b70b57719_1_-----.JPEG_DIBA55hi' on path 'ui/media' is present in dom zip
    And the file '2b9c0a937642c7ec354ae3654f2e6e60_1_-----.GIF' on path 'ui/media' is present in dom zip
    And cos file 'dom-flashware/<packagepath>/<odx_file>' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/<odx_file>'
    And file from path 'README.md' in cos file 'dom-flashware/<packagepath>/DOM.zip' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/<README>.md'
    And file from path 'oa-gw/data/info.txt' in cos file 'dom-flashware/<packagepath>/DOM.zip' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/info.txt'
    And Verify 'dom-flashware/<packagepath>/DOM.zip' artifact are present in artifactory
    And Verify 'dom-flashware/<packagepath>/<odx_file>' artifact are present in artifactory
    And the logs of 'dom-container-service' are similar with file '<test_folder>/then/logs_validation/log_dom_container_service.txt'
#    And the logs of 'dom-ui-data-service' are similar with file '<test_folder>/then/logs_validation/oidclog_dom_ui_data_service_success.txt'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service.txt'
    #    And logs of 'dom-content-service' having 2 unique trace ids
    #below step need to be added when dom validation will implement for Gen20x
#    And the logs of 'dom-validation-service' are similar with file '<test_folder>/then/logs_validation/log_dom_validation_service.txt'
    #And file content of cos file '<dom-validation_result_path>' from bucket 'ba-oacore-test-resource-storage' has the same content as '<test_folder>/then/cos/result.json'


    Examples:
      | test_folder                                | packagepath       | post_packages_request                      | dom_package_creation_message              | dom_type | odx_file                                                          | dom_container_resource_odx  | dom_container_artifacts_creation_message | dom_container  | dom_container_resource_dom  | dom_container_resource_cos_odx  | dom_content_headers                 | README  | bin_file          |
      | /testData/flashware_creation/gen20x/online | 300030_3333003014 | post_packages_request_media_data_dom1.json | message_package_creation_media_data1.json | dom1     | PREFULL_GEN20X_007_CIVIC206_E012_0_DOM1_P_3333003014_300030.odx-f | dom_container_resource_odx1 | dom_container_queue_message4.json        | dom_container1 | dom_container_resource_dom1 | dom_container_resource_cos_odx1 | dom_content_headers_package_id4.txt | README4 | 3333003014_300030 |
      | /testData/flashware_creation/gen20x/online | 300030_3333003015 | post_packages_request_media_data_dom2.json | message_package_creation_media_data2.json | dom2     | PREFULL_GEN20X_007_CIVIC206_E012_0_DOM2_P_3333003015_300030.odx-f | dom_container_resource_odx2 | dom_container_queue_message5.json        | dom_container2 | dom_container_resource_dom2 | dom_container_resource_cos_odx2 | dom_content_headers_package_id5.txt | README5 | 3333003015_300030 |
      | /testData/flashware_creation/gen20x/online | 300030_3333003016 | post_packages_request_media_data_dom3.json | message_package_creation_media_data3.json | dom3     | FULL_GEN20X_007_CIVIC206_E012_0_DOM3_P_3333003016_300030.odx-f    | dom_container_resource_odx3 | dom_container_queue_message6.json        | dom_container3 | dom_container_resource_dom3 | dom_container_resource_cos_odx3 | dom_content_headers_package_id6.txt | README6 | 3333003016_300030 |


  @revertDomContainerConfigMap @SP_74_US_12938 @DDIBA-12833
  Scenario Outline: Verify dom-container-service retry mechanism when uploading container data of a Gen20x FW (DOM.zip and ODX-F file) to Artifactory fails (System Error)

    Given the configmap 'dom-container-service-tsy-integration-configmap' has the property 'artifactory.url' value set to 'http://artifactory:8081/artifactorytest' in 'application.properties'
    And the deployment 'dom-container-service-tsy-integration' is restarted
    And the 'dom-container-service' is available

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_dom1.json'

    Then the response is started
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_package_creation_media_data1.json' in the queues bind to 'dom-content-v1-package_exchange'
    And dom-container-service publishes the artifacts creation message '<test_folder>/then/message_published/dom_container_queue_message_artifactory_fail.json' in the queues bind to dom-container-container_queue
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id7.txt'
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom1/dom_package.json'
    And the database table 'dom_container.dom_container' should contain a row with values in '<test_folder>/then/backend_databases/dom-container-data-db/dom_container_error.json'
    And the logs of 'dom-container-service' are similar with file '<test_folder>/then/logs_validation/log_dom_container_service_retry_artifactory_upload.txt'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |


  @SP78_US_13373_DDIBA-13456 @SP77_US_13370_TEST_13458 @DDIBA-13458 @DDIBA-13456 @revertOIDCCM
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

    When the command convert is executed at standalone adaptor with argument './standalone-adapter/Media_007.1_MA-CN__Premium_de_de_gen20x/jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml'
    And wait for sync status '2' and core status '2'
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/oa-import-db/xxxml_import.json'

    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-media/MEDIA_PA200033_007.1_CN_MA-CN_HU-CN_GEN20X_PREMIUM__de_de.zip' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.3.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-symb/mbsymb_GEN20X.zip' is present on bucket 'ba-ntg7-test-resource-storage'

    When the POST 'packages' request is made with request body '<test_folder>/when/<post_packages_request>'
    And the response is started
    And the flashware creation is finished

    Then the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/oidc_log_dom_content_service.txt'

    Examples:
      | test_folder                                 | post_packages_request                      |
      | /testData/flashware_creation/gen20x/offline | post_packages_request_media_data_dom1.json |


  Scenario Outline: Verify POST package response when request body sent with Invalid huModel

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_invalid_humodel.json'
    And wait for 60 seconds

    Then Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id2.txt'
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom1/dom_package_invalid_hu_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_invalid_hu_value.txt'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |


  @DDIBA-10311
  Scenario Outline: Verify flashware creation aborted when data is not available in vehicle-backend-db

    Given database 'oa-ve-backend-db' contains '<test_folder>/given/backend_databases/oa_ve_backend_db_delete_topic.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_dom1.json'

    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id3.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_no_topics_in_oa_vehicle_backend_db.json' in the queues bind to 'dom-content-v1-package_exchange'
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_no_topic_in_oa_vehicle_backend_db.txt'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |


  @SP77_US_13164_DDIBA-13450_gen20x @SP77_US_13164_DDIBA-13462_gen20x
  Scenario Outline: Verify that DOM UI Data Service extracts the MB symbol alongside the text as warning message title

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Prodspec-service' is available
    And the 'Masterdata Query Service' is available

    When the command convert is executed at standalone adaptor with argument './standalone-adapter/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__id_id_gen20x/jobfa6b3bfa9560a0530ac2a8d839d9687e.xml'
    And wait for sync status '2' and core status '2'
    And BA-platform publishes the notification message '<test_folder>/given/messages_to_publish/dom_content_service/disclaimer.json' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '<test_folder>/given/messages_to_publish/dom_content_service/identifier.json' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '<test_folder>/given/messages_to_publish/dom_content_service/language.json' in the queues bind to PSE_exchange

    Then the number of entries in the database table 'domui_data_service.domui_text' should be as specified in the file '<test_folder>/then/backend_databases/domui_data_service/count_text_value_mbSymb_warning_msg.json'
    And the database table 'domui_data_service.domui_text' should contain a row with values in '<test_folder>/then/backend_databases/domui_data_service/text_value_mbSymb_warning_msg.json'
    And the database table 'domui_data_service.domui_text' should contain a row with values in '<test_folder>/then/backend_databases/domui_data_service/text_value_multipleMbSymb_warning_msg.json'


    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |


  @SP77_US_13164_DDIBA-13462_gen20x
  Scenario Outline: Verify icons alongside the text as warning message title are present in domui_text table of dom-ui-data.db of a flashware

    Given the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And the 'dom-container-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-media/MEDIA_PA180554_223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__id_id.zip' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.3.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-symb/mbsymb_GEN20X.zip' is present on bucket 'ba-ntg7-test-resource-storage'

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_id_id.json'
    And the response is started
    And the flashware creation is finished

    Then Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-flashware/300030_3333003012/DOM.zip'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/count_text_value_mbSymb_warning_msg.json'
    And the sql-lite database 'dom-ui-data' table 'domui_text' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/text_value_mbSymb_warning_msg.json'
    And the sql-lite database 'dom-ui-data' table 'domui_text' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/text_value_multipleMbSymb_warning_msg.json'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |
      | /testData/flashware_creation/gen20x/online  |
