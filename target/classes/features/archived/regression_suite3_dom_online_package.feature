#Archived for DDIBA-13286
# @DDIBA-11468  @DDIBA-12158 @DDIBA-11432 @DDIBA-11489 @DDIBA-11413 @DDIBA-11435 @DDIBA-11434 @DDIBA-11433 @DDIBA-11487 @DDIBA-12193 @DDIBA-12160 @DDIBA-11414

Feature: POST and Get onlinepackages with request parameter stateOfConstruction

  Scenario Outline: DOM Online Package Service takes new validity 'state of construction' into consideration when creating the online package resource, if provided in the request

    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the configmap 'dom-content-service-tsy-integration-configmap' has the property 'artifactory.url' value set to 'http://artifactory:8081/artifactory' in 'application.properties'
    And the deployment 'dom-content-service-tsy-integration' is restarted
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' '<clean>'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'Masterdata Query Service' is available
    And the 'BA-platform' is available
    And the 'dom-online-package' is available
    And the command convert is executed at standalone adaptor with argument './<Superxml_foldername>/<job_name>'
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And wait for sync status '2' and core status '2'

    When the POST onlinepackages request is made with request body '<test_folder>/when/POST_DomOnlinePackage_withSOCrequest.json' and parameter '<pathParameter>'
    And dom-online-package publishes the online package creation message in the queues bind to 'dom-online-package-v1-onlinepackage_exchange-tsy-integration'
    And dom-content-service publishes the database resource creation message in the queues bind to 'dom-content-v1-database_exchange-tsy-integration'
    And Wait for update of dom-online-packages Dbs

    Then Verify status code '202' for given request
    And Verify response json with content '<test_folder>/then/dom-online-packageWithSOCresponse.txt'
    And the database table 'dom_online_package.dom_online_package' should contain a row with values in '<test_folder>/then/dom-online-packages_db/dom_online_package.json'
    And the database table 'dom_online_package.dom_online_package_resource' should contain a row with values in '<test_folder>/then/dom-online-packages_db/dom_online_package_resource.json'
    And the database table 'dom_content.dom_database_resource' should contain a row with values in '<test_folder>/then/oa-vehicle-backend_db/dom-content-database-resource.json'
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-online-packages/1/dom-content-data.db'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/Element_dom-content-data-db_Count.json'

    And the sql-lite database 'dom-content-data' table 'ELEMENT' should contain a rows with values '<test_folder>/then/dom-content-data_db/element_disclaimer.json'
    And the sql-lite database 'dom-content-data' table 'ELEMENT' should contain a rows with values '<test_folder>/then/dom-content-data_db/element_instruction.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/Node_dom-content-data-db_Count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/NodeElement_dom-content-data-db_Count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/ElementKeyword_dom-content-data-db_Count.json'
    And the sql-lite database 'dom-content-data' table 'SYS_PARAM' should contain a rows with values '<test_folder>/then/dom-content-data_db/dom-content-data_sys_param.json'
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-online-packages/1/instr.db'
    And the number of entries in the sql-lite database 'instr' should be as specified in file '<test_folder>/then/instr_db/instr_Count.json'
    And Verify '/dom-online-packages/1/instr.db' artifact are present in artifactory

    Examples:
      | test_folder                                                | Superxml_foldername                                                 | job_name                                | clean |pathParameter|
      | /testData/dom-online-package-service/POST_onlinepackages | standalone-adapter/223.1_KR_MA-KR_HU-KR_NTG7.0_PREMIUM__en_gb | jobfc9c272f67df17b30ac2a8ea792f63e0_unique_deeplinks.xml | true  | onlinepackages |



  Scenario Outline: Verify GET/getInitialData response data contains parameter stateOfConstruction
    Given the STD file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the 'dom-online-package' is available
    And the 'dom-online-facade' is available
    And the 'BA-platform' is available
    And wait for sync status '2' and core status '2'

    When the GET getInitialData request is made with VIN number 'WDD2231631A000225' and Request-Id '12345' and parameter 'getInitialData'
    And Wait for update of dom-online-packages Dbs
    And Verify status code '200' for given request

    Then the database table 'dom_online_package.dom_online_package' should contain a row with values in '<test_folder>/dom_online_Packages_getInitialdata/dom_online_package.json'
    And the database table 'dom_online_package.dom_online_package_resource' should contain a row with values in '<test_folder>/dom_online_Packages_getInitialdata/dom_online_package_resource.json'
    And the database table 'dom_content.dom_database_resource' should contain a row with values in '<test_folder>/dom_online_Packages_getInitialdata/dom-content-database-resource.json'
    And Verify response json for businessLine '\"p\"' and deviceModel 'ntg7.0' and deviceModelMarket 'hu-kr' and deviceModelVariant 'premium' and deviceName 'hu' and market 'kr' and vehicleLine '223.1' and vehicleMarket 'ma-kr' and message 'Successfully retrieved initial data.'

    Examples:
      | test_folder | Superxml_foldername                                           | job_name                                | clean |
      | /testData   | standalone-adapter/223.1_KR_MA-KR_HU-KR_NTG7.0_PREMIUM__en_gb | jobfc9c272f67df17b30ac2a8ea792f63e0_unique_deeplinks.xml | true  |


  Scenario Outline: DOM Online Package Service takes new validity 'state of construction' into consideration when creating the online package resource, when triggered by a message from XXXML Import Service

    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And Wait for update of dom-online-packages Dbs
    And the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/dom-online-package-service/POST_onlinepackages/given/xxxml_import.json'

    When the command convert is executed at standalone adaptor with argument './<Superxml_foldername>/<job_name>'
    And Wait for update of dom-online-packages Dbs
    And Wait for update of dom-online-packages Dbs
    And Wait for update of dom-online-packages Dbs
    And Wait for update of dom-online-packages Dbs
    And Wait for update of dom-online-packages Dbs
    And wait for sync status '2' and core status '2'

