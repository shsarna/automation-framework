@RegressionAll @Regression_Set1 @SP_68_US_6821_Resource_created  @DDIBA-11727

Feature: DOM Content Service - Inform subscribers after content sync

  Scenario Outline: DOM Content Service - Inform subscribers for Resource created (having status 1 im message body) after content sync

    Given the STD file '<Superxml_foldername>/<job_name>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' '<clean>'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the 'BA-platform' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername   | job_name   |
      | <Superxml_foldername> | <job_name> |

    Then dom-content-service publishes the sync message '<test_folder>/then/dom_contentsync_exchange_message.json' in the queues bind to 'dom-content-v1-contentsync_exchange'


    Examples:
      | test_folder                                | Superxml_foldername              | job_name                                   | clean |
      | /testData/inform_subscribers_after_content | standalone-adapter/ObsoleteFirst | 586f397bd814790ac0a8c00145e5a56d_super.xml | true  |


