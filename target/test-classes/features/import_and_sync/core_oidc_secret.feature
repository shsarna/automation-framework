@RegressionAll @SemiAutomated
Feature: OIDC Secret


  @DDIBA-13708 @DDIBA-13721 @SP79_US_13187_TEST_13708 @manual
  Scenario Outline: Verify the xxxml service behaviour during import process after OIDC is integrated in xxxml import service

    And the configmap 'standalone-adapter-configmap' has the property 'BATCH_CALLBACK_SERVLET_PATH' value set to 'https://oacore.om-systems-test.cloud.corpintra.net/diba-standalone-proxy/CallbackServlet/' in 'application.properties'
    And the configmap 'standalone-adapter-configmap' has the property 'BATCH_REST_ENDPOINT' value set to 'https://oacore.om-systems-test.cloud.corpintra.net/xxxml-import-service/v1/arki-cms-imports' in 'application.properties'
    And the deployment 'standalone-adapter' is restarted

#    And the configmap 'xxxml-import-service-configmap' has the property 'spring.datasource.url' value set to 'jdbc:postgresql://6f89183d-63b2-45cb-847c-d1db01518253.bc28ac43cf10402584b5f01db462d330.private.databases.appdomain.cloud:30104/oa_import_db-tsy-integration?ssl=true&sslmode=verify-full&sslrootcert=/etc/ssl/icd.crt' in 'application.properties'
#    And the deployment 'xxxml-import-service' is restarted

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the Superxml file '<superxml>/<jobFile>' is available at standalone adapter
    And the 'xxxml-import-service' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername | job_name  |
      | <superxml>          | <jobFile> |

    Then the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/import-db/xxxml_import_ntg7.json'
    And the logs of 'xxxml-import-service' are similar with file '<test_folder>/then/logs_validation/log_xxxml_import_service_oidc_success.txt'
    And the logs of 'standalone-adapter/data/log/batch.log' are similar with file '<test_folder>/then/logs_validation/log_standalone_adatper_oidc_success.txt'

    And the configmap 'standalone-adapter-configmap' has the property 'BATCH_CALLBACK_SERVLET_PATH' value set to 'http://standalone-adapter-tooling-sync:8090/diba-standalone-proxy/CallbackServlet/' in 'application.properties'
    And the configmap 'standalone-adapter-configmap' has the property 'BATCH_REST_ENDPOINT' value set to 'http://xxxml-import-service-tooling-sync:8080/xxxml-import-service/v1/arki-cms-imports' in 'application.properties'
    And the deployment 'standalone-adapter' is restarted

#    And the configmap 'xxxml-import-service-configmap' has the property 'spring.datasource.url' value set to 'jdbc:postgresql://6f89183d-63b2-45cb-847c-d1db01518253.bc28ac43cf10402584b5f01db462d330.private.databases.appdomain.cloud:30104/oa_import_db?ssl=true&sslmode=verify-full&sslrootcert=/etc/ssl/icd.crt' in 'application.properties'
#    And the deployment 'xxxml-import-service' is restarted


    Examples:
      | superxml                                            | jobFile                                                 | test_folder                    |
      | standalone-adapter/Media_007.1_MA-CN__Premium_de_de | jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml | /testData/import_and_sync/then |

  @DDIBA-13709 @DDIBA-13722 @SP79_US_13187_TEST_13709 @manual
  Scenario Outline: Verify import process after OIDC is integrated in xxxml import service when unauthorized request reaches XXXML Import Service
    #Manually change the standalone adapter OIDC secret from IBM Cloud
    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the Superxml file '<superxml>/<jobFile>' is available at standalone adapter
    And the 'xxxml-import-service' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 3 and sync status as 0
      | Superxml_foldername | job_name  |
      | <superxml>          | <jobFile> |


    Then the logs of 'standalone-adapter/data/log/batch.log' are similar with file '<test_folder>/then/logs_validation/oidc_error_log_standalone_adapter.txt'

    Examples:
      | superxml                                            | jobFile                                                 | test_folder                    |
      | standalone-adapter/Media_007.1_MA-CN__Premium_de_de | jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml | /testData/import_and_sync/then |
