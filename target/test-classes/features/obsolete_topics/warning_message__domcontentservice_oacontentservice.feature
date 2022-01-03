@RegressionAll @Regression_Set1 @regressionObsoleteTopic_TEST_11145_TEST_11146 @US_DDIBA_11797 @DDIBA_12396
Feature: Verify obsolete topics and media objects are identified by OA-Content and dom-Content services

  Scenario Outline: Verify obsolete topics and media objects are identified by OA-Content service and relation with PAID are deleted for two imports of same PA-ID and Verify DOM Content Service deletes the mapping from node_validity table, between PAID and node for obsolete topics And maps the artificial PAID to obsolete topics' node


    Given the Superxml file 'standalone-adapter/ObsoleteFirst/586f397bd814790ac0a8c00145e5a56d_super.xml' is available at standalone adapter
    And the Superxml file 'standalone-adapter/ObsoleteSecond/b742a389dbbfd7d4c0a8c001333e4ead_super.xml' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' '<clean>'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername               | job_name                                   |
      | standalone-adapter/ObsoleteFirst  | 586f397bd814790ac0a8c00145e5a56d_super.xml |

    When the imports are triggered and wait for 2 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername               | job_name                                   |
      | standalone-adapter/ObsoleteSecond | b742a389dbbfd7d4c0a8c001333e4ead_super.xml |


    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import.json'
    And the database table 'oa_content.object' should contain a row with values in '<test_folder>/then/oa-backend-db/object.json'
    And the number of entries in the database table 'oa_content.relation' should be as specified in the file '<test_folder>/then/oa-backend-db/relation_obsoleteTopic_count.json'
    And the database table 'oa_content.pub_edition' should contain a row with values in '<test_folder>/then/oa-backend-db/pub_edition_data.json'
    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/validity.json'
    And the number of entries in the database table 'dom_content.node_validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/node_validity_dummyPAID-count.json'
    And the number of entries in the database table 'dom_content.node_validity' should be as specified in the file '<test_folder>/then/oa-vehicle-backend-db/node_validity_obsolete_topic_oldPAID-count.json'
    And Cos download file from core bucket 'ba-oacore-test-logfiles' and filepath 'protocol_2.json'
    And file content of cos file 'protocol_2.json' from bucket 'ba-oacore-test-logfiles' has the same content as '<test_folder>/then/cos_files/protocol.json'

    Examples:
      | test_folder               | clean |
      | /testData/obsolete_topics | true  |

