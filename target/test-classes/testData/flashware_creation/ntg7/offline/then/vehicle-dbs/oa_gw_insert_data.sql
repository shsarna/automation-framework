insert into oa_gw_data_service.validity (validity_id, validity_type_id, validity_code)
	values
		(-101, -1, 'p'),				-- business-line
		(-201, -2, '007.0'),			-- vehicle-line
		(-202, -2, '007.1'),			-- vehicle-line
		(-203, -2, '223.0'),			-- vehicle-line
		(-204, -2, '223.1'),			-- vehicle-line
		(-205, -2, '223.9'),			-- vehicle-line
		(-206, -2, '206.0'),			-- vehicle-line
		(-207, -2, '206.1'),			-- vehicle-line
		(-208, -2, '206.2'),			-- vehicle-line
		(-209, -2, '297.1'),			-- vehicle-line
		(-210, -2, '232.4'),			-- vehicle-line
		(-301, -7, 'ntg7.0'),			-- device-model
		(-302, -7, 'Gen20x')			-- device-model
;

insert into oa_gw_data_service.n_tuple (n_tuple_id, n_tuple_name, valid_from, valid_to)
	values
		(-101, 'p|007.x,223.x,206.x,297.x|ntg7.0,Gen20x', '-infinity'::timestamp(6) with time zone, 'infinity'::timestamp(6) with time zone)
;

insert into oa_gw_data_service.validity_n_tuple (validity_n_tuple_id, n_tuple_id, validity_id)
	values
		(-101, -101, -101), -- p
		(-201, -101, -201), -- 007.0
		(-202, -101, -202), -- 007.1
		(-203, -101, -203), -- 223.0
		(-204, -101, -204), -- 223.1
		(-205, -101, -205), -- 223.9
		(-206, -101, -206), -- 206.0
		(-207, -101, -207), -- 206.1
		(-208, -101, -208), -- 206.2
		(-209, -101, -209), -- 297.1
		(-210, -101, -210), -- 232.4
		(-301, -101, -301), -- ntg7.0
		(-302, -101, -302)  -- Gen20x
;

insert into oa_gw_data_service.resource (resource_id, resource_type_id, n_tuple_id, revision, valid_from, valid_to)
	values
		-- OA GW Parameter resource
		(-101, -1, -101, 1, '-infinity'::timestamp(6) with time zone, 'infinity'::timestamp(6) with time zone),
		-- OA GW Schedule resource
		(-102, -2, -101, 1, '-infinity'::timestamp(6) with time zone, 'infinity'::timestamp(6) with time zone)
;

insert into oa_gw_data_service.oagw_parameter (oagw_parameter_id, parameter_name, parameter_value)
	values
		(-101, 'RUNTIME_PROCESSING_INTERVAL', '500'),
		(-102, 'UPDATE_REQUEST_INTERVAL', '604800'),
		(-103, 'REQUEST_MAX', '100'),
		(-104, 'REQUEST_NORM', '75'),
		(-105, 'REQUEST_MAX_RETRY', '3'),
		(-106, 'REQUEST_TIMEOUT', '300'),
		(-107, 'REQUEST_PENDING_TIMEOUT', '600'),
		(-108, 'URL_DOM_ONLINE_FACADE', '/dom-online-facade/v1/'),
		(-109, 'URL_CDN', '/'),
		(-110, 'OA_MESSAGE_MAXCOUNT', '30'),
		(-111, 'OA_MESSAGE_LIFETIME', '259200'),
		(-112, 'CLIENT_ID_DOM', '49'),
		(-113, 'DOMUI_BASE_URL', '/dom/index.html#/entry/topic/'),
		(-114, 'DOMUI_ENTRYPOINT_WARNINGS', '/dom/index.html#/entry/warning/'),
		(-115, 'DOMUI_ENTRYPOINT_GS_DEFAULT', '/dom/index.html#/entry/global-search/'),
		(-116, 'GS_ACT_SHOW_DIBA_ENTRY', 'DIBA_SHOW_DIBA_ENTRY'),
		(-117, 'STATISTIC_SEND_INTERVAL', '300')
;

insert into oa_gw_data_service.resource_oagw_parameter (resource_oagw_parameter_id, resource_id, oagw_parameter_id)
	values
		(-1, -101, -101),
		(-2, -101, -102),
		(-3, -101, -103),
		(-4, -101, -104),
		(-5, -101, -105),
		(-6, -101, -106),
		(-7, -101, -107),
		(-8, -101, -108),
		(-9, -101, -109),
		(-10, -101, -110),
		(-11, -101, -111),
		(-12, -101, -112),
		(-13, -101, -113),
		(-14, -101, -114),
		(-15, -101, -115),
		(-16, -101, -116),
		(-17, -101, -117)
;

insert into oa_gw_data_service.oagw_schedule (oagw_schedule_id, script_name, execute_condition, execute_interval, last_run)
	values
		(-101, 'processMaintOAMessages', 3, 86400, null),
		(-102, 'processMaintOARequests', 3, 86400, null)
;

insert into oa_gw_data_service.resource_oagw_schedule (resource_oagw_schedule_id, resource_id, oagw_schedule_id)
	values
		(-1, -102, -101),
		(-2, -102, -102)
;

-------------------------------------------------
-- Migration for the OA GW Data DB
-- version 1.0.3  to  1.1.0
-------------------------------------------------

-- update DB version in sys_param table
---------------------------------------
	update oa_gw_data_service.sys_param set par_value = '1.1.0' where par_name = 'OA GW Data DB - Schema OA_GW_DATA_SERVICE';


	;





	update oa_gw_data_service.n_tuple
		set n_tuple_name = 'p|007.x,223.x,206.x,297.x|ntg7.0,Gen20x'
			where n_tuple_id = -101
	;