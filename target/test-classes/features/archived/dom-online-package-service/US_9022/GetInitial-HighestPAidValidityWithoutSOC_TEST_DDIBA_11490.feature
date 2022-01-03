#Archived for DDIBA-13286
#
# @SP_67_US_9022_TEST_DDIBA_11490

 # Pre condion ----edit dom-online-facade-tsy-integration-configmapchange for  mock.state.of.construction as mock.state.of.construction=

Feature: Verify DOM Content Service not considering new validity parameter 'state of construction' while creating resource dom_content.db

 Scenario Outline:  POST onlinepackages without request parameter stateOfConstruction

  Given the Superxml file 'standalone-adapter/PAID-PA180564-223.1_KR_MA-KR_HU-KR_NTG7.0_PREMIUM__de_de/job95f3c7e567dec5d90ac2a8d87503d92b.xml' is available at standalone adapter
  And the Superxml file 'standalone-adapter/PAID-223.1_KR_MA-KR_HU-KR_NTG7.0_PREMIUM__de_de/job95f3c7e567dec5d90ac2a8d87503d92b.xml' is available at standalone adapter
  #-----------------dom online package db and OA-VehicleBackend db need to be clean to check validities--------------------------
  And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' '<clean>'
  And the 'xxxml-import-service' is available
  And the 'oa-content-service' is available
  And the 'dom-content-service' is available
  And the 'Masterdata Query Service' is available
  And the 'BA-platform' is available
  And the 'dom-online-package' is available
  And the command convert is executed at standalone adaptor with argument './standalone-adapter/PAID-PA180564-223.1_KR_MA-KR_HU-KR_NTG7.0_PREMIUM__de_de/job95f3c7e567dec5d90ac2a8d87503d92b.xml'
  And wait for sync status '2' and core status '2'
  And the command convert is executed at standalone adaptor with argument './standalone-adapter/PAID-223.1_KR_MA-KR_HU-KR_NTG7.0_PREMIUM__de_de/job95f3c7e567dec5d90ac2a8d87503d92b.xml'
  And wait for sync status '2' and core status '2'

  When the GET getInitialData request is made with VIN number '<VIN>' and Request-Id '12345'

  Then Verify status code '200' for given request
  And Wait for update of dom-online-packages Dbs
  And Verify response json for businessLine '\"p\"' and deviceModel 'ntg7.0' and deviceModelMarket 'hu-kr' and deviceModelVariant 'premium' and deviceName 'hu' and market 'kr' and vehicleLine '223.1' and vehicleMarket 'ma-kr' and message 'Successfully retrieved initial data.'
  And dom-online-package publishes the online package creation message in the queues bind to 'dom-online-package-v1-onlinepackage_exchange-tsy-integration'
  And dom-content-service publishes the database resource creation message in the queues bind to 'dom-content-v1-database_exchange-tsy-integration'
  And the database table 'dom_online_package.dom_online_package' should contain a row with values in '<test_folder>/then/dom-online-packages_db/dom_online_package.json'
  And the database table 'dom_online_package.dom_online_package_resource' should contain a row with values in '<test_folder>/then/dom-online-packages_db/dom_online_package_resource.json'
  And the database table 'dom_content.dom_database_resource' should contain a row with values in '<test_folder>/then/oa-vehicle-backend_db/dom-content-database-resource.json'
  And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-online-packages/1/dom-content-data.db'
  And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/Element_dom-content-data-db_Count.json'
  And the sql-lite database 'dom-content-data' table 'ELEMENT' should contain a rows with values '<test_folder>/then/dom-content-data_db/element_description.json'
  And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/Node_dom-content-data-db_Count.json'
  And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/NodeElement_dom-content-data-db_Count_de_de.json'
  And the number of entries in the sql-lite database 'dom-content-data' should be as specified in file '<test_folder>/then/dom-content-data_db/ElementKeyword_dom-content-data-db_Count_de_de.json'
  And the sql-lite database 'dom-content-data' table 'SYS_PARAM' should contain a rows with values '<test_folder>/then/dom-content-data_db/dom-content-data_sys_param.json'
  And Cos download file from bucket 'ba-ntg7-test-resource-storage' and filepath 'dom-online-packages/1/instr.db'
  And the number of entries in the sql-lite database 'instr' should be as specified in file '<test_folder>/then/instr_db/instr_Count_de_de.json'


  Examples:
   | test_folder                                                | clean |   VIN            |
   | /testData/dom-online-package-service/POST_onlinepackages   | true  | WDD2231631A000225|
