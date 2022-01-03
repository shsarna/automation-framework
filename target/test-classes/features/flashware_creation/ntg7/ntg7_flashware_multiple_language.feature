@RegressionAll @Regression_Set1 @RegressionFlashareCreation  @SP70_US_11814_TEST_12215 @SP70_US_12177_TEST_12215 @DDIBA-10157 @DDIBA-10159  @DDIBA-10423
@Regression_SP77  @fwCreation
Feature: Flashware creation with multiple languages and dom validation for flashware with multiple superxmls

  Scenario Outline: Import and Sync of multiple superxmls, BA sync for data availability in backend DB

    Given all the STD files are available at standalone adapter
      | Superxml_foldername                                           | job_name                                                 |
      | standalone-adapter/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__en_gb | jobe2fcd6f09560915d0ac2a8ea7b887c96_unique_deeplink.xml  |
      | standalone-adapter/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__de_de | job416da9c195608b250ac2a8de4bc7a061_unique_deeplinks.xml |

    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the 'Prodspec-service' is available

    When the command convert is executed at standalone adaptor with argument './<test_folder>/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__en_gb/jobe2fcd6f09560915d0ac2a8ea7b887c96_unique_deeplink.xml'
    And wait for sync status '2' and core status '2'
    And the command convert is executed at standalone adaptor with argument './<test_folder>/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__de_de/job416da9c195608b250ac2a8de4bc7a061_unique_deeplinks.xml'
    And wait for sync status '2' and core status '2'

    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange

    Examples:
      | test_folder        |
      | standalone-adapter |

  @DDIBA-12215 @SP73_US_12660 @DDIBA-10398
  Scenario Outline: Flashware creation and dom validation for flashware with multiple superxmls and the version of buildDOMContainer tool is present in odx-f file of a flashware in COS

    Given the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And the 'dom-container-service' is available
    And the 'dom-validation-service' is available
    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.2.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-symb/mbsymb_NTG7.0.zip' is present on bucket 'ba-ntg7-test-resource-storage'

    When the POST 'packages' request is made with request body '<test_folder>/when/<post_packages_request>'
    And the response is started
    And the flashware creation is finished

    Then Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/<dom_content_headers>'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/<dom_package_creation_message>' in the queues bind to 'dom-content-v1-package_exchange'
    And dom-container-service publishes the artifacts creation message '<test_folder>/then/message_published/<dom_container_queue_message>' in the queues bind to dom-container-container_queue
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backendDatabases/oa-vehicle-backend-db/<dom_package>'
    And the database table 'dom_content.dom_package_resource' should contain a row with values in '<test_folder>/then/backendDatabases/oa-vehicle-backend-db/<dom_package_resource1>'
    And the database table 'dom_content.dom_package_resource' should contain a row with values in '<test_folder>/then/backendDatabases/oa-vehicle-backend-db/<dom_package_resource2>'
    And the database table 'dom_content.dom_package_resource' should contain a row with values in '<test_folder>/then/backendDatabases/oa-vehicle-backend-db/<dom_package_resource3>'
    And the database table 'dom_container.dom_container' should contain a row with values in '<test_folder>/then/backendDatabases/dom-container-data-db/<dom_container>'
    And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backendDatabases/dom-container-data-db/<dom_container_resource1>'
    And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backendDatabases/dom-container-data-db/<dom_container_resource2>'
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-flashware/<package_path>/OA.zip' for ntg7 device

    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_onlyLanguageDeEn_element-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-at-a-glance-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-description-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disclaimer-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disp-diagnoses-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-instruction-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-quickstart-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-warn-controls-count.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disclaimer.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disp-diagnoses-longmessage.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disp-diagnoses-shortmessage.json'
      And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-normalTopic.json'
      And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-warn-controls.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_node-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_node_element-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element_keyword-count.json'
    And the sql-lite database 'dom-content-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_sys_param.json'
    And the sql-lite database 'dom-ui-data' table 'domui_validity' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_validity1.json'
        And the sql-lite database 'dom-ui-data' table 'domui_validity' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_validity2.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_text-count.json'
    And the sql-lite database 'dom-ui-data' table 'domui_text' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_text_STRUCT.json'
    And the sql-lite database 'dom-ui-data' table 'domui_text' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_text_MSG.json'
    And the sql-lite database 'dom-ui-data' table 'domui_text' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_text_BZ.json'
    And the sql-lite database 'dom-ui-data' table 'domui_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_param.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_message_ref-count.json'
    And the sql-lite database 'dom-ui-data' table 'domui_message_ref' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_message_ref.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_menu_item-count.json'
    And the sql-lite database 'dom-ui-data' table 'domui_menu_item' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_menu_item1.json'
    And the sql-lite database 'dom-ui-data' table 'domui_menu_item' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_menu_item2.json'
    And the sql-lite database 'dom-ui-data' table 'domui_menu_item' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_menu_item3.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_lang-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_lang2-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_lang1-count.json'
    And the sql-lite database 'oa-client-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-client-data-db/oa-client-data_sys_param.json'
        And the sql-lite database 'oa-system-data' table 'sys_validity' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-system-data-db/oa-system-data_sys_validity.json'
    And the number of entries in the sql-lite database 'oa-system-data' should be as specified in file '<test_folder>/then/vehicleDatabases/oa-system-data-db/oa-system-data_sys_param-count.json'
    And the sql-lite database 'oa-system-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-system-data-db/oa-system-data_sys_param1.json'
    And the sql-lite database 'oa-system-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-system-data-db/oa-system-data_sys_param2.json'
    And the folder or artifact 'dom-flashware/<package_path>/<bin_file>.bin' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-flashware/<package_path>/dom.img' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-flashware/<package_path>/etc.img' is present on bucket 'ba-ntg7-test-resource-storage'
    And file content of cos file 'dom-flashware/<package_path>/README.md' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/<README>.md'
    And file content of cos file 'dom-flashware/<package_path>/OA.zip/data/info.txt' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/info.txt'
    And file content of cos file 'dom-flashware/<package_path>/<odxf_name>' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/<odxf_name>'

    And the logs of 'dom-validation-service' are similar with file '<test_folder>/then/logs_validation/log_dom_validation_service.txt'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service.txt'
    And the logs of 'dom-container-service' are similar with file '<test_folder>/then/logs_validation/log_dom_container_service.txt'

    Examples:
      | test_folder                                                                | post_packages_request           | package_path      | dom_package           | odxf_name                                                  | dom_package_creation_message              | dom_container_queue_message                    | dom_content_headers                 | dom_container_resource1       | dom_container_resource2       | dom_container       | dom_package_resource1       | dom_package_resource2       | dom_package_resource3       | bin_file          | README  | result                    |
      | /testData/flashware_creation/ntg7/ntg7_flashware_multiple_language/offline | post_packages_request_dom1.json | 300030_3333003011 | dom_package_dom1.json | PREFULL_NTG7_223_HU7_E012_0_DOM1_P_3333003011_300030.odx-f | message_package_creation_package_id1.json | dom_container_queue_message_container_id1.json | dom_content_headers_package_id1.txt | dom1_container_resource1.json | dom1_container_resource2.json | dom1_container.json | dom1_package_resource1.json | dom1_package_resource2.json | dom1_package_resource3.json | 3333003011_300030 | README1 | result_with2superxml_dom1 |
      | /testData/flashware_creation/ntg7/ntg7_flashware_multiple_language/offline | post_packages_request_dom2.json | 300030_3333003013 | dom_package_dom2.json | PREFULL_NTG7_223_HU7_E012_0_DOM2_P_3333003013_300030.odx-f | message_package_creation_package_id3.json | dom_container_queue_message_container_id3.json | dom_content_headers_package_id3.txt | dom2_container_resource1.json | dom2_container_resource2.json | dom2_container.json | dom2_package_resource1.json | dom2_package_resource2.json | dom2_package_resource3.json | 3333003013_300030 | README3 | result_with2superxml_dom2 |
      | /testData/flashware_creation/ntg7/ntg7_flashware_multiple_language/offline | post_packages_request_dom3.json | 300030_3333003015 | dom_package_dom3.json | FULL_NTG7_223_HU7_E012_0_DOM3_P_3333003015_300030.odx-f    | message_package_creation_package_id5.json | dom_container_queue_message_container_id5.json | dom_content_headers_package_id5.txt | dom3_container_resource1.json | dom3_container_resource2.json | dom3_container.json | dom3_package_resource1.json | dom3_package_resource2.json | dom3_package_resource3.json | 3333003015_300030 | README5 | result_with2superxml_dom3 |


  Scenario Outline: Flashware creation and dom validation for flashware with multiple superxmls and the version of buildDOMContainer tool is present in odx-f file of a flashware in COS

    Given the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And the 'dom-container-service' is available
    And the 'dom-validation-service' is available
    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-resources/template_1.0.2.odx-f' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-symb/mbsymb_NTG7.0.zip' is present on bucket 'ba-ntg7-test-resource-storage'

    When the POST 'packages' request is made with request body '<test_folder>/when/<post_packages_request>'
    And the response is started
    And the flashware creation is finished

    Then Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/<dom_content_headers>'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/<dom_package_creation_message>' in the queues bind to 'dom-content-v1-package_exchange'
    And dom-container-service publishes the artifacts creation message '<test_folder>/then/message_published/<dom_container_queue_message>' in the queues bind to dom-container-container_queue
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backendDatabases/oa-vehicle-backend-db/<dom_package>'
    And the database table 'dom_content.dom_package_resource' should contain a row with values in '<test_folder>/then/backendDatabases/oa-vehicle-backend-db/<dom_package_resource1>'
    And the database table 'dom_content.dom_package_resource' should contain a row with values in '<test_folder>/then/backendDatabases/oa-vehicle-backend-db/<dom_package_resource2>'
    And the database table 'dom_content.dom_package_resource' should contain a row with values in '<test_folder>/then/backendDatabases/oa-vehicle-backend-db/<dom_package_resource3>'
    And the database table 'dom_container.dom_container' should contain a row with values in '<test_folder>/then/backendDatabases/dom-container-data-db/<dom_container>'
    And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backendDatabases/dom-container-data-db/<dom_container_resource1>'
    And the database table 'dom_container.dom_container_resource' should contain a row with values in '<test_folder>/then/backendDatabases/dom-container-data-db/<dom_container_resource2>'
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-flashware/<package_path>/OA.zip' for ntg7 device

    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_onlyLanguageDeEn_element-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-at-a-glance-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-description-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disp-diagnoses-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-instruction-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-quickstart-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-warn-controls-count.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disp-diagnoses-longmessage.json'
    And the sql-lite database 'dom-content-data' table 'element' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element-disp-diagnoses-shortmessage.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_node-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_node_element-count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_element_keyword-count.json'
    And the sql-lite database 'dom-content-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-content-data-db/dom-content-data_sys_param.json'
    And the sql-lite database 'dom-ui-data' table 'domui_validity' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_validity1.json'
    And the sql-lite database 'dom-ui-data' table 'domui_validity' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_validity2.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_text-count.json'
    And the sql-lite database 'dom-ui-data' table 'domui_text' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_text_STRUCT.json'
    And the sql-lite database 'dom-ui-data' table 'domui_text' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_text_MSG.json'
    And the sql-lite database 'dom-ui-data' table 'domui_text' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_text_BZ.json'
    And the sql-lite database 'dom-ui-data' table 'domui_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_param.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_message_ref-count.json'
    And the sql-lite database 'dom-ui-data' table 'domui_message_ref' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_message_ref.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_menu_item-count.json'
    And the sql-lite database 'dom-ui-data' table 'domui_menu_item' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_menu_item1.json'
    And the sql-lite database 'dom-ui-data' table 'domui_menu_item' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_menu_item2.json'
    And the sql-lite database 'dom-ui-data' table 'domui_menu_item' should contain a rows with values '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_menu_item3.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_lang-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_lang2-count.json'
    And the number of entries in the sql-lite database 'dom-ui-data' should be as specified in file '<test_folder>/then/vehicleDatabases/dom-ui-data-db/dom-ui-data_domui_lang1-count.json'
    And the sql-lite database 'oa-client-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-client-data-db/oa-client-data_sys_param.json'
    And the number of entries in the sql-lite database 'oa-system-data' should be as specified in file '<test_folder>/then/vehicleDatabases/oa-system-data-db/oa-system-data_sys_param-count.json'
    And the sql-lite database 'oa-system-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-system-data-db/oa-system-data_sys_param1.json'
    And the sql-lite database 'oa-system-data' table 'sys_param' should contain a rows with values '<test_folder>/then/vehicleDatabases/oa-system-data-db/oa-system-data_sys_param2.json'
    And the folder or artifact 'dom-flashware/<package_path>/<bin_file>.bin' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-flashware/<package_path>/dom.img' is present on bucket 'ba-ntg7-test-resource-storage'
    And the folder or artifact 'dom-flashware/<package_path>/etc.img' is present on bucket 'ba-ntg7-test-resource-storage'
    And file content of cos file 'dom-flashware/<package_path>/README.md' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/<README>.md'
    And file content of cos file 'dom-flashware/<package_path>/OA.zip/data/info.txt' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/info.txt'
    And file content of cos file 'dom-flashware/<package_path>/<odxf_name>' from bucket 'ba-ntg7-test-resource-storage' has the same content as '<test_folder>/then/cos/<odxf_name>'

    And the logs of 'dom-validation-service' are similar with file '<test_folder>/then/logs_validation/log_dom_validation_service.txt'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service.txt'
    And the logs of 'dom-container-service' are similar with file '<test_folder>/then/logs_validation/log_dom_container_service.txt'

    Examples:
      | test_folder                                                                | post_packages_request           | package_path      | dom_package           | odxf_name                                                  | dom_package_creation_message              | dom_container_queue_message                    | dom_content_headers                 | dom_container_resource1       | dom_container_resource2       | dom_container       | dom_package_resource1       | dom_package_resource2       | dom_package_resource3       | bin_file          | README  | result                    |
      | /testData/flashware_creation/ntg7/ntg7_flashware_multiple_language/online  | post_packages_request_dom1.json | 300030_3333003012 | dom_package_dom1.json | PREFULL_NTG7_223_HU7_E012_0_DOM1_P_3333003012_300030.odx-f | message_package_creation_package_id2.json | dom_container_queue_message_container_id2.json | dom_content_headers_package_id2.txt | dom1_container_resource1.json | dom1_container_resource2.json | dom1_container.json | dom1_package_resource1.json | dom1_package_resource2.json | dom1_package_resource3.json | 3333003012_300030 | README2 | result_with2superxml_dom1 |
      | /testData/flashware_creation/ntg7/ntg7_flashware_multiple_language/online  | post_packages_request_dom2.json | 300030_3333003014 | dom_package_dom2.json | PREFULL_NTG7_223_HU7_E012_0_DOM2_P_3333003014_300030.odx-f | message_package_creation_package_id4.json | dom_container_queue_message_container_id4.json | dom_content_headers_package_id4.txt | dom2_container_resource1.json | dom2_container_resource2.json | dom2_container.json | dom2_package_resource1.json | dom2_package_resource2.json | dom2_package_resource3.json | 3333003014_300030 | README4 | result_with2superxml_dom2 |
      | /testData/flashware_creation/ntg7/ntg7_flashware_multiple_language/online  | post_packages_request_dom3.json | 300030_3333003016 | dom_package_dom3.json | FULL_NTG7_223_HU7_E012_0_DOM3_P_3333003016_300030.odx-f    | message_package_creation_package_id6.json | dom_container_queue_message_container_id6.json | dom_content_headers_package_id6.txt | dom3_container_resource1.json | dom3_container_resource2.json | dom3_container.json | dom3_package_resource1.json | dom3_package_resource2.json | dom3_package_resource3.json | 3333003016_300030 | README6 | result_with2superxml_dom3 |


  @SP76_US_12351_TEST_12215 @DDIBA-12215
  Scenario Outline: Verify DOM Validation Service validates topics of multiple SuperXMLs against a flashware and warning message references, titles in SQLite DB when dom-content-service publishes a FW creation success message

    Given the 'dom-content-service' is available
    And  the 'dom-validation-service' is available
    And cos file 'dom-validation/dom-rulesets/ruleset_warningmsg.json' from bucket 'ba-oacore-test-resource-storage' has the same content as '<test_folder>/given/cos/rule-set.json'

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom1.json'
    And the response is started
    And the flashware creation is finished

    Then cos file 'dom-validation-result/300030_3333003011/result.json' from bucket 'ba-oacore-test-resource-storage' has the same content as '<test_folder>/then/cos/result_warningmessage_reference_multiple_language.json'
    And the logs of 'dom-validation-service' are similar with file '<test_folder>/then/logs_validation/log_dom_validation_service_warning_msg_multiple_language.txt'

    Examples:
      | test_folder                               |
      | /testData/flashware_creation/ntg7/ntg7_flashware_multiple_language/offline |