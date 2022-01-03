delete FROM dom_content.node_element where element_id in (SELECT element_id FROM dom_content.element where language='de' and locale= 'de');
delete FROM dom_content.keyword where element_id in (SELECT element_id FROM dom_content.element where language='de' and locale= 'de');
delete FROM dom_content.media_element where element_id in (SELECT element_id FROM dom_content.element where language='de' and locale= 'de');
delete  FROM dom_content.element where language='de' and locale= 'de';