#Archived for DDIBA-13286
#
# @DDIBA-11487
Feature: Verify GET/elements response data with query parameter SOC

  Scenario Outline:  Get Element with strictValidities and withoutstrictValidities
    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' '<clean>'
    And the command convert is executed at standalone adaptor with argument './<Superxml_foldername>/<job_name>'
    And wait for sync status '2' and core status '2'

    When the GET elements request is made with parameter '<requestParameters>' and Request-Id '1234'

    Then Verify status code '200' for given request
    And Verify response json with content '<test_folder>/<responseJson>'

    Examples:
      | test_folder            | responseJson                              | clean | Superxml_foldername                                         | job_name                                | requestParameters                                                                                                            |
      | /testData/GET_elements | JsonResponse_withStrictValidities.json    | true  | standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE | job9a7e95024a7869740ac27f3a7e5bb76f.xml | elements?format=obj&fields=elementId,language,locale,elementType&strictValidities=true&stateOfConstruction=0e1&paID=pa180553 |
      | /testData/GET_elements | JsonResponse_withOutStrictValidities.json | true  | standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE | job9a7e95024a7869740ac27f3a7e5bb76f.xml | elements?format=obj&fields=elementId,language,locale,elementType&paId=pa180553&stateOfConstruction=0e1                       |



