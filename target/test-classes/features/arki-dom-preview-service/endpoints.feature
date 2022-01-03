Feature: Verify endpoints for arki-dom-preview-service

  @SP80_US_12624_DDIBA-13824 @DDIBA-13824
  Scenario Outline: Verify actuator endpoints for arki-dom-preview-service

    Given the 'arki-dom-preview-service' is available

    When arki-dom-preview service endpoint '<endpoint>' is called

    Examples:
      | endpoint            |
      | actuator            |
      | actuator/info       |
      | actuator/prometheus |
      | actuator/shutdown   |


  Scenario Outline: Verify POST /previews endpoint for arki-dom-preview-service

    Given the 'arki-dom-preview-service' is available

    When arki-dom-preview service endpoint preview is called with request body '<test_folder>/when/postPreview.json'

    Then verify response json of dom preview service with content '<test_folder>/then/responsePostPreview.json'

    Examples:
      | test_folder                                  |
      | /testData/arki-dom-preview-service/endpoints |


  Scenario Outline: Verify GET /previews endpoint for arki-dom-preview-service

    Given the 'arki-dom-preview-service' is available

    When arki-dom-preview service endpoint 'previews' is called

    Then verify response json of dom preview service with content '<test_folder>/then/responseGetPreview.json'

    Examples:
      | test_folder                                  |
      | /testData/arki-dom-preview-service/endpoints |