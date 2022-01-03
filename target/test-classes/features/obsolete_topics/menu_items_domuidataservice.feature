@RegressionAll @Regression_Set1 @DDIBA-11913  @Regression_SP77
Feature: Verify DOM UI Data Service deletes the relation between the PA ID validity and obsolete topic menu item

  Scenario Outline: Verify DOM UI Data Service deletes the relation between the PA ID validity and obsolete menu item AND maps it to new artificial PA ID

    Given the Superxml file 'standalone-adapter/ObsoleteMenu_007.1_MA-CN__Prem_de_de/jobab1d30dabe36158a354aeb2c2e4c9c72.xml' is available at standalone adapter
    And the Superxml file 'standalone-adapter/ObsoleteMenu_007.1_MA-CN__Prem_de_de/Deleted_OneQuickstart_Leaf_jobab1d30dabe36158a354aeb2c2e4c9c72.xml' is available at standalone adapter
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername                                     | job_name                                                           |
      | standalone-adapter/ObsoleteMenu_007.1_MA-CN__Prem_de_de | jobab1d30dabe36158a354aeb2c2e4c9c72.xml                            |

    When the imports are triggered and wait for 2 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername                                     | job_name                                                           |
      | standalone-adapter/ObsoleteMenu_007.1_MA-CN__Prem_de_de | Deleted_OneQuickstart_Leaf_jobab1d30dabe36158a354aeb2c2e4c9c72.xml |

    Then the number of entries in the database table 'domui_data_service.n_tuple' should be as specified in the file '<test_folder>/then/domui-data-db/deleted_OneQuick_start_n_tuple-count.json'
    And the number of entries in the database table 'domui_data_service.validity_n_tuple' should be as specified in the file '<test_folder>/then/domui-data-db/validity_n_tuple_obsolete-count.json'
    And the number of entries in the database table 'domui_data_service.validity_n_tuple' should be as specified in the file '<test_folder>/then/domui-data-db/validity_n_tuple_artificialPAID-count_menuitem.json'
    And the number of entries in the database table 'domui_data_service.validity_n_tuple' should be as specified in the file '<test_folder>/then/domui-data-db/validity-count.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/<resource_text_artificial>.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/<resource_text_obsolete>.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/<resource_menuitem_artifial>.json'
    And the database table 'domui_data_service.resource' should contain a row with values in '<test_folder>/then/domui-data-db/<resource_menuitem_obsolete>.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_text' should be as specified in the file '<test_folder>/then/domui-data-db/obsolete_resource_domui_text-count.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_text' should be as specified in the file '<test_folder>/then/domui-data-db/artificial_resource_domui_text-count.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_menu_item' should be as specified in the file '<test_folder>/then/domui-data-db/obsolete_resource_domui_menu_item.json'
    And the number of entries in the database table 'domui_data_service.resource_domui_menu_item' should be as specified in the file '<test_folder>/then/domui-data-db/artificial_resource_domui_menu_item.json'


    Examples:
      | test_folder               | resource_text_artificial                 | resource_text_obsolete                   | resource_menuitem_artifial                   | resource_menuitem_obsolete                   |
      | /testData/obsolete_topics | resource_text_pa000000_deletedQuickStart | resource_text_pa200033_deletedQuickStart | resource_menuitem_pa000000_deletedQuickStart | resource_menuitem_pa200033_deletedQuickStart |

















