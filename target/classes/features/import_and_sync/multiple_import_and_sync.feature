@RegressionAll @Regression_Set1 @DDIBA-10157 @DDIBA-10159
Feature: Import and sync in parallel

  Scenario Outline: Import and sync in parallel

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' '<clean>'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the 'BA-platform' is available

    When the imports are triggered and wait for 3 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername                                         | job_name                                                |
      | standalone-adapter/Media_007.1_MA-CN__Premium_de_de         | jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml |
      | standalone-adapter/DASTI-007.1-ECE_ROW-NTG7.0-Premium-de_DE | job9a7e95024a7869740ac27f3a7e5bb76f.xml                 |
      | standalone-adapter/Media_007.1_MA-CN__Premium_de_de_gen20x  | jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml |



    Examples:
      | clean |
      | true  |
