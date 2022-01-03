INSERT INTO dom_container.dom_container(
	dom_container_id, part_number, sw_version, container_status, container_type, package_id, package_location_url, package_type, package_dom_type, log, creation_timestamp, modification_timestamp)
	VALUES (17, 'A2239021234', 190210, 'completed', 'ext4', 1, 'https://oa.daimler.com/dom-content-service/v0/packages/1', 'online', 'DOM1', null, '2019-07-08 12:36:09.616+03', '2020-08-12 11:53:48.000000Z');
INSERT INTO dom_container.dom_container_resource(
	dom_container_resource_id, dom_container_id, id_tag, resource_url, estand)
	VALUES ('1', '17','ODX', 'https://ntg7.om-systems-test.cloud.corpintra.net/artifactory/dom-flashware/FULL_NTG7_223_HU7_E019_0_DOM3_M_2239023310_201600.odx-f', 12.0);