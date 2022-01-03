@RegressionAll @Regression_Set2 @SP_68_US_6821_11731
#//Below mentioned tag is for hooks
@redeployOaVeBackendDb @exe141021
Feature: DOM Content Service - Inform subscribers after content sync for error message (oa-content service need to be down)

  Scenario Outline: DOM Content Service - Inform subscribers for Resource not changed , updated and deleted after content sync
    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'dom-content-service' is available
    And database 'oa-ve-backend-db' contains '<test_folder>/given/oa-vehicle-backend-db/delete_column_element_type_from_source.sql' data

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 3
      | Superxml_foldername   | job_name   |
      | <Superxml_foldername> | <job_name> |
    And OA-Core rabbitMQ Platform publishes the notification message '<test_folder>/then/oa-content-v1-bulk_message.json' in the exchange
    And wait for 60 seconds

    Then dom-content-service publishes the sync message '<test_folder>/then/<message>' in the queues bind to 'dom-content-v1-contentsync_exchange'
    #And the database table 'dom_content.dom_content_sync' should contain a row with values in '<test_folder>/when/dom_content_sync.json'

    Examples:
      | test_folder                                | Superxml_foldername              | job_name                                   | message                                           |
      | /testData/inform_subscribers_after_content | standalone-adapter/ObsoleteFirst | 586f397bd814790ac0a8c00145e5a56d_super.xml | dom_contentsync_exchange_message_ErrorStatus.json  |


