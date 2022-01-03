#@RegressionAll @Regression_Set1
@SP70_US_11814_TEST_12194 @RegressionFlashareCreation @Gen20xError

Feature: Flashware creation  when error occur during package creation for gen20x

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


  @SP70_US_11814_TEST_10177 @DDIBA-10177 @revertDomSwDb
  Scenario Outline: Verify the dom-content-service ERROR logs for Collecting DOM SW Data - No data received from DOM SW Service: No data (OA.zip and DOM.zip) available in backend database during a Flashware Creation

    Given the configmap 'dom-content-service-tsy-integration-configmap' has the property 'fw.retrigger.wait.limit' value set to '1000' in 'application.properties'
    And the configmap 'dom-content-service-tsy-integration-configmap' has the property 'fw.retrigger.check.interval' value set to '500' in 'application.properties'
    And the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And the 'dom-container-service' is available
    And the 'dom-content-service' is available
    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'

    And database 'dom-sw-db' contains '<test_folder>/given/vehicle-dbs/dom_sw_delete_data.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_dom1.json'

    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id1.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_dom_sw_service.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 60 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_noData_domSw_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_dom_sw_db_error.txt'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |


  @SP59_Test_10187 @DDIBA-10187 @revertOaGwDataDb
  Scenario Outline: Verify the dom-content-service ERROR logs when No data received from OA GW Service: No schedules available during a Flashware Creation

    Given database 'oa-gw-data-db' contains '<test_folder>/given/vehicle-dbs/oa_gw_delete_data.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_dom1.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id2.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_oa_gw_service_no_schedule_data.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 60 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_oa_gw_scheduled_error.txt'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |

  @SP59_Test_10186 @DDIBA-10186 @revertOaGwDataDb #verify script for the deleted data
  Scenario Outline: Verify the dom-content-service ERROR logs when No data received from OA GW Service: No parameters available during a Flashware Creation

    Given database 'oa-gw-data-db' contains '<test_folder>/given/vehicle-dbs/oa_gw_delete_parameter_data.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_dom1.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id3.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_oa_gw_service_no_parameter_data.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 60 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_oa_gw_parameter_error.txt'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |

  @SP59_Test_10189 @DDIBA-10189 @revertDomSwDb
  Scenario Outline: Verify the dom-content-service ERROR logs when No release artefact (OA.zip) available in cos during a Flashware Creation

    Given database 'dom-sw-db' contains '<test_folder>/given/vehicle-dbs/dom_sw_update_oa.zip_version_data.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_dom1.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id4.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_oa.zip_artifacts_cos.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 60 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_oaZip_update_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_oa.zip_not_in_cos_error.txt'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |

  @SP59_DDIBA-10182 @DDIBA-10182
  Scenario Outline: Verify the dom-content-service ERROR logs when No language metadata available in DOM UI DATA DB during a Flashware Creation

    Given database 'dom-ui-data-db' contains '<test_folder>/given/vehicle-dbs/dom_ui_data_db_delete_language.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_dom1.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id5.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_no_language_message_in_dom_ui_data_db.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_no_language_message_in_dom_ui_db.txt'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |

  @SP59_DDIBA-10181 @DDIBA-10181
  Scenario Outline: Verify the dom-content-service ERROR logs when No warning message references available in DOM UI DATA DB during a Flashware Creation

    Given database 'dom-ui-data-db' contains '<test_folder>/given/vehicle-dbs/dom_ui_data_db_delete_warning_message.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_dom1.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id6.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_no_warning_message_in_dom_ui_data_db.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_no_warning_message_in_dom_ui_db.txt'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |

  @SP59_DDIBA-10184 @DDIBA-10184
  Scenario Outline: Verify the dom-content-service ERROR logs when No valuemappings available in DOM UI DATA DB during a Flashware Creation

    Given database 'dom-ui-data-db' contains '<test_folder>/given/vehicle-dbs/dom_ui_data_db_delete_value_mapping.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_dom1.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id7.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_no_value_mapping_in_dom_ui_data_db.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_no_value_mapping_in_dom_ui_db.txt'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |

  @SP59_DDIBA-10180 @DDIBA-10180
  Scenario Outline: Verify the dom-content-service ERROR logs for Collecting DOM UI Data - No data received from DOM UI DATA Service: No menu items available during a Flashware Creation

    Given database 'dom-ui-data-db' contains '<test_folder>/given/vehicle-dbs/dom_ui_data_db_delete_menu_item.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_dom1.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id8.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_no_menu_item_in_dom_ui_data_db.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_no_menu_item_in_dom_ui_db.txt'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |

  @SP59_DDIBA-10183 @DDIBA-10183
  Scenario Outline: Verify the dom-content-service ERROR logs when No texts available in DOM UI DATA DB during a Flashware Creation

    Given database 'dom-ui-data-db' contains '<test_folder>/given/vehicle-dbs/dom_ui_data_db_delete_text.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_dom1.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id9.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_no_text_in_dom_ui_data_db.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_no_text_in_dom_ui_db.txt'

    Examples:
      | test_folder                                 |
      | /testData/flashware_creation/gen20x/offline |