#    Then the database table 'dom_online_package.dom_online_package' should contain a row with values in '<test_folder>/dom-online-package-service/POST_onlinepackages/then/dom-online-packages_db/dom_online_package_withRevision.json'
#    And the database table 'dom_online_package.dom_online_package_resource' should contain a row with values in '<test_folder>/dom-online-package-service/POST_onlinepackages/then/dom-online-packages_db/dom_online_package_resource_id2.json'
#    And the database table 'dom_content.dom_database_resource' should contain a row with values in '<test_folder>/dom-online-package-service/POST_onlinepackages/then/oa-vehicle-backend_db/dom-content-database-resource_id2.json'
#    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-online-packages/3/dom-content-data.db'
#    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/dom-online-package-service/POST_onlinepackages/then/Element_dom-content-data-db_Count.json'
#    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/dom-online-package-service/POST_onlinepackages/then/Node_dom-content-data-db_Count.json'
#    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/dom-online-package-service/POST_onlinepackages/then/NodeElement_dom-content-data-db_Count.json'
#    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/dom-online-package-service/POST_onlinepackages/then/ElementKeyword_dom-content-data-db_Count.json'
#    And the sql-lite database 'dom-content-data' table 'SYS_PARAM' should contain a rows with values '<test_folder>/dom-online-package-service/POST_onlinepackages/then/dom-content-data_sys_param.json'
#    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-online-packages/3/instr.db'
#    And the number of entries in the sql-lite database 'instr' should be as specified in file '<test_folder>/dom-online-package-service/POST_onlinepackages/then/instr_db/instr_Count.json'

    Examples:
      | test_folder | Superxml_foldername                                           | job_name                                                 | clean |
      | /testData   | standalone-adapter/223.1_KR_MA-KR_HU-KR_NTG7.0_PREMIUM__en_gb | jobfc9c272f67df17b30ac2a8ea792f63e0_unique_deeplinks.xml | true  |


  Scenario Outline: GET onlinepackages/{id} response has the 'state of construction' alongside with the other n-tuple values, if available
    When the GET onlinepackages request is made with url 'http://dom-online-package-service-tsy-integration.ba-ntg7:8080/dom-online-package-service/v1/onlinepackages/1' and Request-Id '1234'
    And Verify status code '200' for given request
    And Verify response json with content '<test_folder>/dom-online-package-service/GET_onlinepackages/then/dom-online-packageWithSOCresponse_packageID.json'

    Examples:
      | test_folder |
      | /testData   |


  Scenario Outline: GET onlinepackages response has the 'state of construction' alongside with the other n-tuple values, if available
    And the GET onlinepackages request is made with url 'http://dom-online-package-service-tsy-integration.ba-ntg7:8080/dom-online-package-service/v1/onlinepackages' and Request-Id '1234'
    And Verify status code '200' for given request
    And Verify response json with content '<test_folder>/dom-online-package-service/GET_onlinepackages/then/dom-online-packageWithSOCresponse.json'

    Examples:
      | test_folder | Superxml_foldername                                                 | job_name                                | clean |
      | /testData   | standalone-adapter/223.1_KR_MA-KR_HU-KR_NTG7.0_PREMIUM__en_gb | jobfc9c272f67df17b30ac2a8ea792f63e0_unique_deeplinks.xml | true  |
