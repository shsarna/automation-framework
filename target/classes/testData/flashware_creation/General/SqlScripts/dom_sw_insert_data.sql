TRUNCATE TABLE
                dom_sw_service.Validity,
                dom_sw_service.n_Tuple,
                dom_sw_service.Validity_n_Tuple,
                dom_sw_service.Resource,
                dom_sw_service.DOM_Release,
                dom_sw_service.Resource_DOM_Release CASCADE;

insert into dom_sw_service.validity (validity_id, validity_type_id, validity_code)
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
;

insert into dom_sw_service.n_tuple (n_tuple_id, n_tuple_name, valid_from, valid_to)
	values
		(-101, 'p|007.x,223.x,206.x,297.x,232.x,295.x|ntg7.0', '2017-06-01 06:55:00.000000', '2027-06-01 06:55:00.000000'),
		(-102, 'p|007.x,223.x,206.x,297.x,232.x,295.x|gen20x', '2017-06-01 06:55:00.000000', '2027-06-01 06:55:00.000000')
;

insert into dom_sw_service.validity_n_tuple (validity_n_tuple_id, n_tuple_id, validity_id)
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
		(-601, -102, -302)  -- Gen20x
;

insert into dom_sw_service.resource (resource_id, resource_type_id, n_tuple_id, revision, valid_from, valid_to)
	values
		(-101, -1, -101, 1, '2017-06-01 06:55:00.000000', '2027-06-01 06:55:00.000000'),
		(-102, -1, -102, 1, '2017-06-01 06:55:00.000000', '2027-06-01 06:55:00.000000')
;

insert into dom_sw_service.dom_release (dom_release_id, dom_release_type_id, url, major_version, minor_version, patch_version)
	values
		(-101, -1, 'dom-sw-releases/DOM_1.28.0.zip', 1, 28, 0),		    -- DOM-Release
        (-201, -2, 'dom-sw-releases/OA_ntg7.0_1.4.9.zip', 1, 4, 9),	    -- OA-Release (ntg7.0)
        (-202, -2, 'dom-sw-releases/OA_gen20x_1.4.10.zip', 1, 4,10 ),   -- OA-Release (gen20x)
        (-301, -3, 'dom-sw-releases/BTS_1.6.0.zip', 1, 6, 0)
;

insert into dom_sw_service.resource_dom_release (resource_dom_release_id, resource_id, dom_release_id)
	values
		(-1, -101, -101),
		(-2, -101, -201),
		(-3, -101, -301),

		(-11, -102, -101),
		(-12, -102, -202),
		(-13, -102, -301)
;