@RegressionAll @Regression_Set1
@SP70_US_11572 @DDIBA-12136

Feature:GET/containers response contains modification timestamp of a container resource

  Scenario Outline: GET/containers response contains modification timestamp of a container resource

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And database 'dom-container-db' contains '<test_folder>/given/dom-container-db/dom_container_insert_data.sql' data
    And the GET container request is made with parameter '<requestParameters>' and Request-Id '1234'

    Then Verify response json with content '<test_folder>/then/<response_with_modification_timeStamp>.json'

  Examples:
    | test_folder                       |requestParameters                           |response_with_modification_timeStamp    |
    | /testData/dom-container-service   |containers                                  |getContainers_unspecific_response       |
    | /testData/dom-container-service   |containers/17                               |getContainers_specific_response         |
    | /testData/dom-container-service   |containers?fields=containerId&&exclude=1    |getContainers_exclude_response          |
    | /testData/dom-container-service   |containers?fields=containerId               |getContainers_fields_response           |