#
  Scenario Outline:  Get Element with strictValidities and withoutstrictValidities
    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter

    When the GET elements request is made with parameter '<requestParameters>' and Request-Id '1234'

    Then Verify status code '200' for given request
    And Verify response json with content '<test_folder>/<responseJson>'

    Examples:
      | test_folder              |responseJson                              | clean |Superxml_foldername                                        |  job_name                             |requestParameters                                                                                                               |
      #| /testData/GET_elements   |JsonResponse_withStrictValidities.json    | true  |standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE|job9a7e95024a7869740ac27f3a7e5bb76f.xml|elements?format=obj&fields=elementId,language,locale,elementType&strictValidities=true&stateOfConstruction=0e1&paID=pa180553    |
      | /testData/GET_elements   |JsonResponse_withOutStrictValidities.json | true  |standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE|job9a7e95024a7869740ac27f3a7e5bb76f.xml|elements?format=obj&fields=elementId,language,locale,elementType&paId=pa180553&stateOfConstruction=0e1                          |



  Scenario Outline: Verify dom-content-service retry mechanism when uploading online package data (dom-content-data.db and instr.db) to Artifactory fails

    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'Masterdata Query Service' is available
    And the 'BA-platform' is available
    And the 'dom-online-package' is available
    And the configmap 'dom-content-service-tsy-integration-configmap' has the property 'artifactory.url' value set to 'http://artifactory:8081/artifactorytest' in 'application.properties'
    And the deployment 'dom-content-service-tsy-integration' is restarted

    When the POST onlinepackages request is made with request body '<test_folder>/when/POST_DomOnlinePackage_withSOCrequest.json' and parameter '<pathParameter>'
    And Wait for update of dom-online-packages Dbs

    Then Verify status code '202' for given request
    And Verify response json with content '<test_folder>/then/response_json_validation/response4.json'
    And Verify '/dom-online-packages/3/instr.db' dbs are not present in artifactory
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-online-packages/3/dom-content-data.db'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/Element_dom-content-data-db_Count.json'
    And the sql-lite database 'dom-content-data' table 'ELEMENT' should contain a rows with values '<test_folder>/then/dom-content-data_db/element_instruction.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/Node_dom-content-data-db_Count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/NodeElement_dom-content-data-db_Count.json'
    And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/ElementKeyword_dom-content-data-db_Count.json'
    And the sql-lite database 'dom-content-data' table 'SYS_PARAM' should contain a rows with values '<test_folder>/then/dom-content-data_db/dom-content-data_sys_param.json'
    And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-online-packages/3/instr.db'
    And the number of entries in the sql-lite database 'instr' should be as specified in file '<test_folder>/then/instr_db/instr_Count.json'
    #And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/log_dom_content_service_retry_artifactory_upload.txt'
    And the configmap 'dom-content-service-tsy-integration-configmap' has the property 'artifactory.url' value set to 'http://artifactory:8081/artifactory' in 'application.properties'
    And the deployment 'dom-content-service-tsy-integration' is restarted

    Examples:
      | test_folder                                              | Superxml_foldername                                           | job_name                                                 | clean | pathParameter  |
      | /testData/dom-online-package-service/POST_onlinepackages | standalone-adapter/223.1_KR_MA-KR_HU-KR_NTG7.0_PREMIUM__en_gb | jobfc9c272f67df17b30ac2a8ea792f63e0_unique_deeplinks.xml | true  | onlinepackages |
