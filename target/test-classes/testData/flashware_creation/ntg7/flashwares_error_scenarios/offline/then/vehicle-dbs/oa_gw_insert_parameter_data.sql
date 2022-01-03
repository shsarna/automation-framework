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
		(-117, 'STATISTIC_SEND_INTERVAL', '300');
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