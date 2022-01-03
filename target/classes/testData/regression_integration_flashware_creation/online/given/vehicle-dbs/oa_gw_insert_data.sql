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
		(-211, -2, '295.1'),			-- vehicle-line
		(-301, -7, 'ntg7.0'),			-- device-model
		(-302, -7, 'gen20x')			-- device-model
		ON CONFLICT DO NOTHING
;

insert into oa_gw_data_service.n_tuple (n_tuple_id, n_tuple_name, valid_from, valid_to)
	values
		(-101, 'p|007.x,223.x,206.x,297.x,232.x,295.x|ntg7.0', '-infinity'::timestamp(6) with time zone, 'infinity'::timestamp(6) with time zone),
		(-102, 'p|007.x,223.x,206.x,297.x,232.x,295.x|gen20x', '-infinity'::timestamp(6) with time zone, 'infinity'::timestamp(6) with time zone)
		ON CONFLICT DO NOTHING
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
		(-211, -101, -211), -- 295.1
		(-301, -101, -301), -- ntg7.0


		(-401, -102, -101), -- p
		(-501, -102, -201), -- 007.0
		(-502, -102, -202), -- 007.1
		(-503, -102, -203), -- 223.0
		(-504, -102, -204), -- 223.1
		(-505, -102, -205), -- 223.9
		(-506, -102, -206), -- 206.0
		(-507, -102, -207), -- 206.1
		(-508, -102, -208), -- 206.2
		(-509, -102, -209), -- 297.1
		(-510, -102, -210), -- 232.4
		(-511, -102, -211), -- 295.1
		(-602, -102, -302)  -- Gen20x
		ON CONFLICT DO NOTHING
;

insert into oa_gw_data_service.resource (resource_id, resource_type_id, n_tuple_id, revision, valid_from, valid_to)
	values
		-- OA GW Parameter resource
		(-101, -1, -101, 1, '2017-06-01 06:55:00.000000', '2027-06-01 06:55:00.000000'),
		(-201, -1, -102, 1, '2017-06-01 06:55:00.000000', '2027-06-01 06:55:00.000000'),
		-- OA GW Schedule resource
		(-102, -2, -101, 1, '2017-06-01 06:55:00.000000', '2027-06-01 06:55:00.000000'),
		(-202, -2, -102, 1, '2017-06-01 06:55:00.000000', '2027-06-01 06:55:00.000000')
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
		(-116, 'GS_ACT_SHOW_DIBA_ENTRY', 'DIBA_SHOW_DIBA_ENTRY'),
		(-117, 'STATISTIC_SEND_INTERVAL', '300')
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
		(-16, -101, -116),
		(-17, -101, -117),

		(-18, -201, -101),
		(-19, -201, -102),
		(-20, -201, -103),
		(-21, -201, -104),
		(-22, -201, -105),
		(-23, -201, -106),
		(-24, -201, -107),
		(-25, -201, -108),
		(-26, -201, -109),
		(-27, -201, -110),
		(-28, -201, -111),
		(-29, -201, -112),
		(-30, -201, -113),
		(-31, -201, -114),
		(-32, -201, -115),
		(-33, -201, -116),
		(-34, -201, -117)
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
		(-2, -102, -102),

		(-3, -202, -101),
		(-4, -202, -102)
		ON CONFLICT DO NOTHING
;