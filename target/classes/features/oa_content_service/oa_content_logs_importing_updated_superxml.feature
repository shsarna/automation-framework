@RegressionAll @Regression_Set1 @SP_72_US_11797_Test_12396 @exe19Oct2021

Feature: Verify oa-content-service logs for a successful import of updated superxml

  Scenario Outline: Verify oa-content-service logs for a successful import of updated superxml

    Given the Superxml file '<Superxml_foldername1>/<job_name1>' is available at standalone adapter
    And the Superxml file '<Superxml_foldername2>/<job_name2>' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername    | job_name    |
      | <Superxml_foldername1> | <job_name1> |

    When the imports are triggered and wait for 2 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername    | job_name    |
      | <Superxml_foldername2> | <job_name2> |

    Then oa-content-service publishes the bulk message in the queues bind to '/testData/rabbitMqMessages/oa_bulk_updated_import_message.json'
    And oa-content-service publishes the query message in the queues bind to '/testData/rabbitMqMessages/oa_query_updated_import_message.json'

    And the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_obsoleteSecond.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync4.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync5.json'
    And the database table 'oa_content.content_request' should contain a row with values in '<test_folder>/then/oa-backend-db/content_sync6.json'

    Then the logs of 'oa-content-service' are similar with file '<test_folder>/then/logs_validation/log_oa_content_service_import_updated_superxml.txt'
    And validate the content of logfile in cos bucket 'ba-oacore-test-logfiles' for importId 2 has the same content as file '<test_folder>/then/cos_files/protocol_4_ObsoleteFirst.json'

    Examples:
      | test_folder                  | Superxml_foldername1             | job_name1                                  | Superxml_foldername2              | job_name2                                  |
      | /testData/oa_content_service | standalone-adapter/ObsoleteFirst | 586f397bd814790ac0a8c00145e5a56d_super.xml | standalone-adapter/ObsoleteSecond | b742a389dbbfd7d4c0a8c001333e4ead_super.xml |


