insert into dom_sw_service.dom_release (dom_release_id, dom_release_type_id, url, major_version, minor_version, patch_version)
	values
		(-101, -1, 'dom-sw-releases/DOM_1.22.0.zip', 1, 22, 0),		-- DOM-Release
		(-201, -2, 'dom-sw-releases/OA_1.4.7.zip', 1, 4, 7),		-- OA-Release
		(-301, -3, 'dom-sw-releases/BTS_1.6.0.zip', 1, 6, 0)		-- BTS-Release
		ON CONFLICT DO NOTHING;

insert into dom_sw_service.resource_dom_release (resource_dom_release_id, resource_id, dom_release_id)
        	values
        		(-1, -101, -101),
        		(-2, -101, -201),
        		(-3, -101, -301)
        		ON CONFLICT DO NOTHING;