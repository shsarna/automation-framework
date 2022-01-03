#Archived for DDIBA-13286
# @SP_67_US_8772_TEST_DDIBA_11413_test
Feature: GetInitialData_OnlineFacade
  # Pre condion ----edit dom-online-facade-tsy-integration-configmapchange for  mock.state.of.construction as mock.state.of.construction=
  Scenario Outline: DomOnlineFacade_GetInitialData withSOC


    And the GET getInitialData request is made with VIN number 'WDD2231631A000225' and Request-Id '12345' and parameter 'getInitialData'
    And Verify status code '200' for given request

   #-------------------- And verify Dom online db connecton---------------------------------------------------------------------
    Then the database table 'dom_online_package.dom_online_package' should contain a row with values in '<test_folder>/dom_online_Packages_getInitialdata/dom_online_package.json'
    Then the database table 'dom_online_package.dom_online_package_resource' should contain a row with values in '<test_folder>/dom_online_Packages_getInitialdata/dom_online_package_resource.json'

  #-------------------- dom_content_package table ---------------------------------------------------------------------------------------------
    Then the database table 'dom_content.dom_database_resource' should contain a row with values in '<test_folder>/dom_online_Packages_getInitialdata/dom-content-database-resource.json'
    And Verify response json for businessLine '\"p\"' and deviceModel 'ntg7.0' and deviceModelMarket 'hu-kr' and deviceModelVariant 'premium' and deviceName 'hu' and market 'kr' and vehicleLine '223.1' and vehicleMarket 'ma-kr' and message 'Successfully retrieved initial data.'




    Examples:
      | test_folder    | Superxml_foldername                                             | job_name                                | clean |
      | /testData      | standalone-adapter/223.1_KR_MA-KR_HU-KR_NTG7.0_PREMIUM__en_gb   | jobfc9c272f67df17b30ac2a8ea792f63e0.xml | true  |
