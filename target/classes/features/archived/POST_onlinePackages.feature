#Archived for DDIBA-13286
# @onlinepackage

Feature: dom-content-service retry mechanism when uploading online package data to IBM COS

  Scenario Outline: Verify dom-content-service retry mechanism when uploading online package data (dom-content-data.db and instr.db) to IBM COS fails
    Given the Superxml file '<Superxml_foldername>/<job_name>' is available at standalone adapter
  #And the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' '<clean>'
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
# And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
  And the 'BA-platform' is available
  And the 'dom-online-package' is available
#
#When the command 'convert' is executed at standalone adaptor with argument './<Superxml_foldername>/<job_name>'
#   # And oa-content-service publishes the bulk message in the queues bind to 'oa-content-v1-bulk_exchange'
#    And the sync is finished

    #import status in xxxml_import table
    #And the database table 'xxxml_v10_import.xxxml_import' should contains a row with values in '<test_folder>/COS_RetryMechanism_Services/xxxml_import_KR_EN_GB.json'
    #And IBM COS is unavailable while uploading the package data #Manual(Put Invalid Secret for the COS bucket NTG7 context)

  When the DomOnlinePackage POST packages request is made with request body '<test_folder>/COS_RetryMechanism_Services/DomOnlinePackage_post_packages_request.json'



#  Validations
#  dom_online_package table -
 And verify Dom online db connecton

And the number of entries in the database table 'dom_online_package.dom_online_package_resource' should be as specified in the file '<test_folder>/COS_RetryMechanism_Services/dom_online_package_resource_Count.json'
   Then the database table 'dom_online_package.dom_online_package' should contain a row with values in '<test_folder>/COS_RetryMechanism_Services/dom_online_package_Error.json'
#    dom_content_package table -
    Then the database table 'dom_content.dom_database_resource' should contain a row with values in '<test_folder>/COS_RetryMechanism_Services/dom-content-database-resource.json'

#  MQ message verification
  #And dom-online-package-service publishes the sync message in the queues bind to 'dom-online-package-v1-onlinepackage_exchange'
   And dom-content-service publishes the sync message in the queues bind to 'dom-content-v1-database_exchange'
  #And the online package creation failure MQ message '<test_folder>/when/mq_messages/dom-content-v1-database_creation_failed.json' is received from exchange 'dom-online-package-v1-onlinepackage_exchange'
#    And the db creation failure MQ message '<test_folder>/then/mq_messages/dom-content-v1-database_creation_failed.json' is received from exchange 'dom-content-v1-database_exchange'
#
#  log validation - Manual
#  Validate logs for error message and Retry counts while uploading Online package Db artefacts to IBM COS failed
#    And dom-content-service logs has details of the error message of failure and corresponding retry counts when uploading online package data (dom-content-data.db/instr.db) to COS failed
#    And dom-online-package-service logs has details of the error message of failure of online package creation





  Examples:
   | test_folder | Superxml_foldername                                                 | job_name                                | clean |
      | /testData   | standalone-adapter/223.1_KR_MA-KR_HU-KR_NTG7.0_PREMIUM__en_gb       | jobfc9c272f67df17b30ac2a8ea792f63e0.xml | true  |

