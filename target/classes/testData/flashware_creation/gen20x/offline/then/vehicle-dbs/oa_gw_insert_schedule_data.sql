insert into oa_gw_data_service.oagw_schedule (oagw_schedule_id, script_name, execute_condition, execute_interval, last_run)
	values
		(-101, 'processMaintOAMessages', 3, 86400, null),
		(-102, 'processMaintOARequests', 3, 86400, null)
;

insert into oa_gw_data_service.resource_oagw_schedule (resource_oagw_schedule_id, resource_id, oagw_schedule_id)
	values
		(-1, -102, -101),
		(-2, -102, -102),
		(-3, -202, -101),
		(-4, -202, -102)
;


