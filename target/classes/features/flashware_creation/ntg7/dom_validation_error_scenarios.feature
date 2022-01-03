@RegressionFlashareCreation @Dom_validation_error_scenario @runThisFile2

Feature: Dom validation result when error occur during FW package creation

  Scenario Outline: Import and Sync of multiple superxmls, BA sync for data availability in backend DB

#    Given all the STD files are available at standalone adapter
#      | Superxml_foldername                                           | job_name                                                 |
#      | standalone-adapter/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__en_gb | jobe2fcd6f09560915d0ac2a8ea7b887c96_unique_deeplink.xml  |
#      | standalone-adapter/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__de_de | job416da9c195608b250ac2a8de4bc7a061_unique_deeplinks.xml |

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the 'Prodspec-service' is available

#    When the command convert is executed at standalone adaptor with argument './<test_folder>/007.1_MA-ECE_ROW_HU-ECE_ROW_Premium_en_GB/job657e2927b2798ac20ac275c22b1b731a.xml'
#    And wait for sync status '2' and core status '2'
    When the command convert is executed at standalone adaptor with argument './<test_folder>/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__en_gb/jobe2fcd6f09560915d0ac2a8ea7b887c96_unique_deeplink.xml'
    And wait for sync status '2' and core status '2'
#    And the command convert is executed at standalone adaptor with argument './<test_folder>/223.1_CN_MA-CN_HU-CN_NTG7.0_PREMIUM__de_de/job416da9c195608b250ac2a8de4bc7a061_unique_deeplinks.xml'
#    And wait for sync status '2' and core status '2'

    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange

    Examples:
      | test_folder        |
      | standalone-adapter |


  @SP76_US_11814_TEST_12194
  Scenario Outline: Verify the output of DOM Validation service contains FW creation failed message when dom-content-service publishes a FW creation failure message and DOM Content Service publishes the n-tuple of a flashware package in its MQ message when FW is aborted

    Given the folder or artifact 'dom-validation/dom-rulesets/ruleset_warningmsg.json' is present on bucket 'ba-oacore-test-resource-storage'
    And the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_std_dom1_wrong_data.json'
    And the response is started

    When dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_package_creation_error.json' in the queues bind to 'dom-content-v1-package_exchange'
    And wait for 60 seconds

    Then the database table 'dom_content.dom_package' should contain a row with values in '<test_folder>/then/backend_databases/oa-vehicle-backend-db/dom_package_error.json'
    And file content of cos file 'dom-validation-result/300030_3333003011/result.json' from bucket 'ba-oacore-test-resource-storage' has the same content as '<test_folder>/then/cos/result_error.json'
    And the logs of 'dom-validation-service' are similar with file '<test_folder>/then/logs_validation/log_dom_validation_service_error.txt'

    Examples:
      | test_folder                                                              |
      | /testData/flashware_creation/ntg7/dom_validation_error_scenarios/offline |


  @SP76_US_12351_TEST_13353
  Scenario Outline: Verify DOM Validation Service validation fails when warning message title reference is missing from dom-content-data.db of a FW

    Given the folder or artifact 'dom-validation/dom-rulesets/ruleset_warningmsg.json' is present on bucket 'ba-oacore-test-resource-storage'
    And database 'oa-ve-backend-db' contains '<test_folder>/given/backend_databases/dom_content_db_delete_warningmessage_title.sql' data

    When the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_en_gb.json'
    And the response is started
    And the flashware creation is finished

    And cos file 'dom-validation-result/300030_3333003011/result.json' from bucket 'ba-oacore-test-resource-storage' has the same content as '<test_folder>/then/cos/result_title_mismatch_error.json'
    And the logs of 'dom-validation-service' are similar with file '<test_folder>/then/logs_validation/log_dom_validation_service_warning_msg_title_mismatch.txt'

    Examples:
      | test_folder                                                              |
      | /testData/flashware_creation/ntg7/dom_validation_error_scenarios/offline |


  @SP76_US_12351_TEST_13352
  Scenario Outline: Verify DOM Validation Service validation fails when warning message reference is missing from dom-content-data.db of a FW

    Given the folder or artifact 'dom-validation/dom-rulesets/ruleset_warningmsg.json' is present on bucket 'ba-oacore-test-resource-storage'
    And database 'oa-ve-backend-db' contains '<test_folder>/given/backend_databases/dom_content_db_delete_warningmessage_long_and_short.sql' data
    And the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_en_gb.json'
    And the response is started
    And the flashware creation is finished

    When dom-content-service publishes the package creation message '<test_folder>/then/message_published/message_package_creation_success.json' in the queues bind to 'dom-content-v1-package_exchange'

    Then file content of cos file 'dom-validation-result/300030_3333003011/result.json' from bucket 'ba-oacore-test-resource-storage' has the same content as '<test_folder>/then/cos/result_warningmessage_reference_error.json'
    And the logs of 'dom-validation-service' are similar with file '<test_folder>/then/logs_validation/log_dom_validation_service_warning_msg_ref_mismatch.txt'

    Examples:
      | test_folder                                                              |
      | /testData/flashware_creation/ntg7/dom_validation_error_scenarios/offline |

  @SP76_US_12351_TEST_13354 @revertDomValidationConfigMap
  Scenario Outline: Verify DOM Validation Service could not perform validation when ruleset is not available at COS

    Given the configmap 'dom-validation-service-tsy-integration-configmap' has the property 'ruleset.base.path' value set to '<ruleset_path>' in 'application.properties'
    And the deployment 'dom-validation-service-tsy-integration' is restarted

    And the POST 'packages' request is made with request body '<test_folder>/when/post_packages_request_std_dom2_ruleSet_not_available.json'
    And the response is started
    And the flashware creation is finished

    Then the folder or artifact 'dom-validation-result/300030_3333007001/result.json' is not present on bucket 'ba-oacore-test-resource-storage'
    Then the logs of 'dom-validation-service' are similar with file '<test_folder>/then/logs_validation/log_dom_validation_service_wrong_ruleset_folder_name.txt'


    Examples:
      | test_folder                                                              | ruleset_path                                                                                          |
      | /testData/flashware_creation/ntg7/dom_validation_error_scenarios/offline | https://s3.eu-de.cloud-object-storage.appdomain.cloud/ba-oacore-test-resource-storage/dom-validation/ |
