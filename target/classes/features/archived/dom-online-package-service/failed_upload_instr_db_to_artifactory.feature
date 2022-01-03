#Archived for DDIBA-13286
#
# @SP_70_US_11732_TEST_12160_12193

Feature: Verify dom-content-service retry mechanism when uploading online package data (dom-content-data.db and instr.db) to Artifactory fails

  Scenario Outline: Verify dom-content-service retry mechanism when uploading online package data (dom-content-data.db and instr.db) to Artifactory fails

    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' '<clean>'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'Masterdata Query Service' is available
    And the 'BA-platform' is available
    And the 'dom-online-package' is available
    And the command convert is executed at standalone adaptor with argument './<Superxml_foldername>/<job_name>'
    And wait for sync status '2' and core status '2'
    And the configmap 'dom-content-service-tsy-integration-configmap' has the property 'artifactory.url' value set to 'http://artifactory:8081/artifactorytest' in 'application.properties'
    And the deployment 'dom-content-service-tsy-integration' is restarted

    When the POST onlinepackages request is made with request body '<test_folder>/when/POST_DomOnlinePackage_withSOCrequest.json' and parameter '<pathParameter>'
    And Wait for update of dom-online-packages Dbs

    Then Verify status code '202' for given request
    And Verify response json with content '<test_folder>/then/response_json_validation/response.json'
    And dom-online-package publishes the online package creation message in the queues bind to 'dom-online-package-v1-onlinepackage_exchange-tsy-integration'
    And dom-content-service publishes the database resource creation message in the queues bind to 'dom-content-v1-database_exchange-tsy-integration'
    And the database table 'dom_online_package.dom_online_package' should contain a row with values in '<test_folder>/then/dom-online-packages_db/dom_online_package.json'
    And the database table 'dom_online_package.dom_online_package_resource' should contain a row with values in '<test_folder>/then/dom-online-packages_db/dom_online_package_resource.json'
    And the database table 'dom_content.dom_database_resource' should contain a row with values in '<test_folder>/then/oa-vehicle-backend_db/dom-content-database-resource.json'
    And Verify '/dom-online-packages/1/instr.db' dbs are not present in artifactory
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-online-packages/1/dom-content-data.db'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/Element_dom-content-data-db_Count.json'
    And the sql-lite database 'dom-content-data' table 'ELEMENT' should contain a rows with values '<test_folder>/then/dom-content-data_db/element_instruction.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/Node_dom-content-data-db_Count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/NodeElement_dom-content-data-db_Count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/ElementKeyword_dom-content-data-db_Count.json'
    And the sql-lite database 'dom-content-data' table 'SYS_PARAM' should contain a rows with values '<test_folder>/then/dom-content-data_db/dom-content-data_sys_param.json'
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-online-packages/1/instr.db'
    And the number of entries in the sql-lite database 'instr' should be as specified in file '<test_folder>/then/instr_db/instr_Count.json'
    Then the logs of 'dom-content-service-tsy-integration' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_retry_artifactory_upload.txt'
       #manually checking logs of dom content service for Retry mechanism and not uploading files to Artifactory

    Examples:
      | test_folder                                                | Superxml_foldername                                                 | job_name                                | clean |pathParameter|
      | /testData/dom-online-package-service/POST_onlinepackages   | standalone-adapter/223.1_KR_MA-KR_HU-KR_NTG7.0_PREMIUM__en_gb       | jobfc9c272f67df17b30ac2a8ea792f63e0.xml | true  |onlinepackages|
