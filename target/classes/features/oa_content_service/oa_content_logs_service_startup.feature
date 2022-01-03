@RegressionAll @Regression_Set1 @SP_72_US_11797 @DDIBA-12398

Feature: oa-content-service console logs after service startup

  Scenario Outline: oa-content-service console logs after service startup
    Given the 'oa-content-service' is available

    When the deployment 'oa-content-service-tsy-integration' is restarted
    And wait for 60 seconds

    Then verify the logs of 'oa-content-service' are similar with file '<test_folder>/then/logs_validation/log_oa_content_service_startup.txt'

    Examples:
      | test_folder                         |
      | /testData/oa_content_service        |


