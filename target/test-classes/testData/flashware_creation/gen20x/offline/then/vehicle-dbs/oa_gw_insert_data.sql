insert into oa_gw_data_service.validity (validity_id, validity_type_id, validity_code)
	values
		(-101, -1, 'p'),				-- business-line
		(-201, -2, '007.0'),			-- vehicle-line
		(-202, -2, '007.1'),			-- vehicle-line
		(-203, -2, '223.0'),			-- vehicle-line
		(-204, -2, '223.1'),			-- vehicle-line
		(-701, -7, 'gen20x')			-- device-model
		ON CONFLICT DO NOTHING
;

insert into oa_gw_data_service.n_tuple (n_tuple_id, n_tuple_name, valid_from, valid_to)
	values
		(-101, 'P|007.0,007.1,223.0,223.1|gen20x', '2017-06-01 06:55:00.000000', '2027-06-01 06:55:00.000000')
		ON CONFLICT DO NOTHING
;

insert into oa_gw_data_service.validity_n_tuple (validity_n_tuple_id, n_tuple_id, validity_id)
	values
		-- P|007.0,007.1,223.0,223.1|gen20x
		(-101, -101, -101), -- P
		(-102, -101, -201), -- 007.0
		(-103, -101, -202), -- 007.1
		(-104, -101, -203), -- 223.0
		(-105, -101, -204), -- 223.1
		(-106, -101, -701)  -- gen20x
		ON CONFLICT DO NOTHING
;

insert into oa_gw_data_service.resource (resource_id, resource_type_id, n_tuple_id, revision, valid_from, valid_to)
	values
		-- OA GW Parameter resource
		(-101, -1, -101, 1, '2017-06-01 06:55:00.000000', '2027-06-01 06:55:00.000000'),
		-- OA GW Schedule resource
		(-102, -2, -101, 1, '2017-06-01 06:55:00.000000', '2027-06-01 06:55:00.000000')
		ON CONFLICT DO NOTHING
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
		(-116, 'GS_ACT_SHOW_DIBA_ENTRY', 'DIBA_SHOW_DIBA_ENTRY')
		ON CONFLICT DO NOTHING
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
		(-16, -101, -116)
		ON CONFLICT DO NOTHING
;

insert into oa_gw_data_service.oagw_schedule (oagw_schedule_id, script_name, execute_condition, execute_interval, last_run)
	values
		(-101, 'processMaintOAMessages', 3, 86400, null),
		(-102, 'processMaintOARequests', 3, 86400, null)
		ON CONFLICT DO NOTHING
;

insert into oa_gw_data_service.resource_oagw_schedule (resource_oagw_schedule_id, resource_id, oagw_schedule_id)
	values
		(-1, -102, -101),
		(-2, -102, -102)
		ON CONFLICT DO NOTHING
;