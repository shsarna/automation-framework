delete from dom_content.media_element where media_id in (select media_id from dom_content.media where ext_media_url like '%cmsweb%');
delete from dom_content.media where media_id in (select media_id from dom_content.media where ext_media_url like '%cmsweb%');
