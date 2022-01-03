DELETE FROM domui_data_service.request_log WHERE 1=1;
DELETE FROM domui_data_service.validity_n_tuple WHERE 1=1;
DELETE FROM domui_data_service.resource_domui_image WHERE 1=1;
DELETE FROM domui_data_service.resource_domui_language WHERE 1=1;
DELETE FROM domui_data_service.resource_domui_menu_item WHERE 1=1;
DELETE FROM domui_data_service.resource_domui_text WHERE 1=1;
DELETE FROM domui_data_service.resource_domui_valuemapping WHERE 1=1;
DELETE FROM domui_data_service.resource_domui_warningmessage WHERE 1=1;
DELETE FROM domui_data_service.resource WHERE 1=1;
--DELETE FROM domui_data_service.resource_type WHERE 1=1;
DELETE FROM domui_data_service.n_tuple WHERE 1=1;
DELETE FROM domui_data_service.ba_sync WHERE 1=1;
DELETE FROM domui_data_service.content_sync_reference WHERE 1=1;
DELETE FROM domui_data_service.content_sync WHERE 1=1;
DELETE FROM domui_data_service.domui_menu_item WHERE 1=1;
DELETE FROM domui_data_service.domui_image WHERE 1=1;
DELETE FROM domui_data_service.domui_text WHERE 1=1;
DELETE FROM domui_data_service.domui_warningmessage WHERE 1=1;
DELETE FROM domui_data_service.domui_language WHERE 1=1;
DELETE FROM domui_data_service.domui_valuemapping WHERE 1=1;
DELETE FROM domui_data_service.domui_image_key WHERE 1=1;
DELETE FROM domui_data_service.domui_text_key WHERE 1=1;
--DELETE FROM domui_data_service.domui_text_type WHERE 1=1;
--DELETE FROM domui_data_service.domui_valuemapping_type WHERE 1=1;
DELETE FROM domui_data_service.validity WHERE 1=1;

ALTER SEQUENCE domui_data_service.ba_sync_ba_sync_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.content_sync_content_sync_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.content_sync_reference_content_sync_reference_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.domui_image_domui_image_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.domui_image_key_domui_image_key_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.domui_language_domui_language_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.domui_menu_item_domui_menu_item_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.domui_text_domui_text_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.domui_text_key_domui_text_key_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.domui_text_type_domui_text_type_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.domui_valuemapping_domui_valuemapping_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.domui_valuemapping_type_domui_valuemapping_type_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.domui_warningmessage_domui_warningmessage_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.n_tuple_n_tuple_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.request_log_request_log_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.resource_domui_image_resource_domui_image_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.resource_domui_language_resource_domui_language_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.resource_domui_menu_item_resource_domui_menu_item_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.resource_domui_text_resource_domui_text_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.resource_domui_valuemapping_resource_domui_valuemapping_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.resource_domui_warningmessage_resource_domui_warningmessage_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.resource_resource_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.resource_type_resource_type_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.sys_param_sys_param_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.validity_n_tuple_validity_n_tuple_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.validity_type_validity_type_id_seq RESTART WITH 1;
ALTER SEQUENCE domui_data_service.validity_validity_id_seq RESTART WITH 1;