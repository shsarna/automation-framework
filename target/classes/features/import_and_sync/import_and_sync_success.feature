@RegressionAll @Regression_Set1
Feature: Import and Sync Success

  @DDIBA-10422 @DDIBA-10524 @DDIBA-10516 @DDIBA-10622 @DDIBA-10635 @DDIBA-10637
    @DDIBA-10646 @DDIBA-10672 @DDIBA-10673 @DDIBA-11164 @DDIBA-11312 @DDIBA-11304 @DDIBA-10729

  Scenario Outline: Automated Regression Tests - Import and Sync

    Given the content of all databases is deleted in order to have empty databases using scripts in '/testData/cleanupDatabases' 'true'
    And the Superxml file '<superxml>/<jobFile>' is available at standalone adapter
    And the 'xxxml-import-service' is available
    And the 'oa-content-service' is available
    And the 'dom-content-service' is available
    And the 'dom-ui-data-service' is available
    And the 'Masterdata Query Service' is available
    And the 'BA-platform' is available

    When the imports are triggered and wait for 1 imports to be successful with core status as 2 and sync status as 2
      | Superxml_foldername | job_name  |
      | <superxml>          | <jobFile> |

    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/disclaimer.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/identifier.txt' in the queues bind to PSE_exchange
    And BA-platform publishes the notification message '/testData/messages_to_publish/dom_content_service/language.txt' in the queues bind to PSE_exchange
    And wait for 75 seconds

    Then oa-content-service publishes the bulk message in the queues bind to 'oa-content-v1-bulk_exchange'
    And oa-content-service publishes the query message in the queues bind to 'oa-content-v1-query_exchange'
    And dom-content-service publishes the sync message in the queues bind to 'dom-content-v1-database_exchange'
    And dom-content-service publishes the Ba-sync message in the queues bind to 'dom-content-v1-basync_exchange'
    And dom-ui-data-service publishes the sync message in the queues bind to 'dom-ui-data-v1-contentsync_exchange'
    And dom-ui-data-service publishes the LanguageList, Identifier and Disclaimer Ba-sync messages in the queues bind to exchanges 'dom-ui-data-v1-basync_exchange'
    And xxxml-import-service publishes sync message in the queues bind to 'xxxml-import-v1-arki4import_exchange'

    And the database table 'xxxml_v10_import.xxxml_import' should contain a row with values in '<test_folder>/import-db/xxxml_import_ntg7.json'

    And the number of entries in the database table 'dom_content.media' should be as specified in the file '<test_folder>/oa-vehicle-backend-db/media_ref_data-count.json'
    And the number of entries in the database table 'dom_content.media' should be as specified in the file '<test_folder>/oa-vehicle-backend-db/ext_media_url_count.json'
    And the number of entries in the database table 'dom_content.media' should be as specified in the file '<test_folder>/oa-vehicle-backend-db/ext_media_filename_count.json'
    And the number of entries in the database table 'dom_content.media_element' should be as specified in the file '<test_folder>/oa-vehicle-backend-db/media_element-count.json'

    And the number of entries in the database table 'oa_content.media_ref_data' should be as specified in the file '<test_folder>/oa-backend-db/media_ref_data-count.json'
    And the number of entries in the database table 'oa_content.media_ref_data' should be as specified in the file '<test_folder>/oa-backend-db/ext_media_url_count.json'
    And the number of entries in the database table 'oa_content.object' should be as specified in the file '<test_folder>/oa-backend-db/object_type_from_source_count.json'
    And the number of entries in the database table 'oa_content.object_payload' should be as specified in the file '<test_folder>/oa-backend-db/object_payload_count.json'
    And the number of entries in the database table 'oa_content.relation' should be as specified in the file '<test_folder>/oa-backend-db/relation_count.json'

    And the database table 'oa_content.state_of_construction' should contain a row with values in '<test_folder>/oa-backend-db/state_of_construction_data.json'
    And the database table 'oa_content.pub_edition' should contain a row with values in '<test_folder>/oa-backend-db/pub_edition_data.json'

    And the database table 'oa_content.object' should contain a row with values in '<test_folder>/oa-backend-db/object5.json'
    And the database table 'oa_content.object' should contain a row with values in '<test_folder>/oa-backend-db/object6.json'
#    And the database view 'oa_content.v_obj_rel_obj' should have all the topics linked (is-valid-for) to new masterdata 'state-of-construction' and 'pa-id'

    And the number of entries in the database table 'dom_content.validity' should be as specified in the file '<test_folder>/oa-vehicle-backend-db/validity_count.json'
    And the database table 'dom_content.validity' should contain a row with values in '<test_folder>/oa-vehicle-backend-db/state_of_construction_data.json'
    And the number of entries in the database table 'dom_content.node_validity' should be as specified in the file '<test_folder>/oa-vehicle-backend-db/node-validity-count.json'

    And the database table 'dom_content.validity' should contain a row with values in '<test_folder>/oa-vehicle-backend-db/pa_id_data.json'

    And the number of entries in the database table 'domui_data_service.validity' should be as specified in the file '<test_folder>/domui-data-db/validity-count.json'
    And the database table 'domui_data_service.validity' should contain a row with values in '<test_folder>/domui-data-db/state_of_construction_data.json'
    And the number of entries in the database table 'domui_data_service.validity_n_tuple' should be as specified in the file '<test_folder>/domui-data-db/n_tuple-count.json'

    And the database table 'domui_data_service.validity' should contain a row with values in '<test_folder>/domui-data-db/pa_id_data.json'


    And the database table 'oa_content.media_ref_data' should contain a row with values in '<test_folder>/oa-backend-db/media_ref_data.json'
    And the database table 'oa_content.object' should contain a row with values in '<test_folder>/oa-backend-db/object_media_hub_arkikipicng.json'
    And the database table 'oa_content.object_payload' should contain a row with values in '<test_folder>/oa-backend-db/object_payload.json'
    And the database table 'oa_content.relation' should contain a row with values in '<test_folder>/oa-backend-db/relation_data.json'
    And the database table 'oa_content.relation_type' should contain a row with values in '<test_folder>/oa-backend-db/relation_type_data.json'

    And validate the content of logfile in cos bucket 'ba-oacore-test-logfiles' for importId 1 has the same content as file '<test_folder>/cos_files/protocol_1.json'

    Examples:
      | superxml                                            | jobFile                                                 | test_folder                    |
      | standalone-adapter/Media_007.1_MA-CN__Premium_de_de | jobab1d30dabe36158a354aeb2c2e4c9c72_unique_deeplink.xml | /testData/import_and_sync/then |