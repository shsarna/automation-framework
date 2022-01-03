@RegressionAll @Regression_Set1  @DDIBA-11181 @pbd
Feature: Verify DOM UI Data Service deletes the relation between the PA ID validity and obsolete warning message resource

  Scenario Outline: Verify DOM UI Data Service deletes the relation between the PA ID validity and obsolete warning message resource AND maps it to new artificial PA ID

    Given the Superxml file 'standalone-adapter/ARKI_WebFS_206.0_ECE-ROW_MA-ECE-ROW_HU-ECE-ROW_NTG7.0_HIGH__en_gb/job4fce768f95cfc3850ac2a8ea3c8ecd8b.xml' is available at standalone adapter
    And the Superxml file 'standalone-adapter/DEL_ARKI_WebFS_206.0_ECE-ROW_MA-ECE-ROW_HU-ECE-ROW_NTG7.0_HIGH__en_gb/DEL_job4fce768f95cfc3850ac2a8ea3c8ecd8b.xml' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' '<clean>'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername                                                                      | job_name                                    |
      | standalone-adapter/ARKI_WebFS_206.0_ECE-ROW_MA-ECE-ROW_HU-ECE-ROW_NTG7.0_HIGH__en_gb     | job4fce768f95cfc3850ac2a8ea3c8ecd8b.xml     |

    And the imports are triggered and wait for 2 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername                                                                      | job_name                                    |
      | standalone-adapter/DEL_ARKI_WebFS_206.0_ECE-ROW_MA-ECE-ROW_HU-ECE-ROW_NTG7.0_HIGH__en_gb | DEL_job4fce768f95cfc3850ac2a8ea3c8ecd8b.xml |

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/then/import-db/xxxml_import_pa190548.json'
    And the number of entries in the database table 'domui_data_service.n_tuple' should be as specified in the file '<test_folder>/then/domui-data-db/n_tuple-count.json'
    And the number of entries in the database table 'domui_data_service.validity_n_tuple' should be as specified in the file '<test_folder>/then/domui-data-db/validity_n_tuple_obsolete-count.json'
    And the number of entries in the database table 'domui_data_service.validity_n_tuple' should be as specified in the file '<test_folder>/then/domui-data-db/validity_n_tuple_artificialPAID-count.json'
    And the number of entries in the database table 'domui_data_service.validity' should be as specified in the file '<test_folder>/then/domui-data-db/validity-count_test11181.json'
    And the number of entries in the database table 'domui_data_service.resource' should be as specified in the file '<test_folder>/then/domui-data-db/resource_warningMessage_latest.json'
    And the number of entries in the database table 'domui_data_service.resource' should be as specified in the file '<test_folder>/then/domui-data-db/resource_text_warningMessage_latest.json'
    And the number of entries in the database table 'domui_data_service.resource' should be as specified in the file '<test_folder>/then/domui-data-db/resource_obsolete_text_warningMessage_Count.json'
    And the number of entries in the database table 'domui_data_service.resource' should be as specified in the file '<test_folder>/then/domui-data-db/resource_obsolete_warningMessage.json'

    Examples:
      | test_folder               | clean |
      | /testData/obsolete_topics | true  |

   