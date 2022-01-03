@RegressionAll @Regression_Set1 @SP75_US_12877_DDIBA_10704_10706

Feature: Publish data via content endpoint of dom content service

  @SP75_US_12877_DDIBA @DDIBA-13197
  Scenario Outline: Verify TopicPilot is published successfully via /content endpoint using mandatory and optional parameters

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'dom-content-service' is available

    When the POST 'content' request is made with request body '<test_folder>/when/topicPilot/POST_content_request_DASTI_data.json'

    Then Verify response json of dom content package with content '<test_folder>/then/json_response/dom_content_response_topic_pilot.txt'
    And Verify headers of dom content package with content '<test_folder>/then/json_response/dom_content_header_topic_pilot.txt'

    And the database table 'dom_content.dom_content_sync' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/dom_content_sync.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/validity-count.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/validity1.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/validity2.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/validity3.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/validity4.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/validity5.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/validity6.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/validity7.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/validity8.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/validity9.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/validity10.json'
    And the number of entries in the database table 'dom_content.node' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/node-count.json'
    And the number of entries in the database table 'dom_content.node_validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/node_validity-count.json'
    And the number of entries in the database table 'dom_content.element' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/element-count.json'
    And the number of entries in the database table 'dom_content.element' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/element-at-a-glance-count.json'
    And the number of entries in the database table 'dom_content.element' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/element-description-count.json'
    And the number of entries in the database table 'dom_content.element' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/element-warn-controls-count.json'
    And the number of entries in the database table 'dom_content.node_element' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/node_element-count.json'
    And the number of entries in the database table 'dom_content.media' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/media-count.json'
    And the number of entries in the database table 'dom_content.media_element' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/mandatory_and_optional/media_element-count.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/dom_content_topicPilot_mandatory_and_optional_param_logs.txt'

    Examples:
      | test_folder               |
      | /testData/import_and_sync |


  @SP75_US_12877 @DDIBA-13206
  Scenario Outline: Verify TopicPilot is published successfully via /content endpoint using minimum required parameters

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'dom-content-service' is available

    When the POST 'content' request is made with request body '<test_folder>/when/topicPilot/POST_content_req_MinRequiredParam.json'

    Then Verify response json of dom content package with content '<test_folder>/then/json_response/dom_content_response_topic_pilot.txt'
    And Verify headers of dom content package with content '<test_folder>/then/json_response/dom_content_header_topic_pilot.txt'

    And the database table 'dom_content.dom_content_sync' should contain a row with values in '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/dom_content_sync.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/validity-count.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/validity1.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/validity2.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/validity3.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/validity4.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/validity5.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/validity6.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/validity7.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/validity8.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/validity9.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/validity10.json'
    And the number of entries in the database table 'dom_content.node' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/node-count.json'
    And the number of entries in the database table 'dom_content.node_validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/node_validity-count.json'
    And the number of entries in the database table 'dom_content.element' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/element-count.json'
    And the number of entries in the database table 'dom_content.node_element' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/topicPilot/minRequiredParam/node_element-count.json'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/dom_content_topicPilot_minRequired_param_logs.txt'

    Examples:
      | test_folder               |
      | /testData/import_and_sync |


  @SP75_US_12877 @DDIBA-13208
  Scenario Outline: Error occurs when mandatory parameters are missing in the post content request

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'dom-content-service' is available

    #the missing parameter is: revision
    When the POST 'content' request is made with request body '<test_folder>/when/topicPilot/POST_content_mandatory_parameter_missing.json'

    Then Verify response status is: 'InternalServerError'
    And the logs of 'dom-content-service' are similar with file '<test_folder>/then/logs_validation/dom_content_topicPilot_mandatory_missing_param_logs.txt'

    Examples:
      | test_folder               |
      | /testData/import_and_sync |