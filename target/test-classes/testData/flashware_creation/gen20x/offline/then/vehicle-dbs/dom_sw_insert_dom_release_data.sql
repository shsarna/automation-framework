insert into dom_sw_service.dom_release (dom_release_id, dom_release_type_id, url, major_version, minor_version, patch_version)
	values
		(-101, -1, 'dom-sw-releases/DOM.zip', 1, 6, 0),		-- DOM-Release
		(-201, -2, 'dom-sw-releases/OA.zip', 1, 2, 8),		-- OA-Release
		(-301, -3, 'dom-sw-releases/BTS.zip', 1, 6, 0)		-- BTS-Release
;

insert into dom_sw_service.resource_dom_release (resource_dom_release_id, resource_id, dom_release_id)
	values
		(-1, -101, -101),
		(-2, -101, -201),
		(-3, -101, -301),
		(-11, -102, -101),
		(-12, -102, -201),
		(-13, -102, -301)
;