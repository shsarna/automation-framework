@RegressionFlashareCreation @runThisFile1
Feature: Flashware creation validation when error occur during package creation

  @runThis
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
#    And the command convert is executed at standalone adaptor with argument './<test_folder>/Media_007.1_MA-CN__Premium_de_de/jobab1d30dabe36158a354aeb2c2e4c9c72.xml'
#    And wait for sync status '2' and core status '2'

    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange

    Examples:
      | test_folder        |
      | standalone-adapter |


  @DDIBA-11318 @runThis
  Scenario Outline: Verify that the flashware creation is aborted after configurable retry when any media files is missing from COS,MediaHub or ARKI.

    Given the configmap 'dom-content-service-tsy-integration-configmap' has the property 'fw.retrigger.wait.limit' value set to '1000' in 'application.properties'
    And the configmap 'dom-content-service-tsy-integration-configmap' has the property 'fw.retrigger.check.interval' value set to '500' in 'application.properties'
    And the deployment 'dom-content-service-tsy-integration' is restarted
    And the 'dom-sw-service' is available
    And the 'oa-gw-data-service' is available
    And the 'dom-container-service' is available
    And the 'dom-content-service' is available
    And database 'dom-sw-db' contains '/testData/flashware_creation/General/SqlScripts/dom_sw_insert_data.sql' data
    And database 'oa-gw-data-db' contains '/testData/flashware_creation/General/SqlScripts/oa_gw_insert_data.sql' data
    And the releases of 'DOM,OA,BTS' are present on bucket 'ba-ntg7-test-resource-storage'

    And database 'oa-ve-backend-db' contains '<test_folder>/given/oa-vehicle-backend-db/update_mediahub_url_from_table_media.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom1.json'

    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id1.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_package_error_wrong_media_url.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 120 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_en_gb_mediaFIle_missing.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_media_url_error.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |

  @SP70_US_11814_TEST_10177 @revertDomSwDb
  Scenario Outline: Verify the dom-content-service ERROR logs for Collecting DOM SW Data - No data received from DOM SW Service: No data (OA.zip and DOM.zip) available in backend database during a Flashware Creation

    Given database 'dom-sw-db' contains '<test_folder>/given/vehicle-dbs/dom_sw_delete_data.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom1.json'

    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id2.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_dom_sw_service.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And database 'dom-sw-db' contains '<test_folder>/then/vehicle-dbs/dom_sw_insert_dom_release_data.sql' data
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_dom_sw_db_error.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |


  @SP59_Test_10187 @revertOaGwDataDb
  Scenario Outline: Verify the dom-content-service ERROR logs when No data received from OA GW Service: No schedules available during a Flashware Creation

    Given database 'oa-gw-data-db' contains '<test_folder>/given/vehicle-dbs/oa_gw_delete_data.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom1.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id3.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_oa_gw_service_no_schedule_data.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_oa_gw_scheduled_error.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |

  @SP59_Test_10186 @revertOaGwDataDb
  Scenario Outline: Verify the dom-content-service ERROR logs when No data received from OA GW Service: No parameters available during a Flashware Creation

    Given database 'oa-gw-data-db' contains '<test_folder>/given/vehicle-dbs/oa_gw_delete_parameter_data.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom1.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id4.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_oa_gw_service_no_parameter_data.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_oa_gw_parameter_error.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |

  @SP59_Test_10189 @revertDomSwDb
  Scenario Outline: Verify the dom-content-service ERROR logs when No release artefact (OA.zip) available in cos during a Flashware Creation

    Given database 'dom-sw-db' contains '<test_folder>/given/vehicle-dbs/dom_sw_update_oa.zip_version_data.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom1.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id5.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_oa.zip_artifacts_cos.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_oa.zip_not_in_cos_error.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |

  @SP59_Test_10189 @revertDomSwDb
  Scenario Outline: Verify the dom-content-service ERROR logs when No release artefact (DOM.zip) available in cos during a Flashware Creation

    Given database 'dom-sw-db' contains '<test_folder>/given/vehicle-dbs/dom_sw_update_dom.zip_version_data.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom1.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id6.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_dom.zip_artifacts_cos.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_dom.zip_not_in_cos_error.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |

  @SP59_Test_10189 @revertDomSwDb
  Scenario Outline: Verify the dom-content-service ERROR logs when No release artefact (BTS.zip) available in cos during a Flashware Creation

    Given database 'dom-sw-db' contains '<test_folder>/given/vehicle-dbs/dom_sw_update_bts.zip_version_data.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom2.json'
    And the response is started

    Then Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id7.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_bts.zip_artifacts_cos.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_update_BTS_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_bts.zip_not_in_cos_error.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |


  @SP59_DDIBA-10182
  Scenario Outline: Verify the dom-content-service ERROR logs when No language metadata available in DOM UI DATA DB during a Flashware Creation

    Given database 'dom-ui-data-db' contains '<test_folder>/given/vehicle-dbs/dom_ui_data_db_delete_language.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom2.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id8.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_no_language_message_in_dom_ui_data_db.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error_dom2.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_no_language_message_in_dom_ui_db.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |

  @SP59_DDIBA-10181
  Scenario Outline: Verify the dom-content-service ERROR logs when No warning message references available in DOM UI DATA DB during a Flashware Creation

    Given database 'dom-ui-data-db' contains '<test_folder>/given/vehicle-dbs/dom_ui_data_db_delete_warning_message.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom2.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id9.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_no_warning_message_in_dom_ui_data_db.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error_dom2.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_no_warning_message_in_dom_ui_db.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |

  @SP59_DDIBA-10184
  Scenario Outline: Verify the dom-content-service ERROR logs when No valuemappings available in DOM UI DATA DB during a Flashware Creation

    Given database 'dom-ui-data-db' contains '<test_folder>/given/vehicle-dbs/dom_ui_data_db_delete_value_mapping.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom2.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id10.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_no_value_mapping_in_dom_ui_data_db.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error_dom2.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_no_value_mapping_in_dom_ui_db.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |

  @SP59_DDIBA-10180
  Scenario Outline: Verify the dom-content-service ERROR logs for Collecting DOM UI Data - No data received from DOM UI DATA Service: No menu items available during a Flashware Creation

    Given database 'dom-ui-data-db' contains '<test_folder>/given/vehicle-dbs/dom_ui_data_db_delete_menu_item.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom2.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id11.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_no_menu_item_in_dom_ui_data_db.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error_dom2.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_no_menu_item_in_dom_ui_db.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |

  @SP59_DDIBA-10183
  Scenario Outline: Verify the dom-content-service ERROR logs when No texts available in DOM UI DATA DB during a Flashware Creation

    Given database 'dom-ui-data-db' contains '<test_folder>/given/vehicle-dbs/dom_ui_data_db_delete_text.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_dom2.json'
    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id12.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_no_text_in_dom_ui_data_db.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error_dom2.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_no_text_in_dom_ui_db.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |


