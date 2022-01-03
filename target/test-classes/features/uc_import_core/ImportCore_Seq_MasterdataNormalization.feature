@RegressionAll @Regression_Set1
Feature: Masterdata normalization - sequential scaled

  @DDIBA-10686
  Scenario Outline: Verify the SuperXML import is aborted when Validity could not be found in master system
    Given all the STD files are available at standalone adapter
      | Superxml_foldername   | job_name                                |
      | <Superxml_foldername> | job01c4064695690c980ac2a8de311b842f.xml |
    And all the konverter files are available at standalone adapter
      | Superxml_foldername          | konverter_name |
      | <Superxml_foldername>/config | konverter.xml  |
    And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the service 'xxxml-import-service' is available
    And the service 'oa-content-service' is available
    And the database 'oa import db' is available
    And the database 'oa content db' is available
    And the service 'Masterdata Query Service' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 3 and sync status as 0
      | Superxml_foldername   | job_name                                |
      | <Superxml_foldername> | job01c4064695690c980ac2a8de311b842f.xml |

    Then the database table 'xxxml_v10_import.xxxml_import' should contain all the rows
      | /testData/uc_import_core/masterDataNormalization/then/noDataProvided/unsuccessfull_xxxml_import1.json |


    Examples:
      | Superxml_foldername                                                                            |
      | standalone-adapter/masterDataNormalization/noDataProvided/device_market_nodataprovided         |
      | standalone-adapter/masterDataNormalization/noDataProvided/device_model_nodataprovided          |
      | standalone-adapter/masterDataNormalization/noDataProvided/model_variant_nodataprovided         |
      | standalone-adapter/masterDataNormalization/noDataProvided/vehicle_line_nodataprovided          |
      | standalone-adapter/masterDataNormalization/noDataProvided/vehicle_market_nodataprovided        |
      | standalone-adapter/masterDataNormalization/noDataProvided/state_of_construction_nodataprovided |
      | standalone-adapter/masterDataNormalization/noDataProvided/market_nodataprovided                |

