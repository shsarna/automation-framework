@RegressionAll @Regression_Set1 @SP_68_US_6821_test_11727

Feature: DOM Content Service - Inform subscribers after content sync

  Scenario: Pre-conditions
    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the 'BA-platform' is available
    And the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername              | job_name                                   |
      | standalone-adapter/ObsoleteFirst | 586f397bd814790ac0a8c00145e5a56d_super.xml |

  Scenario Outline: DOM Content Service - Inform subscribers for Resource not changed , updated and deleted after content sync

    Given the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/given/xxxml_import.json'
    And the STD file '<Superxml_foldername>/<job_name>' is available at standalone adapter

    When the command convert is executed at standalone adaptor with argument './<Superxml_foldername>/<job_name>'
    And wait for sync status '2' and core status '2'

    Then oa-content-service publishes the bulk message in the queues bind to 'oa-content-v1-bulk_exchange'
    And oa-content-service publishes the query message in the queues bind to 'oa-content-v1-query_exchange'
    And dom-ui-data-service publishes the sync message in the queues bind to 'dom-ui-data-v1-contentsync_exchange'
    And dom-content-service publishes the sync message '<test_folder>/then/<message>' in the queues bind to 'dom-content-v1-contentsync_exchange'

    Examples:
      | test_folder                                | Superxml_foldername               | job_name                                   | message                                                       |
      | /testData/inform_subscribers_after_content | standalone-adapter/ObsoleteSecond | b742a389dbbfd7d4c0a8c001333e4ead_super.xml | dom_contentsync_exchange_message_obsolete_case.json           |
      | /testData/inform_subscribers_after_content | standalone-adapter/ObsoleteFirst  | 586f397bd814790ac0a8c00145e5a56d_super.xml | dom_contentsync_exchange_message_resourceNotChanged_case.json |
      | /testData/inform_subscribers_after_content | standalone-adapter/Update_import  | 586f397bd814790ac0a8c00145e5a56d_super.xml | dom_contentsync_exchange_message_resourceUpdated_case.json    |