#  @DDIBA-11344 @SemiAutomated
#  Scenario Outline: Verify that the flashware creation is aborted when error occurs while retrieving OIDC token for MediaHub for downloading the media files during flashware creation
#
#    #manually  changing the OIDC secrete of MediaHub to incorrect value
#    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data.json'
#
#    Then the response is started
#    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
#    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_Package_id4.txt'
#    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_package_error_mediahub_auhentication_failed.json' in the queues bind to 'dom-content-v1-package_exchange'
#    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backendDatabases/oa-vehicle-backend-db/dom_package_error.json'
#    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_media_hub_authentication_failed.txt'
#
#    Examples:
#      | test_folder                               |
#      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |


  @DDIBA-10311
  Scenario Outline: Verify flashware creation aborted when data is not available in vehicle-backend-db

    Given database 'oa-ve-backend-db' contains '<test_folder>/given/backend_databases/oa_ve_backend_db_delete_topic.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data.json'

    Then the response is started
    And Verify response json of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_headers_package_id13.txt'
    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_no_topics_in_oa_vehicle_backend_db.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_no_topic_in_oa_vehicle_backend_db.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |

#  @DDIBA-13461 @SP78_US_13370_TEST_13461 @SP78_US_13373_TEST_13459 @DDIBA-13459 @SemiAutomated @revertOIDCCM
#  Scenario Outline: Verify that the flashware creation is aborted when 401 unauthorized error occurs while retrieving OIDC token for calling DOM UI data service during flashware creation
#    #manually changing the OIDC secrete of Dom UI Data service to incorrect value
#    Given the configmap 'dom-content-service-tsy-integration-configmap' has the property 'dom.ui.data.service.base.path' value set to 'https://ntg7.om-systems-test.cloud.corpintra.net/dom-ui-data-service/v1' in 'application.properties'
#    And the deployment 'dom-content-service-tsy-integration' is restarted
#
#    And the configmap 'dom-ui-data-service-configmap' has the property 'spring.datasource.url' value set to 'jdbc:postgresql://e1c7d4e2-3bf9-4cf5-945d-046bce53b1bf.bc28ac43cf10402584b5f01db462d330.private.databases.appdomain.cloud:32232/dom_ui_data_db-tsy-integration?ssl=true&sslmode=verify-full&sslrootcert=/etc/ssl/icd.crt' in 'application.properties'
#    And the deployment 'dom-ui-data-service' is restarted
#    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_media_data_eStand_280.json'
#    And wait for 90 seconds
#
#    Then the response is started
#    And Verify headers of dom content package with content '<test_folder>/then/response_validation/dom_content_response.txt'
#    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error_oidc.json'
#    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_oidc_error.txt'
#    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_package_error_oidc_auhentication_failed.json' in the queues bind to 'dom-content-v1-package_exchange'
#    Examples:
#      | test_folder                                                              |
#      | /testData/flashware_creation/ntg7/ntg7_flashware_single_language/offline |


  @DDIBA-10192
  Scenario Outline: Verify the dom-content-service ERROR logs when Media file couldn't be downloaded from COS during a Flashware Creation

#    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_missing_media.json'
    Then the response is started
#    And Wait for update of Dbs
    
#    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_media_missing.json' in the queues bind to 'dom-content-v1-package_exchange'
#    And dom-content-service publishes the sync message '<test_folder>/then/message_published/message_error_media_missing.json' in the queues bind to dom-content-contentsync_exchange
#    And dom-content-service publishes the sync message '<test_folder>/then/message_published/message_error_media_missing.json' in the queues bind to 'dom-content-contentsync_exchange'
    #    And dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_error_media_missing.json' in the queues bind to 'dom-content-package.queue'
    And wait for 90 seconds
    And the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And verify the message '<test_folder>/then/message_published/message_error_media_missing.json' is received from exchange 'dom-content-package.queue'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_missing_media.txt'

    Examples:
      | test_folder                                                          |
      | /testData/flashware_creation/ntg7/flashwares_error_scenarios/offline |

