@RegressionAll @Regression_Set1
Feature: Manage different XSLT rules for NTG7 and Gen20x

  @DDIBA-13334 @DDIBA-13464 @DDIBA-13659 @DDIBA-10701 @DDIBA-13807

  Scenario Outline: Verify dom content service uses different XSLTs for NTG7 and Gen20x during synchronization

    Given the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And all the STD files are available at standalone adapter
      | Superxml_foldername | job_name  |
      | <superxml>          | <jobFile> |

    When the command convert is executed at standalone adaptor with argument './<superxml>/<jobFile>'
    And wait for sync status '2' and core status '2'

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '/testData/import_and_sync/then/import-db/<xxxmlJson>'
    And the database table 'dom_content.element' should contain a row with values in '/testData/import_and_sync/then/oa-vehicle-backend-db/dataColumn.json'
    And the database table 'dom_content.element' should contain a row with values in '/testData/import_and_sync/then/oa-vehicle-backend-db/dataColumnWithFigure&Target.json'
    And the database table 'dom_content.element' should contain a row with values in '/testData/import_and_sync/then/oa-vehicle-backend-db/dataColumnWithActionList.json'
    And oa-content-service publishes the bulk message in the queues bind to 'oa-content-v1-bulk_exchange'
    And dom-content-service publishes the sync message in the queues bind to 'dom-content-v1-database_exchange'
    And dom-ui-data-service publishes the sync message in the queues bind to 'dom-ui-data-v1-contentsync_exchange'
    And the number of entries in the database table 'dom_content.element' should be as specified in the file '/testData/import_and_sync/then/oa-vehicle-backend-db/disp_diagnose_count.json'

    Examples:
      | superxml                                                   | jobFile                                                 | xxxmlJson                |
      | standalone-adapter/Media_007.1_MA-CN__Premium_de_de        | jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml | xxxml_import_ntg7.json   |
      | standalone-adapter/Media_007.1_MA-CN__Premium_de_de_gen20x | jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml | xxxml_import_gen20x.json |


  @DDIBA-13554
  Scenario Outline: Verify XSLT of sub element in content page for NTG7 and Gen20x during synchronization

    Given the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And all the STD files are available at standalone adapter
      | Superxml_foldername | job_name  |
      | <superxml>          | <jobFile> |

    When the command convert is executed at standalone adaptor with argument './<superxml>/<jobFile>'
    And wait for sync status '2' and core status '2'

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '/testData/import_and_sync/then/import-db/<xxxmlJson>'
    And the database table 'dom_content.element' should contain a row with values in '/testData/import_and_sync/then/oa-vehicle-backend-db/<expectedjson>'


    Examples:
      | superxml                                                            | jobFile                                 | xxxmlJson                        | expectedjson                   |
      | standalone-adapter/007.1_MA-ECE_ROW_HU-ECE_ROW_Premium_en_GB        | job657e2927b2798ac20ac275c22b1b731a.xml | xxxml_import_ntg7_subxslt.json   | dataColumn_withSub_Ntg7.json   |
      | standalone-adapter/007.1_MA-ECE_ROW_HU-ECE_ROW_Premium_en_GB_gen20x | job552a87ebb26ae8ab0ac275c215775e70.xml | xxxml_import_gen20x_subxslt.json | dataColumn_withSub_Gen20x.json |




