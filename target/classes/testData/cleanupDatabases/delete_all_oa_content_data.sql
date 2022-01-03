


DROP TABLE IF EXISTS OA_CONTENT.VALIDITY CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.VALIDITY_TYPE CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.PHONEME CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.KEYWORD CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.XML_DATA_SEARCH_META CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.SEARCH_META CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.SYS_PARAM CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.OBJECT_TYPE CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.RELATION_TYPE CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.SOURCE_SYSTEM CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.RELATION CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.OBJECT CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.VEHICLE_LINE CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.MARKET CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.TARGET_DEVICE CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.INFO_PRODUCT CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.PUB_EDITION CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.STATE_OF_CONSTRUCTION CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.OBJECT_PAYLOAD CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.TEXT_DATA CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.MEDIA_REF_DATA CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.XML_DATA CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.IMAGE_DATA CASCADE
;

DROP TABLE IF EXISTS OA_CONTENT.CONTENT_REQUEST CASCADE
;




CREATE SCHEMA IF NOT EXISTS oa_content;




CREATE TABLE OA_CONTENT.SYS_PARAM
(
    SYS_PARAM_ID bigserial NOT NULL,    -- Internal Id. Primary key of the table.
    PAR_NAME varchar(100) NOT NULL,    -- Name of the parameter.  This must be unique for all rows in the table.
    PAR_VALUE varchar(300) NOT NULL,    -- Value of the parameter.
    PAR_DESCRIPTION varchar(300) NULL    -- Description of the parameter. It should describe the meaning of the specific parameter or for what purpose the parameter is needed.
)
;

CREATE TABLE OA_CONTENT.OBJECT_TYPE
(
    OBJECT_TYPE_ID bigserial NOT NULL,    -- Internal Id of the OBJECT_TYPE table. Used as PK.
    OBJECT_TYPE_NAME varchar(50) NOT NULL,    -- Name of the object type. Examples:  "topic" (for ARKI4 quickstart topics, disclaimers, ...), "main_menu_item" (for ARKI4 y.io.type = "arki-frag-functionlist"), "sub_menu_item" (for ARKI4 y.io.type = "arki-frag-title"), "ip" (= Information Product),  "tdev" (= Target Device);  "vehline" (= Vehicle Line),  "market", etc.
    DESCRIPTION varchar(255) NULL    -- Optional description field, which can be used to describe the meaning of the object type.
)
;

CREATE TABLE OA_CONTENT.RELATION_TYPE
(
    RELATION_TYPE_ID bigserial NOT NULL,    -- Internal Id of the RELATION_TYPE table. Used as PK.
    RELATION_TYPE_NAME varchar(50) NOT NULL,    -- Name of the relation type. Examples could be: "is-valid-for", "references", ...
    DESCRIPTION varchar(255) NULL    -- Optional description field, which can be used to describe the meaning of the relation type.
)
;

CREATE TABLE OA_CONTENT.SOURCE_SYSTEM
(
    SOURCE_SYSTEM_ID bigserial NOT NULL,    -- Internal Id of the SOURCE_SYSTEM table. Used as PK.
    SOURCE_SYSTEM_NAME varchar(50) NOT NULL,    -- Name of the Source System in lower case letters.  Examples: "arki4", "oa" (for the OA-System itself).
    DESCRIPTION varchar(255) NULL    -- Optional description field, which can be used to describe the source system.
)
;

CREATE TABLE OA_CONTENT.RELATION
(
    RELATION_ID bigserial NOT NULL,    -- Internal Id of the RELATION table. Used as PK.
    OBJECT_ID_1 bigint NOT NULL,    -- Reference to the OBJECT_ID of the first object of the relationship. In RDF notation it stands for the subject in the (subject - predicate - object) triple.
    RELATION_TYPE_ID bigint NOT NULL,    -- Id of the relation type between the two referenced objects. This Id references a row in the RELATION_TYPE table.  In RDF notation the relation type stands for the predicate in the (subject - predicate - object) triple. Possible values for RELATION_TYPE_ID reference relation types names like: - "is-valid-for" - "references" - "is-child-of", - ... Only certain combinations of the types of the two objects and the relation type make sense.
    OBJECT_ID_2 bigint NOT NULL,    -- Reference to the OBJECT_ID of the second object of the relationship. In RDF notation it stands for the object in the (subject - predicate - object) triple.
    OBJECT_ID_CONTEXT bigint NOT NULL   DEFAULT -1,    -- Optional third OBJECT_ID, which references a row from the OBJECT table to provide a context for the relation between object 1 and object 2. For most relations this column will be set to a dummy object (-1) to avoid conflicts with NULL values in the extended unique constraint.  For relations of type 'has-next-sibling', which express the order of sub menu items or topics in the menu hierarchy, the OBJECT_ID_CONTEXT has to be the parent object_id, because the order is only unique in the context of the parent menu item, if the same sub menu item or topic can appear at different places in the menu structure. For 'has-next-sibling' relations on the top level of the menu hierarchy the OBJECT_ID_CONTEXT is -1, as main menu items (=function-lists) are the roots of the menu trees and don't have a parent. For 'has-next-sibling' relations on all other levels of the menu hierarchy the OBJECT_ID_CONTEXT has to be populated with the object_id of the parent object (from the 'is-child-of' relation).
    VALID_FROM timestamp(6) with time zone NOT NULL,    -- Point of time, from when this relationship is valid.  If the source system does not provide the start timestamp of the validity period, the application has to set this field to the current timestamp when inserting the row into the database.
    VALID_TO timestamp(6) with time zone NOT NULL,    -- Point of time, until this relationship is valid.   When inserting the row into the DB, this field is usually set to '9999-12-31' to indicate that it is valid infinitely, if the source system does not provide the timestamp for the end of the validity period. When updating an object to make it invalid, the VALID_TO field has to be set to a definite point in time.
    CREATION_TIMESTAMP timestamp(6) with time zone NOT NULL,    -- Point in time (date and time), when the row was inserted into the database.
    MODIFICATION_TIMESTAMP timestamp(6) with time zone NULL    -- Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row.
)
;

CREATE TABLE OA_CONTENT.OBJECT
(
    OBJECT_ID bigserial NOT NULL,    -- Internal Id of the OBJECT table. Used as PK.
    OBJECT_TYPE_ID bigint NOT NULL,    -- Id of the object type. Reference to the associated row in the OBJECT_TYPE table.
    SOURCE_SYSTEM_ID bigint NOT NULL,    -- Id of the source system, which is the origin for the object. Reference to the associated row in the SOURCE_SYSTEM table.
    OBJECT_ID_FROM_SOURCE varchar(1024) NOT NULL,    -- Unique Identifier of this object in the source system.  For objects with payload from ARKI4 (topics, menu items, etc.) this value is composed from the y.io.id and an N-Tuple-Hash value, which is created from the concatenated validities of the object: <y.io.id>-<N-Tuple-MD5-Hash>.  For creating the N-Tuple-Hash at first the normalized validities of the object are concatenated like this:    '<VEHICLE_LINE><STATE_OF_CONSTRUCTION><MARKET><TARGET_DEVICE><INFO_PRODUCT>'. In detail: '<business_line><vehicle_line_lead><vehicle_line_variant><vehicle_line_market><state_of_construction><market><device><model><model_variant><device_market><ip_name>'. Example: 'p2231ma-ece/row808+059ece/rowntg7.0premiumhu-ece/rowip_diba'.   The MD5-Hash for this example string is 'c8cd3f15edb4435c109e4990ca2d3987'. The resulting OBJECT_ID_FROM_SOURCE for y.io.id = '3afdb18ebd300ec3ac190d2b02b3e08f' would then look like this:     '3afdb18ebd300ec3ac190d2b02b3e08f-c8cd3f15edb4435c109e4990ca2d3987'.  For masterdata objects, which are created internally inside the OA System, this field contains the last part of the URI for that object in lower case letters. The complete URI looks like that: <OA_URI_SCHEME>:<OA_URI_AUTHORITY>:<object_type_name>:<object_id_from_source>. The values for OA_URI_SCHEME and OA_URI_AUTHORITY are parameters in the SYS_PARAM table. Object_type_name is from the OBJECT_TYPE table.  Example values for object_id from source for masterdata objects: - Vehicle-Line: "177:0:ma-ece/row:2018.04e:p", - State-of-Construction: "808+059", - Information Product: "ip_diba",  - Target Device: "ntg:6.0:entry:hu-ece/row", - Market: "ece/row".
    OBJECT_TYPE_FROM_SOURCE varchar(300) NULL,    -- Object type that is associated with this object in the source system. For objects from ARKI4 the origin for this field is the y.io.type. Example values for topics: "arki-frag-functionlist", "arki-frag-title" or "arki-topic-quickstart". Example value for a media_ref object: "mediahub-arkikipicng".
    OBJECT_NAME_FROM_SOURCE varchar(100) NULL    -- Optional name of the object from the source system. It is only available for some object types. E.g. for object type 'cb_answer' (chatbot answer) the value for this field is retrieved from: //answer.ref/@y.io.name.
)
;

CREATE TABLE OA_CONTENT.VEHICLE_LINE
(
    OBJECT_ID bigint NOT NULL,    -- PK column of the VEHICLE_LINE table. This Primary Key is inherited from the OBJECT table (as a VEHICLE_LINE is a special object) and it is also used as Foreign Key to reference the associated row in the OBJECT table.
    VEHICLE_LINE_LEAD varchar(10) NOT NULL,    -- Lead Vehicle Line (in german: Lead-Baureihe) in lower case letters.  Example value: "217".
    VEHICLE_LINE_VARIANT varchar(10) NOT NULL,    -- Variant of the vehicle line (german: Baureihen-Derivat) in lower case letters. Example value: "2". The vehicle line as a whole can be composed from <VEHICLE_LINE_LEAD>.<VEHICLE_LINE_VARIANT>. Example: "217.2".
    VEHICLE_LINE_MARKET varchar(10) NOT NULL,    -- Market, where the vehicle is built (in german: "Baureihen-Markt") in lower case letters. Example: "ma-ece/row".
    BUSINESS_LINE char(1) NOT NULL,    -- Business line (in german: Spartenkenner), to which the vehicle line belongs in lower case letters. At the moment the value should be "p" for "PKW" for all rows. (The german term "PKW" = Personenkraftwagen means "passenger car" in english).
    DESCRIPTION varchar(255) NULL    -- Optional description field.
)
;

CREATE TABLE OA_CONTENT.TARGET_DEVICE
(
    OBJECT_ID bigint NOT NULL,    -- PK column of the TARGET_DEVICE table. This Primary Key is inherited from the OBJECT table (as a TARGET_DEVICE is a special object) and it is also used as Foreign Key to reference the associated row in the OBJECT table.
    DEVICE varchar(50) NOT NULL,    -- Name of the target device in lower case letters. Examples: "ntg", "rse", "iphone", "web-browser", ..  TODO: the set of allowed values has to be specified or has to be extended, when more target devices are added as recipients for content from the OA System.
    MODEL varchar(50) NULL,    -- Model or generation of the target device in lower case letters. Examples: For device "ntg" possible values for MODEL would be "6.0", "7.0". For device "iphone" a possible value for MODEL would be "8". This column may not have a value for all target devices.
    MODEL_VARIANT varchar(50) NULL,    -- Model variant of the target device in lower case letters. This determines the hardware equipment.  Examples: For device "ntg"  and model "6.0" possible value for MODEL_VARIANT could be "entry540", "entry720", "mid540", "mid720" and "high". For device "iphone" and  MODEL "8" a possible value for MODEL_VARIANT could be "plus". This column may not have a value for all target devices.
    DEVICE_MARKET varchar(50) NULL,    -- Market for the target device in lower case letters. This column may be empty for some target devices. In case of a "ntg" model for the DiBA on a vehicle this attribute contains the HU-Market, e.g. "hu-ece/row".
    SCREEN_WIDTH integer NULL,    -- Screen resolution width in pixels.
    SCREEN_HEIGHT integer NULL,    -- Screen resolution height in pixels.
    DESCRIPTION varchar(255) NULL    -- Optional description field.
)
;

CREATE TABLE OA_CONTENT.MARKET
(
    OBJECT_ID bigint NOT NULL,    -- PK column of the MARKET table. This Primary Key is inherited from the OBJECT table (as a MARKET is a special object) and it is also used as Foreign Key to reference the associated row in the OBJECT table.
    MARKET varchar(10) NOT NULL,    -- The market, for which the owners manual is intended for. (In german: "Auslieferungsmarkt"?) Example: "ece/row".
    DESCRIPTION varchar(255) NULL    -- Optional description field.
)
;

CREATE TABLE OA_CONTENT.PUB_EDITION
(
    OBJECT_ID bigint NOT NULL,    -- PK column of the PUB_EDITION table.  This primary key is inherited from the OBJECT table (as a pub-edition (PA_ID) is a special object) and it is also used as foreign key to reference the associated row in the OBJECT table.
    PA_ID text NOT NULL    -- The PA-ID of the pub-edition, for which the owners manual is intended for. (In german: "Publikationsausgabe") Example: PA180559
)
;

CREATE TABLE OA_CONTENT.STATE_OF_CONSTRUCTION
(
    OBJECT_ID bigint NOT NULL,    -- PK column of the STATE_OF_CONSTRUCTION table.  This primary key is inherited from the OBJECT table (as a state-of-construction is a special object) and it is also used as foreign key to reference the associated row in the OBJECT table.
    STATE_OF_CONSTRUCTION text NOT NULL    -- The state-of-construction, for which the owners manual is intended for. (In german: "Bauzustand") Example: 808+059
)
;

CREATE TABLE OA_CONTENT.INFO_PRODUCT
(
    OBJECT_ID bigint NOT NULL,    -- PK column of the INFO_PRODUCT table. This Primary Key is inherited from the OBJECT table (as an information product is a special object) and it is also used as Foreign Key to reference the associated row in the OBJECT table.
    IP_NAME varchar(50) NULL,    -- Name of the information product. This short name uniquely identifies the target medium.  Possible values for IP-Names are at the moment: - "ip_diba" (this is the digital OM on the HU of a vehicle) - "ip_baix" (for the OM on the MercedesMe web page = DPP = Digital Product Page ) - "ip_guide" (OM in Mobile Phone App) - "ip_print" (OM printed on paper)
    DESCRIPTION varchar(255) NULL    -- Optional description field.
)
;

CREATE TABLE OA_CONTENT.OBJECT_PAYLOAD
(
    OBJECT_PAYLOAD_ID bigserial NOT NULL,    -- Internal Id of the table, which is used as PK.
    OBJECT_ID bigint NOT NULL,    -- Reference to the associated object in the OBJECT table.
    MIME_TYPE varchar(255) NOT NULL    -- The MIME type specifies the data format of the object's payload. It also determines in which special data table the actual data is stored.  Currently used mime types are: - 'text/xml' for objects with a payload in table XML_DATA (like topics, menu items, ...), - 'image' for objects with a payload in table MEDIA_REF_DATA .    Examples for possible other MIME types would be: - 'text/plain'  - 'image/png'  - 'image/jpeg' - 'video/mp4'  - 'text/xml' - 'application/pdf' - application/json'  TODO: (to be clarified for future use):  - If we don't store the image or video itself, but only a reference, the MIME type maybe would not be 'image/...' or 'video/...'.  Should we really use a mime type prefix like 'image' or maybe 'text/plain', 'text/url' or no mime type at all?  - If we would store a PDF document as a base64 encoded text, the MIME type would not be 'application/pdf' but 'application/base64' and we would store it in a column with data type TEXT? Or would the MIME type be text/plain ?  - Will we need a kind of mapping of (OBJECT.type, OBJECT_PAYLOAD.mime_type) to the name of the data table, where we stored the actual data, maybe not in the database, but somewhere?  - Maybe we will later split this field into two fields for mediatype ('image', 'application', ...) and subtype ('jpeg', 'png', 'text'...), because we sometimes only use the mediatype.
)
;

CREATE TABLE OA_CONTENT.TEXT_DATA
(
    TEXT_DATA_ID bigserial NOT NULL,    -- Internal Id of the TEXT_DATA table. PK of the table.
    OBJECT_PAYLOAD_ID bigint NOT NULL,    -- Reference to the associated row in the OBJECT_PAYLOAD table.
    DATA_ID_FROM_SOURCE varchar(1024) NOT NULL,    -- Id, which identifies the object data inside the source system. For objects from ARKI4, the value can be retrieved from the y.id.
    LANGUAGE varchar(5) NOT NULL,    -- Language of the object data.  Examples: "de", "en", ...  The attributes LANGUAGE and LOCALE can be concatenated: e.g. "de_DE", "en_GB", ...
    LOCALE varchar(5) NOT NULL,    -- This field refers to the localization of the LANGUAGE used in different countries.  For data from a ARKI4 Super-XML this field holds the value written in the "variant" field of the Super-XML.
    DATA text NOT NULL,    -- This field contains the actual data of the object payload as a TEXT field.
    REVISION smallint NOT NULL,    -- OA internal revision or version of the object data. Revisions of the same object may differ for different languages. The revision values start with 1, 2, 3, ...
    VERSION_FROM_SOURCE varchar(50) NULL,    -- Version of the object data from the source system.  For objects from ARKI4 the origin of this field is y.io.version. This field is nullable, because some source systems might not have a version for their objects. Caution: the data type of this column is a string. So comparisons or min/max might not work: Ex. 100 < 21. Versions like "1.2.3" might be used in some source systems.
    MD5_CHECKSUM varchar(32) NOT NULL,    -- The MD5_CHECKSUM field contains a MD5 hash value for the content of the DATA column. It always consists of 32 hexadecimal digits.
    VALID_FROM timestamp(6) with time zone NOT NULL,    -- Point of time, from when this OBJECT_DATA row is valid. When inserting the row into the DB, this field is usually set to the current timestamp.
    VALID_TO timestamp(6) with time zone NOT NULL,    -- Point of time, until this OBJECT_DATA row is valid. When inserting the row into the DB, this field is usually set to '9999-12-31' to indicate that it is valid infinitely. When updating an object to make it invalid, the VALID_TO field has to be set to a definite point in time.  TODO: Check if we can use the Postgres "infinity" value instead of this and how the timezone is affected for both solutions.
    CREATION_TIMESTAMP timestamp(6) with time zone NOT NULL,    -- Point in time (date and time), when the row was inserted into the database.
    MODIFICATION_TIMESTAMP timestamp(6) with time zone NULL    -- Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row.
)
;

CREATE TABLE OA_CONTENT.MEDIA_REF_DATA
(
    MEDIA_REF_DATA_ID bigserial NOT NULL,    -- Internal Id of the MEDIA_REF_DATA table. Used as PK.
    OBJECT_PAYLOAD_ID bigint NOT NULL,    -- Reference to associated row in the OBJECT_PAYLOAD table.
    DATA_ID_FROM_SOURCE varchar(1024) NOT NULL,    -- Id, which identifies the media object data inside the source system. For media objects from ARKI4, the value can be retrieved from the y.id of the image or video. Example: "ID_017ba1f06e27e274354ae365170fe78e-209cd0c548ab5f5a354ae36548de85f3-de-DE".
    LANGUAGE varchar(5) NOT NULL,    -- Language of the referenced mediafile.  Examples: "de", "en", ...  The attributes LANGUAGE and LOCALE can be concatenated: e.g. "de_DE", "en_GB", ... This field contains two hyphens ("--"), if the image is valid for all languages.
    LOCALE varchar(5) NOT NULL,    -- This field refers to the localization of the LANGUAGE used in different countries.  For data from a ARKI4 Super-XML this field holds the value written in the "variant" field of the Super-XML. This field contains two hyphens ("--"), if the image is valid for all locales.
    EXT_MEDIA_ID varchar(1000) NULL,    -- External media identifier. The EXT_MEDIA_ID identifies the media file inside the external reference system, e.g. in the MediaHub.  For images from ARKI4, which have y.io.type = 'mediahub-arkikipicng', the value for EXT_MEDIA_ID can be found under //img/xxxparam with the following XPath expression:  //img/xxxparam[@key='http://metadata.docufy.de/cms/dynamic/meta/mh-media-ref']/@value Example value: '1556'.
    EXT_MEDIA_URL text NULL,    -- External media URL. The EXT_MEDIA_URL is used to retrieve the media file from the external reference system, e.g. in the MediaHub.   Example: yhref=https://mh.om-systems-int.cloud.corpintra.net/mm/arki/download/160213-160217-160595.jpg
    EXT_MEDIA_FILENAME text NOT NULL, -- External media filename.
    REVISION smallint NOT NULL,    -- OA internal revision of the media ref data. For rows in the MEDIA_REF_DATA table the revision is copied from the version_from_source column and converted to integer.
    VERSION_FROM_SOURCE varchar(50) NULL,    -- Version of the media object data from the source system.  For objects from ARKI4 the origin of this field is y.io.version. This field is nullable, because some source systems might not have a version for their objects. Caution: the data type of this column is a string. So comparisons or min/max might not work: Ex. 100 < 21. Versions like "1.2.3" might be used in some source systems.
    VALID_FROM timestamp(6) with time zone NOT NULL,    -- Point of time, from when this MEDIA_REF_DATA row is valid. When inserting the row into the DB, this field is usually set to the current timestamp.
    VALID_TO timestamp(6) with time zone NOT NULL,    -- Point of time, until this MEDIA_REF_DATA row is valid. When inserting the row into the DB, this field is usually set to '9999-12-31' or INFINTY to indicate that it is valid infinitely. When updating an object to make it invalid, the VALID_TO field has to be set to a definite point in time. Remark: In the current implementation of OA Content Service VALID_FROM is never updated.
    CREATION_TIMESTAMP timestamp(6) with time zone NOT NULL,    -- Point in time (date and time), when the row was inserted into the database.
    MODIFICATION_TIMESTAMP timestamp(6) with time zone NULL    -- Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row. Remark:  In the current implementation of OA Content Service the MODIFICATION_TIMESTAMP is always NULL, as rows in the table are never updated.
)
;

CREATE TABLE OA_CONTENT.XML_DATA
(
    XML_DATA_ID bigserial NOT NULL,    -- Internal Id of the XML_DATA table. Used as PK.
    OBJECT_PAYLOAD_ID bigint NOT NULL,    -- Reference to the associated row in the OBJECT_PAYLOAD table.
    DATA_ID_FROM_SOURCE varchar(1024) NOT NULL,    -- Id, which identifies the object data inside the source system. For objects from ARKI4, the value can be retrieved from the y.id.
    LANGUAGE varchar(5) NOT NULL,    -- Language of the object data.  Examples: "de", "en", ...  The attributes LANGUAGE and LOCALE can be concatenated: e.g. "de_DE", "en_GB", ...
    LOCALE varchar(5) NOT NULL,    -- This field refers to the localization of the LANGUAGE used in different countries.  For data from a ARKI4 Super-XML this field holds the value written in the "variant" field of the Super-XML.
    DATA text NOT NULL,    -- This field contains the actual content data as an XML fragment. For data from ARKI4 the basis for these XML fragments comes from the Super-XML. CAUTION: If the XML content contains single quotes (') (e.g. like in phonemes for keywords under indexterm), each single quote has to be escaped by another single quote ('').
    TITLE text NULL,    -- This optional column contains a title or heading for the XML content, which is stored in the data column of this table.  It can be used (aside from the attached keywords) to search for the content.   For data imported from an ARKI4 Super-XML file this column is populated with the title of a topic, extracted from the "title" or "overview-title" field, if this is present.  Remark: This column corresponds to the last column (E) in the old "keywords_cop.xls" file. It could also serve to display a search result.
    REVISION smallint NOT NULL,    -- OA internal revision of the object data. Revision values start with 1, 2, 3, etc. For each combination of (object_payload_id, data_id_from_source, version_from_source, md5_checksum, language, locale) a new revision is created.  Remark:  The revisions are incremented in an order that is determined by the creation_timestamp, i.e. it might happen, that the revision is lower for a higher version_from_source, if the topic with the higher version_from_source was imported first.
    VERSION_FROM_SOURCE varchar(50) NULL,    -- Version of the object data from the source system.  For objects from ARKI4 the origin of this field is y.io.version. This field is nullable, because some source systems might not have a version for their objects. Caution: the data type of this column is a string. So comparisons or min/max might not work: Ex. 100 < 21. Versions like "1.2.3" might be used in some source systems.
    MD5_CHECKSUM varchar(32) NOT NULL,    -- The MD5_CHECKSUM field contains a MD5 hash value for the content of the DATA column. It always consists of 32 hexadecimal digits.
    SCHEMA_REF varchar(2000) NOT NULL,    -- Reference to the XML schema (XSD or DTD), which describes the structure of the XML data. It should contain the URL of the XSD- or DTD-file. Example for XML fragments from ARKI4 could be: "http://arki/xxxxml-v10.xsd".
    VALID_FROM timestamp(6) with time zone NOT NULL,    -- Point of time, from when this XML_DATA row is valid. When inserting the row into the DB, this field is usually set to the current timestamp.
    VALID_TO timestamp(6) with time zone NOT NULL,    -- Point of time, until this XML_DATA row is valid. When inserting the row into the DB, this field is usually set to '9999-12-31' or the PostgreSQL value INFINITY, to indicate that it is valid infinitely. When updating an object to make it invalid, the VALID_TO field has to be set to a definite point in time. Remark: In the current implementation of OA Content Service VALID_TO is never updated.
    CREATION_TIMESTAMP timestamp(6) with time zone NOT NULL,    -- Point in time (date and time), when the row was inserted into the database.
    MODIFICATION_TIMESTAMP timestamp(6) with time zone NULL    -- Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row. Remark:  In the current implementation of OA Content Service the MODIFICATION_TIMESTAMP is always NULL, as rows in the table are never updated.
)
;

CREATE TABLE OA_CONTENT.IMAGE_DATA
(
    IMAGE_DATA_ID bigserial NOT NULL,    -- Internal Id of the IMAGE_DATA table. Used as PK.
    OBJECT_PAYLOAD_ID bigint NOT NULL,    -- Reference to associated row in the OBJECT_PAYLOAD table.
    DATA_ID_FROM_SOURCE varchar(1024) NOT NULL,    -- Id, which identifies the image in the source system.
    LANGUAGE varchar(5) NOT NULL,    -- Language of the image.  Examples: "de", "en", ...  The attributes LANGUAGE and LOCALE can be concatenated: e.g. "de_DE", "en_GB", ... This field contains two hyphens ("--"), if the image is valid for all languages.
    LOCALE varchar(5) NOT NULL,    -- This field refers to the localization of the LANGUAGE used in different countries.  For data from a ARKI4 Super-XML this field holds the value written in the "variant" field of the Super-XML. This field contains two hyphens ("--"), if the image is valid for all locales.
    DATA bytea NOT NULL,    -- Binary data of the actual image.
    REVISION smallint NOT NULL,    -- OA internal revision or version of the object data. Revisions of the same object may differ for different languages. The revision values start with 1, 2, 3, ...
    VERSION_FROM_SOURCE varchar(50) NULL,    -- Version of the object data from the source system.  This field is nullable, because some source systems might not have a version for their objects. Caution: the data type of this column is a string. So comparisons or min/max might not work: Ex. 100 < 21. Versions like "1.2.3" might be used in some source systems.
    IMG_HEIGHT smallint NOT NULL,    -- Height of the image in pixels.
    IMG_WIDTH smallint NOT NULL,    -- Width of the image in pixels.
    MD5_CHECKSUM varchar(32) NOT NULL,    -- The MD5_CHECKSUM field contains a MD5 hash value for the content of the DATA column. It always consists of 32 hexadecimal digits.
    LAYOUT_INFO varchar(50) NULL,    -- Optional field for a layout information of the picture. Example value: "auto"  TODO: Is this column necessary?
    VALID_FROM timestamp(6) with time zone NOT NULL,    -- Point of time, from when this IMAGE_DATA row is valid. When inserting the row into the DB, this field is usually set to the current timestamp.
    VALID_TO timestamp(6) with time zone NOT NULL,    -- Point of time, until this IMAGE_DATA row is valid. When inserting the row into the DB, this field is usually set to '9999-12-31' to indicate that it is valid infinitely. When updating an object to make it invalid, the VALID_TO field has to be set to a definite point in time.  TODO: Check if we can use the Postgres "infinity" value instead of this and how the timezone is affected for both solutions.
    CREATION_TIMESTAMP timestamp(6) with time zone NOT NULL,    -- Point in time (date and time), when the row was inserted into the database.
    MODIFICATION_TIMESTAMP timestamp(6) with time zone NULL    -- Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row.
)
;

CREATE TABLE OA_CONTENT.XML_DATA_SEARCH_META
(
    XML_DATA_SEARCH_META_ID bigserial NOT NULL,    -- Internal Id of the XML_DATA_SEARCH_META table. Used as PK.
    XML_DATA_ID bigint NOT NULL,    -- FK column. Reference to the associated row in the XML_DATA table.
    SEARCH_META_ID bigint NOT NULL    -- FK column. Reference to the associated row in the SEARCH_META table.
)
;

CREATE TABLE OA_CONTENT.KEYWORD
(
    KEYWORD_ID bigserial NOT NULL,    -- Internal Id of the KEYWORD table. Used as PK.
    SEARCH_META_ID bigint NOT NULL,    -- Reference to the row in the SEARCH_META table, to which this keyword belongs.
    KEYWORD_VALUE text NOT NULL    -- The keyword itself. For input from an ARKI4 Super-XML file each keyword can be extracted from indexterm/keywords/keyword_entry/keyword. Example: "Diesel tanken".
)
;

CREATE TABLE OA_CONTENT.CONTENT_REQUEST
(
    CONTENT_REQUEST_ID bigserial NOT NULL,    -- Unique Id of the content request. PK of the table.
    REQUEST_TYPE char(1) NOT NULL,    -- Type of the content request. Possible values: "B" for a "OABulk" import request, "Q" for a "OAQuery" content request
    REQUEST text NOT NULL,    -- Request, formatted as JSON.
    REQUEST_TIMESTAMP timestamp(6) with time zone NOT NULL,    -- Timestamp, when the request was sent to the DB and when the row in this table was created.
    RESPONSE text NULL,    -- Response message (Body of the http response). The column is set to NULL first and populated as soon as it is available.
    RESPONSE_TIMESTAMP timestamp(6) with time zone NULL,    -- Timestamp, when the response was available and updated to this row of the table. Initially on inserting this column is set to NULL.
    RESULT text NULL,    -- For OAQuery:  Path to the file that holds the result of the select statement for the query. The result in the file is formatted as JSON. On inserting the row the value of this column is set to NULL. It is updated with the path to the result, when the result is available.  The file is stored on the COS (= Cloud Object Store of the IBM Cloud). The path for the result file can be configured in the configmap. The filename is always 'result_<id>', where <id> is the CONTENT_REQUEST_ID.  Example: 'cos//eu-de/ba-oacore-test-results/result_123.json'  For OABulk the result column is not populated.
    RESULT_TIMESTAMP timestamp(6) with time zone NULL,    -- Timestamp, when the result was available and updated to this row of the table. Initially on inserting this column is set to NULL. (This column is also populated for OABulk, when the processing of the request is finished, although the result column stays empty.)
    USER_ID varchar(50) NOT NULL,    -- User, who initiated the request. This should be provided from the service context.
    STATUS smallint NOT NULL   DEFAULT 0,    -- Status of the content request. Possible values:  0 = NEW: initial default value (currently not used),  1 = IN_PROGRESS: request is in progress, REQUEST has been inserted into the table, RESPONSE is added when available, RESULT is not yet available,  2 = COMPLETED: request asynchronous processing has completed successfully. Result is available in RESULT column, 3 = FAILED:  Request asynchronous processing has failed. RESULT column is populated with an error message.
    LOGFILE_PATH text NULL    -- Path and filename of the logfile that is associated to this content request. The logfile is located in a bucket on the Cloud Object Store (COS) of the IBM Cloud.  Example: 'cos://eu-de/ba-oacore-test-logfiles/protocol_418.json' The logfile path can be configured in the configmap. The filename is always 'protocol_<id>', where <id> is the CONTENT_REQUEST_ID.
)
;

CREATE TABLE OA_CONTENT.PHONEME
(
    PHONEME_ID bigserial NOT NULL,    -- Internal Id of the PHONEME table. Used as PK.
    KEYWORD_ID bigint NOT NULL,    -- Id of the row in the KEYWORD table, to which the phoneme belongs.
    PHONEME_VALUE varchar(400) NOT NULL,    -- A phoneme string, which is associated to a keyword is a written description of how the keyword sounds. It is used to search for certain keywords by speech. For ARKI4 as input system this value is derived from the "main-phonem" or "alt-phonem" field, i.e. from "indexterm/keywords/keyword-entry/phonetics/main-phonem" or "indexterm/keywords/keyword-entry/phonetics/alt-phonems/alt-phonem".  Example:  A phoneme for the keyword "Diesel tanken" is "'di:.z$l_'tanK.k$n".  CAUTION !!!:  As the phoneme string might contain single quotes, these have to be escaped during INSERT. (In SQL this is done by doubling the quotes, which are part of the string.)
    PHONEME_TYPE char(1) NOT NULL    -- Type of the phoneme. Possible values: "M" = main phoneme,  "A"  = alternative phoneme.  If the phoneme is extracted from the "main-phonem" field in the Super-XML file, this column is set to "M",  if it is derived from an "alt-phonem" field it should be set to "A".
)
;

CREATE TABLE OA_CONTENT.SEARCH_META
(
    SEARCH_META_ID bigserial NOT NULL,    -- Internal Id of the SEARCH_META table. Used as PK.
    SEARCH_META_ID_FROM_SOURCE varchar(1024) NOT NULL,    -- Id, which identifies the SEARCH_META row inside the source system. For objects from ARKI4, the value can be retrieved from the field indexterm/y.id.
    LANGUAGE varchar(5) NOT NULL,    -- Language of the search_meta data.  For data from ARKI4 this value is retrieved from indexterm/y.io.language. Examples: "de", "en", ...
    LOCALE varchar(5) NOT NULL,    -- This field refers to the localization of the LANGUAGE used in different countries.  For data from ARKI4 this value is retrieved from indexterm/y.io.variant. Examples: "DE", "GB".
    REVISION smallint NOT NULL,    -- OA internal revision or version of the search_meta data. Revision values start with 1, 2, 3, etc. For each combination of (search_meta_id_from_source, version_from_source, md5_checksum, language, locale) a new revision is created.  Remark:  The revisions are incremented in an order that is determined by the creation_timestamp, i.e. it might happen, that the revision is lower for a higher version_from_source, if the indexterm with the higher version_from_source was imported first.
    VERSION_FROM_SOURCE varchar(50) NULL,    -- Version of the search_meta data from the source system.  For search_meta rows from ARKI4 the origin of this field is indexterm/y.io.version. This field is nullable, because some source systems might not have a version for their objects. Caution: the data type of this column is a string. So comparisons or min/max might not work: Ex. 100 < 21. Versions like "1.2.3" might be used in some source systems.
    MD5_CHECKSUM varchar(32) NOT NULL,    -- MD5 hash value, which is calculated from the concatenated keywords under this indexterm. The keywords are at first sorted in alphabetical order and then concatenated.  Example: If you find the following two keywords under this indexterm ( 'petrol' and 'fuel'), first these strings are ordered and concatenated ('fuelpetrol') and then the MD5 hash is calculated from the concatenated string: 'ea85308178a3afab63012fefbcb70f5e'.
    VALID_FROM timestamp(6) with time zone NOT NULL,    -- Point of time, from when this SEARCH_META row is valid. When inserting the row into the DB, this field is usually set to the current timestamp.
    VALID_TO timestamp(6) with time zone NOT NULL,    -- Point of time, until this SEARCH_META row is valid. When inserting the row into the DB, this field is usually set to '9999-12-31' or INFINITY to indicate that it is valid infinitely. When updating an object to make it invalid, the VALID_TO field has to be set to a definite point in time. Remark: In the current implementation VALID_TO is never updated.
    CREATION_TIMESTAMP timestamp(6) with time zone NOT NULL,    -- Point in time (date and time), when the row was inserted into the database.
    MODIFICATION_TIMESTAMP timestamp(6) with time zone NULL    -- Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row. Remark:  In the current implementation of OA Content Service the MODIFICATION_TIMESTAMP is always NULL, as rows in the table are never updated.
)
;

CREATE TABLE OA_CONTENT.VALIDITY
(
    VALIDITY_ID bigserial NOT NULL,    -- Internal Id of the VALIDITY table. Used as PK.
    OBJECT_ID bigint NOT NULL,    -- Reference to the associated object in the OBJECT table.
    VALIDITY_TYPE_ID bigint NOT NULL,    -- Id of the validity type. This column is a reference to the VALIDITY_TYPE table, where the possible validity types are defined.
    VALIDITY_CODE varchar(50) NOT NULL    -- Value of the validity code. Example values for validities of type "equipment_code" (FIO):  - "ZX_581" (for automatic air conditioning) - "ZX_Diesel_L" (for all kinds of Diesel motors).
)
;

CREATE TABLE OA_CONTENT.VALIDITY_TYPE
(
    VALIDITY_TYPE_ID bigserial NOT NULL,    -- Internal Id of the validity type. Used as PK.
    VALIDITY_TYPE_NAME varchar(50) NOT NULL,    -- Name of the validity_type. Example value: "equipment_code", which defines a certain technical feature of a vehicle, like a certain motor, air conditioning, etc.
    DESCRIPTION varchar(255) NULL    -- Optional description field, which can be used to describe the meaning of the validity type.
)
;



ALTER TABLE OA_CONTENT.SYS_PARAM ADD CONSTRAINT PK_SYS_PARAM
    PRIMARY KEY (SYS_PARAM_ID)
;

ALTER TABLE OA_CONTENT.SYS_PARAM
  ADD CONSTRAINT UK_SYS_PARAM_SEC_KEY UNIQUE (PAR_NAME)
;

ALTER TABLE OA_CONTENT.OBJECT_TYPE ADD CONSTRAINT PK_OBJECT_TYPE
    PRIMARY KEY (OBJECT_TYPE_ID)
;

ALTER TABLE OA_CONTENT.OBJECT_TYPE
  ADD CONSTRAINT UK_OBJECT_TYPE_NAME UNIQUE (OBJECT_TYPE_NAME)
;

ALTER TABLE OA_CONTENT.RELATION_TYPE ADD CONSTRAINT PK_RELATION_TYPE
    PRIMARY KEY (RELATION_TYPE_ID)
;

ALTER TABLE OA_CONTENT.RELATION_TYPE
  ADD CONSTRAINT UK_RELATION_TYPE_NAME UNIQUE (RELATION_TYPE_NAME)
;

ALTER TABLE OA_CONTENT.SOURCE_SYSTEM ADD CONSTRAINT PK_SOURCE_SYSTEM
    PRIMARY KEY (SOURCE_SYSTEM_ID)
;

ALTER TABLE OA_CONTENT.SOURCE_SYSTEM
  ADD CONSTRAINT UK_SOURCE_SYSTEM_NAME UNIQUE (SOURCE_SYSTEM_NAME)
;

ALTER TABLE OA_CONTENT.RELATION ADD CONSTRAINT PK_RELATION
    PRIMARY KEY (RELATION_ID)
;

ALTER TABLE OA_CONTENT.RELATION
  ADD CONSTRAINT UK_RELATION_SEC_KEY UNIQUE (OBJECT_ID_1,RELATION_TYPE_ID,OBJECT_ID_2,OBJECT_ID_CONTEXT)
;

CREATE INDEX IXFK_RELATION_OBJECT_1 ON OA_CONTENT.RELATION (OBJECT_ID_1 ASC)
;

CREATE INDEX IXFK_RELATION_OBJECT_2 ON OA_CONTENT.RELATION (OBJECT_ID_2 ASC)
;

CREATE INDEX IXFK_RELATION_OBJECT_CONTEXT ON OA_CONTENT.RELATION (OBJECT_ID_CONTEXT ASC)
;

CREATE INDEX IXFK_RELATION_RELATION_TYPE ON OA_CONTENT.RELATION (RELATION_TYPE_ID ASC)
;

ALTER TABLE OA_CONTENT.OBJECT ADD CONSTRAINT PK_OBJECT
    PRIMARY KEY (OBJECT_ID)
;

ALTER TABLE OA_CONTENT.OBJECT
  ADD CONSTRAINT UK_OBJECT_ID_FROM_SOURCE_SOURCE_SYS UNIQUE (OBJECT_ID_FROM_SOURCE,SOURCE_SYSTEM_ID)
;

CREATE INDEX IXFK_OBJECT_OBJECT_TYPE ON OA_CONTENT.OBJECT (OBJECT_TYPE_ID ASC)
;

CREATE INDEX IXFK_OBJECT_SOURCE_SYSTEM ON OA_CONTENT.OBJECT (SOURCE_SYSTEM_ID ASC)
;

ALTER TABLE OA_CONTENT.VEHICLE_LINE ADD CONSTRAINT PK_VEHICLE_LINE
    PRIMARY KEY (OBJECT_ID)
;

ALTER TABLE OA_CONTENT.VEHICLE_LINE
  ADD CONSTRAINT UK_VEHICLE_LINE_SEC_KEY UNIQUE (VEHICLE_LINE_LEAD,VEHICLE_LINE_VARIANT,VEHICLE_LINE_MARKET,BUSINESS_LINE)
;

CREATE INDEX IXFK_VEHICLE_LINE_OBJECT ON OA_CONTENT.VEHICLE_LINE (OBJECT_ID ASC)
;

CREATE INDEX IX_VEHICLE_LINE_LEAD ON OA_CONTENT.VEHICLE_LINE (VEHICLE_LINE_LEAD ASC)
;

CREATE INDEX IX_VEHICLE_LINE_VARIANT ON OA_CONTENT.VEHICLE_LINE (VEHICLE_LINE_VARIANT ASC)
;

CREATE INDEX IX_VEHICLE_LINE_MARKET ON OA_CONTENT.VEHICLE_LINE (VEHICLE_LINE_MARKET ASC)
;

ALTER TABLE OA_CONTENT.TARGET_DEVICE ADD CONSTRAINT PK_TARGET_DEVICE
    PRIMARY KEY (OBJECT_ID)
;

ALTER TABLE OA_CONTENT.TARGET_DEVICE
  ADD CONSTRAINT UK_TARGET_DEVICE_SEC_KEY UNIQUE (DEVICE,MODEL,MODEL_VARIANT,DEVICE_MARKET)
;

CREATE INDEX IXFK_TARGET_DEVICE_OBJECT ON OA_CONTENT.TARGET_DEVICE (OBJECT_ID ASC)
;

CREATE INDEX IX_TARGET_DEVICE_MODEL ON OA_CONTENT.TARGET_DEVICE (MODEL ASC)
;

CREATE INDEX IX_TARGET_DEVICE_MODEL_VARIANT ON OA_CONTENT.TARGET_DEVICE (MODEL_VARIANT ASC)
;

CREATE INDEX IX_TARGET_DEVICE_MARKET ON OA_CONTENT.TARGET_DEVICE (DEVICE_MARKET ASC)
;

CREATE INDEX IX_TARGET_DEVICE_SCREEN_WIDTH_HIGHT ON OA_CONTENT.TARGET_DEVICE (SCREEN_WIDTH ASC,SCREEN_HEIGHT ASC)
;

CREATE INDEX IX_TARGET_DEVICE_SCREEN_HEIGHT ON OA_CONTENT.TARGET_DEVICE (SCREEN_HEIGHT ASC)
;

ALTER TABLE OA_CONTENT.MARKET ADD CONSTRAINT PK_MARKET
    PRIMARY KEY (OBJECT_ID)
;

ALTER TABLE OA_CONTENT.MARKET
  ADD CONSTRAINT UK_MARKET_SEC_KEY UNIQUE (MARKET)
;

CREATE INDEX IXFK_MARKET_OBJECT ON OA_CONTENT.MARKET (OBJECT_ID ASC)
;

ALTER TABLE OA_CONTENT.PUB_EDITION ADD CONSTRAINT PK_PUB_EDITION
    PRIMARY KEY (OBJECT_ID)
;

ALTER TABLE OA_CONTENT.PUB_EDITION
  ADD CONSTRAINT UK_PUB_EDITION_PA_ID_SEC_KEY UNIQUE (PA_ID)
;

CREATE INDEX IXFK_PUB_EDITION_OBJECT ON OA_CONTENT.PUB_EDITION (OBJECT_ID ASC)
;

CREATE INDEX IX_PA_ID ON OA_CONTENT.PUB_EDITION (PA_ID ASC)
;

ALTER TABLE OA_CONTENT.STATE_OF_CONSTRUCTION ADD CONSTRAINT PK_STATE_OF_CONSTRUCTION
    PRIMARY KEY (OBJECT_ID)
;

ALTER TABLE OA_CONTENT.STATE_OF_CONSTRUCTION
  ADD CONSTRAINT UK_STATE_OF_CONSTRUCTION_SEC_KEY UNIQUE (STATE_OF_CONSTRUCTION)
;

CREATE INDEX IXFK_STATE_OF_CONSTRUCTION_OBJECT ON OA_CONTENT.STATE_OF_CONSTRUCTION (OBJECT_ID ASC)
;

CREATE INDEX IX_STATE_OF_CONSTRUCTION ON OA_CONTENT.STATE_OF_CONSTRUCTION (STATE_OF_CONSTRUCTION ASC)
;

ALTER TABLE OA_CONTENT.INFO_PRODUCT ADD CONSTRAINT PK_INFO_PRODUCT
    PRIMARY KEY (OBJECT_ID)
;

ALTER TABLE OA_CONTENT.INFO_PRODUCT
  ADD CONSTRAINT UK_INFO_PRODUCT_NAME UNIQUE (IP_NAME)
;

CREATE INDEX IXFK_INFO_PRODUCT_OBJECT ON OA_CONTENT.INFO_PRODUCT (OBJECT_ID ASC)
;

ALTER TABLE OA_CONTENT.OBJECT_PAYLOAD ADD CONSTRAINT PK_OBJECT_PAYLOAD
    PRIMARY KEY (OBJECT_PAYLOAD_ID)
;

ALTER TABLE OA_CONTENT.OBJECT_PAYLOAD
  ADD CONSTRAINT UK_OBJECT_PAYLOAD_SEC_KEY UNIQUE (OBJECT_ID,MIME_TYPE)
;

CREATE INDEX IXFK_OBJECT_PAYLOAD_OBJECT ON OA_CONTENT.OBJECT_PAYLOAD (OBJECT_ID ASC)
;

CREATE INDEX IX_OBJECT_PAYLOAD_MIME_TYPE ON OA_CONTENT.OBJECT_PAYLOAD (MIME_TYPE ASC)
;

ALTER TABLE OA_CONTENT.TEXT_DATA ADD CONSTRAINT PK_TEXT_DATA
    PRIMARY KEY (TEXT_DATA_ID)
;

ALTER TABLE OA_CONTENT.TEXT_DATA
  ADD CONSTRAINT UK_TEXT_DATA_SEC_KEY_V UNIQUE (DATA_ID_FROM_SOURCE,VERSION_FROM_SOURCE,OBJECT_PAYLOAD_ID)
;

ALTER TABLE OA_CONTENT.TEXT_DATA
  ADD CONSTRAINT UK_TEXT_DATA_SEC_KEY_R UNIQUE (DATA_ID_FROM_SOURCE,REVISION,OBJECT_PAYLOAD_ID)
;

CREATE INDEX IXFK_TEXT_DATA_OBJECT_PAYLOAD ON OA_CONTENT.TEXT_DATA (OBJECT_PAYLOAD_ID ASC)
;

ALTER TABLE OA_CONTENT.MEDIA_REF_DATA ADD CONSTRAINT PK_MEDIA_REF_DATA
    PRIMARY KEY (MEDIA_REF_DATA_ID)
;

ALTER TABLE OA_CONTENT.MEDIA_REF_DATA
  ADD CONSTRAINT UK_MEDIA_REF_DATA_SEC_KEY_V UNIQUE (DATA_ID_FROM_SOURCE,VERSION_FROM_SOURCE,OBJECT_PAYLOAD_ID,LANGUAGE,LOCALE)
;

ALTER TABLE OA_CONTENT.MEDIA_REF_DATA
  ADD CONSTRAINT UK_MEDIA_REF_DATA_SEC_KEY_R UNIQUE (DATA_ID_FROM_SOURCE,REVISION,OBJECT_PAYLOAD_ID,LANGUAGE,LOCALE)
;

CREATE INDEX IXFK_MEDIA_REF_DATA_OBJECT_PAYLOAD ON OA_CONTENT.MEDIA_REF_DATA (OBJECT_PAYLOAD_ID ASC)
;

CREATE INDEX IX_MEDIA_REF_DATA_EXT_MEDIA_ID ON OA_CONTENT.MEDIA_REF_DATA (EXT_MEDIA_ID ASC)
;

ALTER TABLE OA_CONTENT.XML_DATA ADD CONSTRAINT PK_XML_DATA
    PRIMARY KEY (XML_DATA_ID)
;

ALTER TABLE OA_CONTENT.XML_DATA
  ADD CONSTRAINT UK_XML_DATA_SEC_KEY_V UNIQUE (DATA_ID_FROM_SOURCE,VERSION_FROM_SOURCE,MD5_CHECKSUM,OBJECT_PAYLOAD_ID,LANGUAGE,LOCALE)
;

ALTER TABLE OA_CONTENT.XML_DATA
  ADD CONSTRAINT UK_XML_DATA_SEC_KEY_R UNIQUE (DATA_ID_FROM_SOURCE,REVISION,OBJECT_PAYLOAD_ID,LANGUAGE,LOCALE)
;

CREATE INDEX IXFK_XML_DATA_OBJECT_PAYLOAD ON OA_CONTENT.XML_DATA (OBJECT_PAYLOAD_ID ASC)
;

CREATE INDEX IX_XML_DATA_TITLE ON OA_CONTENT.XML_DATA (TITLE ASC)
;

ALTER TABLE OA_CONTENT.IMAGE_DATA ADD CONSTRAINT PK_IMAGE_DATA
    PRIMARY KEY (IMAGE_DATA_ID)
;

ALTER TABLE OA_CONTENT.IMAGE_DATA
  ADD CONSTRAINT UK_IMAGE_DATA_SEC_KEY_V UNIQUE (DATA_ID_FROM_SOURCE,VERSION_FROM_SOURCE,OBJECT_PAYLOAD_ID)
;

ALTER TABLE OA_CONTENT.IMAGE_DATA
  ADD CONSTRAINT UK_IMAGE_DATA_SEC_KEY_R UNIQUE (DATA_ID_FROM_SOURCE,REVISION,OBJECT_PAYLOAD_ID)
;

CREATE INDEX IXFK_IMAGE_DATA_OBJECT_PAYLOAD ON OA_CONTENT.IMAGE_DATA (OBJECT_PAYLOAD_ID ASC)
;

ALTER TABLE OA_CONTENT.XML_DATA_SEARCH_META ADD CONSTRAINT PK_XML_DATA_SEARCH_META
    PRIMARY KEY (XML_DATA_SEARCH_META_ID)
;

ALTER TABLE OA_CONTENT.XML_DATA_SEARCH_META
  ADD CONSTRAINT UK_XML_DATA_SEARCH_META_SEC_KEY UNIQUE (XML_DATA_ID,SEARCH_META_ID)
;

CREATE INDEX IXFK_XML_DATA_SEARCH_META_XML_DATA ON OA_CONTENT.XML_DATA_SEARCH_META (XML_DATA_ID ASC)
;

CREATE INDEX IXFK_XML_DATA_SEARCH_META_SEARCH_META ON OA_CONTENT.XML_DATA_SEARCH_META (SEARCH_META_ID ASC)
;

ALTER TABLE OA_CONTENT.KEYWORD ADD CONSTRAINT PK_KEYWORD
    PRIMARY KEY (KEYWORD_ID)
;

ALTER TABLE OA_CONTENT.KEYWORD
  ADD CONSTRAINT UK_KEYWORD_SEC_KEY UNIQUE (KEYWORD_VALUE,SEARCH_META_ID)
;

CREATE INDEX IXFK_KEYWORD_SEARCH_META ON OA_CONTENT.KEYWORD (SEARCH_META_ID ASC)
;

ALTER TABLE OA_CONTENT.CONTENT_REQUEST ADD CONSTRAINT PK_CONTENT_REQUEST
    PRIMARY KEY (CONTENT_REQUEST_ID)
;

CREATE INDEX IX_CONTENT_REQUEST_RESPONSE_TIMESTAMP ON OA_CONTENT.CONTENT_REQUEST (RESPONSE_TIMESTAMP ASC,REQUEST_TYPE ASC)
;

CREATE INDEX IX_CONTENT_REQUEST_REQUEST_TIMESTAMP ON OA_CONTENT.CONTENT_REQUEST (REQUEST_TIMESTAMP ASC,REQUEST_TYPE ASC)
;

CREATE INDEX IX_CONTENT_REQUEST_RESULT_TIMESTAMP ON OA_CONTENT.CONTENT_REQUEST (RESULT_TIMESTAMP ASC,REQUEST_TYPE ASC)
;

CREATE INDEX IX_CONTENT_REQUEST_STATUS ON OA_CONTENT.CONTENT_REQUEST (STATUS ASC)
;

ALTER TABLE OA_CONTENT.PHONEME ADD CONSTRAINT PK_PHONEME
    PRIMARY KEY (PHONEME_ID)
;

ALTER TABLE OA_CONTENT.PHONEME
  ADD CONSTRAINT UK_PHONEME_SEC_KEY UNIQUE (PHONEME_VALUE,KEYWORD_ID)
;

CREATE INDEX IXFK_PHONEME_KEYWORD ON OA_CONTENT.PHONEME (KEYWORD_ID ASC)
;

ALTER TABLE OA_CONTENT.SEARCH_META ADD CONSTRAINT PK_SEARCH_META
    PRIMARY KEY (SEARCH_META_ID)
;

ALTER TABLE OA_CONTENT.SEARCH_META
  ADD CONSTRAINT UK_SEARCH_META_SEC_KEY_V UNIQUE (SEARCH_META_ID_FROM_SOURCE,VERSION_FROM_SOURCE,MD5_CHECKSUM,LANGUAGE,LOCALE)
;

ALTER TABLE OA_CONTENT.SEARCH_META
  ADD CONSTRAINT UK_SEARCH_META_SEC_KEY_R UNIQUE (SEARCH_META_ID_FROM_SOURCE,VERSION_FROM_SOURCE,REVISION,LANGUAGE,LOCALE)
;

ALTER TABLE OA_CONTENT.VALIDITY ADD CONSTRAINT PK_VALIDITY
    PRIMARY KEY (VALIDITY_ID)
;

ALTER TABLE OA_CONTENT.VALIDITY
  ADD CONSTRAINT UK_VALIDITY_SEC_KEY UNIQUE (OBJECT_ID,VALIDITY_CODE,VALIDITY_TYPE_ID)
;

CREATE INDEX IXFK_VALIDITY_OBJECT ON OA_CONTENT.VALIDITY (OBJECT_ID ASC)
;

CREATE INDEX IXFK_VALIDITY_VALIDITY_TYPE ON OA_CONTENT.VALIDITY (VALIDITY_TYPE_ID ASC)
;

ALTER TABLE OA_CONTENT.VALIDITY_TYPE ADD CONSTRAINT PK_VALIDITY_TYPE
    PRIMARY KEY (VALIDITY_TYPE_ID)
;

ALTER TABLE OA_CONTENT.VALIDITY_TYPE
  ADD CONSTRAINT UK_VALIDITY_TYPE_NAME UNIQUE (VALIDITY_TYPE_NAME)
;



ALTER TABLE OA_CONTENT.RELATION ADD CONSTRAINT FK_RELATION_OBJECT_1
    FOREIGN KEY (OBJECT_ID_1) REFERENCES OA_CONTENT.OBJECT (OBJECT_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.RELATION ADD CONSTRAINT FK_RELATION_OBJECT_2
    FOREIGN KEY (OBJECT_ID_2) REFERENCES OA_CONTENT.OBJECT (OBJECT_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.RELATION ADD CONSTRAINT FK_RELATION_OBJECT_CONTEXT
    FOREIGN KEY (OBJECT_ID_CONTEXT) REFERENCES OA_CONTENT.OBJECT (OBJECT_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.RELATION ADD CONSTRAINT FK_RELATION_RELATION_TYPE
    FOREIGN KEY (RELATION_TYPE_ID) REFERENCES OA_CONTENT.RELATION_TYPE (RELATION_TYPE_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.OBJECT ADD CONSTRAINT FK_OBJECT_OBJECT_TYPE
    FOREIGN KEY (OBJECT_TYPE_ID) REFERENCES OA_CONTENT.OBJECT_TYPE (OBJECT_TYPE_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.OBJECT ADD CONSTRAINT FK_OBJECT_SOURCE_SYSTEM
    FOREIGN KEY (SOURCE_SYSTEM_ID) REFERENCES OA_CONTENT.SOURCE_SYSTEM (SOURCE_SYSTEM_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.VEHICLE_LINE ADD CONSTRAINT FK_VEHICLE_LINE_OBJECT
    FOREIGN KEY (OBJECT_ID) REFERENCES OA_CONTENT.OBJECT (OBJECT_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.TARGET_DEVICE ADD CONSTRAINT FK_TARGET_DEVICE_OBJECT
    FOREIGN KEY (OBJECT_ID) REFERENCES OA_CONTENT.OBJECT (OBJECT_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.MARKET ADD CONSTRAINT FK_MARKET_OBJECT
    FOREIGN KEY (OBJECT_ID) REFERENCES OA_CONTENT.OBJECT (OBJECT_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.PUB_EDITION ADD CONSTRAINT FK_PUB_EDITION_OBJECT
    FOREIGN KEY (OBJECT_ID) REFERENCES OA_CONTENT.OBJECT (OBJECT_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.STATE_OF_CONSTRUCTION ADD CONSTRAINT FK_STATE_OF_CONSTRUCTION_OBJECT
    FOREIGN KEY (OBJECT_ID) REFERENCES OA_CONTENT.OBJECT (OBJECT_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.INFO_PRODUCT ADD CONSTRAINT FK_INFO_PRODUCT_OBJECT
    FOREIGN KEY (OBJECT_ID) REFERENCES OA_CONTENT.OBJECT (OBJECT_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.OBJECT_PAYLOAD ADD CONSTRAINT FK_OBJECT_PAYLOAD_OBJECT
    FOREIGN KEY (OBJECT_ID) REFERENCES OA_CONTENT.OBJECT (OBJECT_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.TEXT_DATA ADD CONSTRAINT FK_TEXT_DATA_OBJECT_PAYLOAD
    FOREIGN KEY (OBJECT_PAYLOAD_ID) REFERENCES OA_CONTENT.OBJECT_PAYLOAD (OBJECT_PAYLOAD_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.MEDIA_REF_DATA ADD CONSTRAINT FK_MEDIA_REF_DATA_OBJECT_PAYLOAD
    FOREIGN KEY (OBJECT_PAYLOAD_ID) REFERENCES OA_CONTENT.OBJECT_PAYLOAD (OBJECT_PAYLOAD_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.XML_DATA ADD CONSTRAINT FK_XML_DATA_OBJECT_PAYLOAD
    FOREIGN KEY (OBJECT_PAYLOAD_ID) REFERENCES OA_CONTENT.OBJECT_PAYLOAD (OBJECT_PAYLOAD_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.IMAGE_DATA ADD CONSTRAINT FK_IMAGE_DATA_OBJECT_PAYLOAD
    FOREIGN KEY (OBJECT_PAYLOAD_ID) REFERENCES OA_CONTENT.OBJECT_PAYLOAD (OBJECT_PAYLOAD_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.XML_DATA_SEARCH_META ADD CONSTRAINT FK_XML_DATA_SEARCH_META_SEARCH_META
    FOREIGN KEY (SEARCH_META_ID) REFERENCES OA_CONTENT.SEARCH_META (SEARCH_META_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.XML_DATA_SEARCH_META ADD CONSTRAINT FK_XML_DATA_SEARCH_META_XML_DATA
    FOREIGN KEY (XML_DATA_ID) REFERENCES OA_CONTENT.XML_DATA (XML_DATA_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.KEYWORD ADD CONSTRAINT FK_KEYWORD_SEARCH_META
    FOREIGN KEY (SEARCH_META_ID) REFERENCES OA_CONTENT.SEARCH_META (SEARCH_META_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.PHONEME ADD CONSTRAINT FK_PHONEME_KEYWORD
    FOREIGN KEY (KEYWORD_ID) REFERENCES OA_CONTENT.KEYWORD (KEYWORD_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.VALIDITY ADD CONSTRAINT FK_VALIDITY_OBJECT
    FOREIGN KEY (OBJECT_ID) REFERENCES OA_CONTENT.OBJECT (OBJECT_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE OA_CONTENT.VALIDITY ADD CONSTRAINT FK_VALIDITY_VALIDITY_TYPE
    FOREIGN KEY (VALIDITY_TYPE_ID) REFERENCES OA_CONTENT.VALIDITY_TYPE (VALIDITY_TYPE_ID) ON DELETE No Action ON UPDATE No Action
;



COMMENT ON TABLE OA_CONTENT.SYS_PARAM
    IS 'This table is used to store the names and values of system parameters, which are valid for the whole system, like software versions, paths, etc.'
;

COMMENT ON COLUMN OA_CONTENT.SYS_PARAM.SYS_PARAM_ID
    IS 'Internal Id. Primary key of the table.'
;

COMMENT ON COLUMN OA_CONTENT.SYS_PARAM.PAR_NAME
    IS 'Name of the parameter.  This must be unique for all rows in the table.'
;

COMMENT ON COLUMN OA_CONTENT.SYS_PARAM.PAR_VALUE
    IS 'Value of the parameter.'
;

COMMENT ON COLUMN OA_CONTENT.SYS_PARAM.PAR_DESCRIPTION
    IS 'Description of the parameter. It should describe the meaning of the specific parameter or for what purpose the parameter is needed.'
;



COMMENT ON TABLE OA_CONTENT.OBJECT_TYPE
    IS 'Reference table, which is used to define the possible object types for objects in the generic OBJECT table.'
;

COMMENT ON COLUMN OA_CONTENT.OBJECT_TYPE.OBJECT_TYPE_ID
    IS 'Internal Id of the OBJECT_TYPE table. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.OBJECT_TYPE.OBJECT_TYPE_NAME
    IS 'Name of the object type. Examples:  "topic" (for ARKI4 quickstart topics, disclaimers, ...), "main_menu_item" (for ARKI4 y.io.type = "arki-frag-functionlist"), "sub_menu_item" (for ARKI4 y.io.type = "arki-frag-title"), "ip" (= Information Product),  "tdev" (= Target Device);  "vehline" (= Vehicle Line),  "market", etc.  '
;

COMMENT ON COLUMN OA_CONTENT.OBJECT_TYPE.DESCRIPTION
    IS 'Optional description field, which can be used to describe the meaning of the object type.'
;



COMMENT ON TABLE OA_CONTENT.RELATION_TYPE
    IS 'Reference table, which defines the possible values of relation types to be used in the generic RELATION table.'
;

COMMENT ON COLUMN OA_CONTENT.RELATION_TYPE.RELATION_TYPE_ID
    IS 'Internal Id of the RELATION_TYPE table. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.RELATION_TYPE.RELATION_TYPE_NAME
    IS 'Name of the relation type. Examples could be: "is-valid-for", "references", ...'
;

COMMENT ON COLUMN OA_CONTENT.RELATION_TYPE.DESCRIPTION
    IS 'Optional description field, which can be used to describe the meaning of the relation type.'
;



COMMENT ON TABLE OA_CONTENT.SOURCE_SYSTEM
    IS 'Reference table, which is used to define the source systems, which can be the possible data sources for content that is stored in the generic tables of the OA Content Data domain. Possible Source Systems might be: - "arki4" - "oa" (for objects, which are created inside the OA System and have no external origin) - "zebra" for PDF documents.'
;

COMMENT ON COLUMN OA_CONTENT.SOURCE_SYSTEM.SOURCE_SYSTEM_ID
    IS 'Internal Id of the SOURCE_SYSTEM table. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.SOURCE_SYSTEM.SOURCE_SYSTEM_NAME
    IS 'Name of the Source System in lower case letters.  Examples: "arki4", "oa" (for the OA-System itself).'
;

COMMENT ON COLUMN OA_CONTENT.SOURCE_SYSTEM.DESCRIPTION
    IS 'Optional description field, which can be used to describe the source system.'
;



COMMENT ON TABLE OA_CONTENT.RELATION
    IS 'Generic table for establishing relationships between two objects. Sometimes (e.g. for ''has-next-sibling'' relations) a third object, which provides a context for the relationship, is involved. The relationships can be of different types, which are similar to the predicate in a RDF triple. This table represents a (n, m, k) relationship between OBJECT, OBJECT and OBJECT. The third object_id is optional. So in most cases we have a (n, m) relationship between two objects.'
;

COMMENT ON COLUMN OA_CONTENT.RELATION.RELATION_ID
    IS 'Internal Id of the RELATION table. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.RELATION.OBJECT_ID_1
    IS 'Reference to the OBJECT_ID of the first object of the relationship. In RDF notation it stands for the subject in the (subject - predicate - object) triple.'
;

COMMENT ON COLUMN OA_CONTENT.RELATION.RELATION_TYPE_ID
    IS 'Id of the relation type between the two referenced objects. This Id references a row in the RELATION_TYPE table.  In RDF notation the relation type stands for the predicate in the (subject - predicate - object) triple. Possible values for RELATION_TYPE_ID reference relation types names like: - "is-valid-for" - "references" - "is-child-of", - ... Only certain combinations of the types of the two objects and the relation type make sense.'
;

COMMENT ON COLUMN OA_CONTENT.RELATION.OBJECT_ID_2
    IS 'Reference to the OBJECT_ID of the second object of the relationship. In RDF notation it stands for the object in the (subject - predicate - object) triple.'
;

COMMENT ON COLUMN OA_CONTENT.RELATION.OBJECT_ID_CONTEXT
    IS 'Optional third OBJECT_ID, which references a row from the OBJECT table to provide a context for the relation between object 1 and object 2. For most relations this column will be set to a dummy object (-1) to avoid conflicts with NULL values in the extended unique constraint.  For relations of type ''has-next-sibling'', which express the order of sub menu items or topics in the menu hierarchy, the OBJECT_ID_CONTEXT has to be the parent object_id, because the order is only unique in the context of the parent menu item, if the same sub menu item or topic can appear at different places in the menu structure. For ''has-next-sibling'' relations on the top level of the menu hierarchy the OBJECT_ID_CONTEXT is -1, as main menu items (=function-lists) are the roots of the menu trees and don''t have a parent. For ''has-next-sibling'' relations on all other levels of the menu hierarchy the OBJECT_ID_CONTEXT has to be populated with the object_id of the parent object (from the ''is-child-of'' relation).'
;

COMMENT ON COLUMN OA_CONTENT.RELATION.VALID_FROM
    IS 'Point of time, from when this relationship is valid.  If the source system does not provide the start timestamp of the validity period, the application has to set this field to the current timestamp when inserting the row into the database. '
;

COMMENT ON COLUMN OA_CONTENT.RELATION.VALID_TO
    IS 'Point of time, until this relationship is valid.   When inserting the row into the DB, this field is usually set to ''9999-12-31'' to indicate that it is valid infinitely, if the source system does not provide the timestamp for the end of the validity period. When updating an object to make it invalid, the VALID_TO field has to be set to a definite point in time.'
;

COMMENT ON COLUMN OA_CONTENT.RELATION.CREATION_TIMESTAMP
    IS 'Point in time (date and time), when the row was inserted into the database.'
;

COMMENT ON COLUMN OA_CONTENT.RELATION.MODIFICATION_TIMESTAMP
    IS 'Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row.'
;



COMMENT ON TABLE OA_CONTENT.OBJECT
    IS 'The OBJECT table holds objects of different types. These objects belong to the OA Content Data domain.'
;

COMMENT ON COLUMN OA_CONTENT.OBJECT.OBJECT_ID
    IS 'Internal Id of the OBJECT table. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.OBJECT.OBJECT_TYPE_ID
    IS 'Id of the object type. Reference to the associated row in the OBJECT_TYPE table.'
;

COMMENT ON COLUMN OA_CONTENT.OBJECT.SOURCE_SYSTEM_ID
    IS 'Id of the source system, which is the origin for the object. Reference to the associated row in the SOURCE_SYSTEM table.'
;

COMMENT ON COLUMN OA_CONTENT.OBJECT.OBJECT_ID_FROM_SOURCE
    IS 'Unique Identifier of this object in the source system.  For objects with payload from ARKI4 (topics, menu items, etc.) this value is composed from the y.io.id and an N-Tuple-Hash value, which is created from the concatenated validities of the object: <y.io.id>-<N-Tuple-MD5-Hash>.  For creating the N-Tuple-Hash at first the normalized validities of the object are concatenated like this:    ''<VEHICLE_LINE><STATE_OF_CONSTRUCTION><MARKET><TARGET_DEVICE><INFO_PRODUCT>''. In detail: ''<business_line><vehicle_line_lead><vehicle_line_variant><vehicle_line_market><state_of_construction><market><device><model><model_variant><device_market><ip_name>''. Example: ''p2231ma-ece/row808+059ece/rowntg7.0premiumhu-ece/rowip_diba''.   The MD5-Hash for this example string is ''c8cd3f15edb4435c109e4990ca2d3987''. The resulting OBJECT_ID_FROM_SOURCE for y.io.id = ''3afdb18ebd300ec3ac190d2b02b3e08f'' would then look like this:     ''3afdb18ebd300ec3ac190d2b02b3e08f-c8cd3f15edb4435c109e4990ca2d3987''.  For masterdata objects, which are created internally inside the OA System, this field contains the last part of the URI for that object in lower case letters. The complete URI looks like that: <OA_URI_SCHEME>:<OA_URI_AUTHORITY>:<object_type_name>:<object_id_from_source>. The values for OA_URI_SCHEME and OA_URI_AUTHORITY are parameters in the SYS_PARAM table. Object_type_name is from the OBJECT_TYPE table.  Example values for object_id from source for masterdata objects: - Vehicle-Line: "177:0:ma-ece/row:2018.04e:p", - State-of-Construction: "808+059", - Information Product: "ip_diba",  - Target Device: "ntg:6.0:entry:hu-ece/row", - Market: "ece/row".'
;

COMMENT ON COLUMN OA_CONTENT.OBJECT.OBJECT_TYPE_FROM_SOURCE
    IS 'Object type that is associated with this object in the source system. For objects from ARKI4 the origin for this field is the y.io.type. Example values for topics: "arki-frag-functionlist", "arki-frag-title" or "arki-topic-quickstart". Example value for a media_ref object: "mediahub-arkikipicng".'
;

COMMENT ON COLUMN OA_CONTENT.OBJECT.OBJECT_NAME_FROM_SOURCE
    IS 'Optional name of the object from the source system. It is only available for some object types. E.g. for object type ''cb_answer'' (chatbot answer) the value for this field is retrieved from: //answer.ref/@y.io.name.'
;



COMMENT ON TABLE OA_CONTENT.VEHICLE_LINE
    IS 'Table, which stores the specific metadata for a vehicle line object.'
;

COMMENT ON COLUMN OA_CONTENT.VEHICLE_LINE.OBJECT_ID
    IS 'PK column of the VEHICLE_LINE table. This Primary Key is inherited from the OBJECT table (as a VEHICLE_LINE is a special object) and it is also used as Foreign Key to reference the associated row in the OBJECT table.'
;

COMMENT ON COLUMN OA_CONTENT.VEHICLE_LINE.VEHICLE_LINE_LEAD
    IS 'Lead Vehicle Line (in german: Lead-Baureihe) in lower case letters.  Example value: "217".'
;

COMMENT ON COLUMN OA_CONTENT.VEHICLE_LINE.VEHICLE_LINE_VARIANT
    IS 'Variant of the vehicle line (german: Baureihen-Derivat) in lower case letters. Example value: "2". The vehicle line as a whole can be composed from <VEHICLE_LINE_LEAD>.<VEHICLE_LINE_VARIANT>. Example: "217.2".'
;

COMMENT ON COLUMN OA_CONTENT.VEHICLE_LINE.VEHICLE_LINE_MARKET
    IS 'Market, where the vehicle is built (in german: "Baureihen-Markt") in lower case letters. Example: "ma-ece/row".'
;

COMMENT ON COLUMN OA_CONTENT.VEHICLE_LINE.BUSINESS_LINE
    IS 'Business line (in german: Spartenkenner), to which the vehicle line belongs in lower case letters. At the moment the value should be "p" for "PKW" for all rows. (The german term "PKW" = Personenkraftwagen means "passenger car" in english).'
;

COMMENT ON COLUMN OA_CONTENT.VEHICLE_LINE.DESCRIPTION
    IS 'Optional description field.'
;

COMMENT ON TABLE OA_CONTENT.TARGET_DEVICE
    IS 'Table, which stores the specific metadata for a target device object. Target devices are the types of technical devices, which are the recipients for content from the OA System. Examples: NTG6.0 High or a specific iPhone model. '
;

COMMENT ON COLUMN OA_CONTENT.TARGET_DEVICE.OBJECT_ID
    IS 'PK column of the TARGET_DEVICE table. This Primary Key is inherited from the OBJECT table (as a TARGET_DEVICE is a special object) and it is also used as Foreign Key to reference the associated row in the OBJECT table.'
;

COMMENT ON COLUMN OA_CONTENT.TARGET_DEVICE.DEVICE
    IS 'Name of the target device in lower case letters. Examples: "ntg", "rse", "iphone", "web-browser", ..  TODO: the set of allowed values has to be specified or has to be extended, when more target devices are added as recipients for content from the OA System.'
;

COMMENT ON COLUMN OA_CONTENT.TARGET_DEVICE.MODEL
    IS 'Model or generation of the target device in lower case letters. Examples: For device "ntg" possible values for MODEL would be "6.0", "7.0". For device "iphone" a possible value for MODEL would be "8". This column may not have a value for all target devices.'
;

COMMENT ON COLUMN OA_CONTENT.TARGET_DEVICE.MODEL_VARIANT
    IS 'Model variant of the target device in lower case letters. This determines the hardware equipment.  Examples: For device "ntg"  and model "6.0" possible value for MODEL_VARIANT could be "entry540", "entry720", "mid540", "mid720" and "high". For device "iphone" and  MODEL "8" a possible value for MODEL_VARIANT could be "plus". This column may not have a value for all target devices.'
;

COMMENT ON COLUMN OA_CONTENT.TARGET_DEVICE.DEVICE_MARKET
    IS 'Market for the target device in lower case letters. This column may be empty for some target devices. In case of a "ntg" model for the DiBA on a vehicle this attribute contains the HU-Market, e.g. "hu-ece/row".'
;

COMMENT ON COLUMN OA_CONTENT.TARGET_DEVICE.SCREEN_WIDTH
    IS 'Screen resolution width in pixels.'
;

COMMENT ON COLUMN OA_CONTENT.TARGET_DEVICE.SCREEN_HEIGHT
    IS 'Screen resolution height in pixels.'
;

COMMENT ON COLUMN OA_CONTENT.TARGET_DEVICE.DESCRIPTION
    IS 'Optional description field.'
;

COMMENT ON TABLE OA_CONTENT.MARKET
    IS 'Table, which stores the specific metadata for a market object. The market stored here, is the market, for which an Owners Manual is intended for (e.g. "ece/row").'
;

COMMENT ON COLUMN OA_CONTENT.MARKET.OBJECT_ID
    IS 'PK column of the MARKET table. This Primary Key is inherited from the OBJECT table (as a MARKET is a special object) and it is also used as Foreign Key to reference the associated row in the OBJECT table.'
;

COMMENT ON COLUMN OA_CONTENT.MARKET.MARKET
    IS 'The market, for which the owners manual is intended for. (In german: "Auslieferungsmarkt"?) Example: "ece/row".'
;

COMMENT ON COLUMN OA_CONTENT.MARKET.DESCRIPTION
    IS 'Optional description field.'
;

COMMENT ON TABLE OA_CONTENT.PUB_EDITION
    IS 'Table, which stores the specific metadata for a pub-edition object. Example: PA180559'
;

COMMENT ON COLUMN OA_CONTENT.PUB_EDITION.OBJECT_ID
    IS 'PK column of the PUB_EDITION table.  This primary key is inherited from the OBJECT table (as a pub-edition (PA_ID) is a special object) and it is also used as foreign key to reference the associated row in the OBJECT table.'
;

COMMENT ON COLUMN OA_CONTENT.PUB_EDITION.PA_ID
    IS 'The PA-ID of the pub-edition, for which the owners manual is intended for. (In german: "Publikationsausgabe") Example: PA180559'
;

COMMENT ON TABLE OA_CONTENT.STATE_OF_CONSTRUCTION
    IS 'Table, which stores the specific metadata for a state-of-construction object. Example: 808+059'
;

COMMENT ON COLUMN OA_CONTENT.STATE_OF_CONSTRUCTION.OBJECT_ID
    IS 'PK column of the STATE_OF_CONSTRUCTION table.  This primary key is inherited from the OBJECT table (as a state-of-construction is a special object) and it is also used as foreign key to reference the associated row in the OBJECT table.'
;

COMMENT ON COLUMN OA_CONTENT.STATE_OF_CONSTRUCTION.STATE_OF_CONSTRUCTION
    IS 'The state-of-construction, for which the owners manual is intended for. (In german: "Bauzustand") Example: 808+059'
;

COMMENT ON TABLE OA_CONTENT.INFO_PRODUCT
    IS 'Table, which stores the specific metadata for an information product object. Information products are the possible target media for the content, which is stored in the OA Content Data Domain.'
;

COMMENT ON COLUMN OA_CONTENT.INFO_PRODUCT.OBJECT_ID
    IS 'PK column of the INFO_PRODUCT table. This Primary Key is inherited from the OBJECT table (as an information product is a special object) and it is also used as Foreign Key to reference the associated row in the OBJECT table.'
;

COMMENT ON COLUMN OA_CONTENT.INFO_PRODUCT.IP_NAME
    IS 'Name of the information product. This short name uniquely identifies the target medium.  Possible values for IP-Names are at the moment: - "ip_diba" (this is the digital OM on the HU of a vehicle) - "ip_baix" (for the OM on the MercedesMe web page = DPP = Digital Product Page ) - "ip_guide" (OM in Mobile Phone App) - "ip_print" (OM printed on paper)'
;

COMMENT ON COLUMN OA_CONTENT.INFO_PRODUCT.DESCRIPTION
    IS 'Optional description field.'
;

COMMENT ON TABLE OA_CONTENT.OBJECT_PAYLOAD
    IS 'General table for object data for objects, which have a payload. It contains the mime type, which tells us something about the format of the object payload. Depending on the OBJECT_TYPE (from the OBJECT / OBJECT_TYPE tables) and on the MIME_TYPE (from the OBJECT_PAYLOAD table) the actual payload data is stored in a specific data table, e.g. XML_DATA, MEDIA_REF_DATA, ... There could be several rows in the OBJECT_PAYLOAD table for one object. E.g. if the same IMAGE_DATA object exists with different mime-types (JPG, PNG, ...). But for one object there can be only one row in this table for the same mime-type. Objects without a payload (e.g. Information Products, Target Devices, etc.) don''t have an entry in this table.'
;

COMMENT ON COLUMN OA_CONTENT.OBJECT_PAYLOAD.OBJECT_PAYLOAD_ID
    IS 'Internal Id of the table, which is used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.OBJECT_PAYLOAD.OBJECT_ID
    IS 'Reference to the associated object in the OBJECT table.'
;

COMMENT ON COLUMN OA_CONTENT.OBJECT_PAYLOAD.MIME_TYPE
    IS 'The MIME type specifies the data format of the object''s payload. It also determines in which special data table the actual data is stored.  Currently used mime types are: - ''text/xml'' for objects with a payload in table XML_DATA (like topics, menu items, ...), - ''image'' for objects with a payload in table MEDIA_REF_DATA .    Examples for possible other MIME types would be: - ''text/plain''  - ''image/png''  - ''image/jpeg'' - ''video/mp4''  - ''text/xml'' - ''application/pdf'' - application/json''  TODO: (to be clarified for future use):  - If we don''t store the image or video itself, but only a reference, the MIME type maybe would not be ''image/...'' or ''video/...''.  Should we really use a mime type prefix like ''image'' or maybe ''text/plain'', ''text/url'' or no mime type at all?  - If we would store a PDF document as a base64 encoded text, the MIME type would not be ''application/pdf'' but ''application/base64'' and we would store it in a column with data type TEXT? Or would the MIME type be text/plain ?  - Will we need a kind of mapping of (OBJECT.type, OBJECT_PAYLOAD.mime_type) to the name of the data table, where we stored the actual data, maybe not in the database, but somewhere?  - Maybe we will later split this field into two fields for mediatype (''image'', ''application'', ...) and subtype (''jpeg'', ''png'', ''text''...), because we sometimes only use the mediatype.'
;



COMMENT ON TABLE OA_CONTENT.TEXT_DATA
    IS 'CURRENTLY NOT USED !!!!  This table can be used for storing the data of all objects with a payload, which  consists of a text or a string. For one OBJECT_PAYLOAD row  there can be many rows in the TEXT_DATA table, one for each language/locale.  TODO: Do we need an extra encoding column (NULLable ?) What would this column contain, if the text is not encoded? '
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.TEXT_DATA_ID
    IS 'Internal Id of the TEXT_DATA table. PK of the table.'
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.OBJECT_PAYLOAD_ID
    IS 'Reference to the associated row in the OBJECT_PAYLOAD table.'
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.DATA_ID_FROM_SOURCE
    IS 'Id, which identifies the object data inside the source system. For objects from ARKI4, the value can be retrieved from the y.id.'
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.LANGUAGE
    IS 'Language of the object data.  Examples: "de", "en", ...  The attributes LANGUAGE and LOCALE can be concatenated: e.g. "de_DE", "en_GB", ...'
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.LOCALE
    IS 'This field refers to the localization of the LANGUAGE used in different countries.  For data from a ARKI4 Super-XML this field holds the value written in the "variant" field of the Super-XML.'
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.DATA
    IS 'This field contains the actual data of the object payload as a TEXT field.'
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.REVISION
    IS 'OA internal revision or version of the object data. Revisions of the same object may differ for different languages. The revision values start with 1, 2, 3, ...'
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.VERSION_FROM_SOURCE
    IS 'Version of the object data from the source system.  For objects from ARKI4 the origin of this field is y.io.version. This field is nullable, because some source systems might not have a version for their objects. Caution: the data type of this column is a string. So comparisons or min/max might not work: Ex. 100 < 21. Versions like "1.2.3" might be used in some source systems.'
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.MD5_CHECKSUM
    IS 'The MD5_CHECKSUM field contains a MD5 hash value for the content of the DATA column. It always consists of 32 hexadecimal digits.'
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.VALID_FROM
    IS 'Point of time, from when this OBJECT_DATA row is valid. When inserting the row into the DB, this field is usually set to the current timestamp.'
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.VALID_TO
    IS 'Point of time, until this OBJECT_DATA row is valid. When inserting the row into the DB, this field is usually set to ''9999-12-31'' to indicate that it is valid infinitely. When updating an object to make it invalid, the VALID_TO field has to be set to a definite point in time.  TODO: Check if we can use the Postgres "infinity" value instead of this and how the timezone is affected for both solutions.'
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.CREATION_TIMESTAMP
    IS 'Point in time (date and time), when the row was inserted into the database.'
;

COMMENT ON COLUMN OA_CONTENT.TEXT_DATA.MODIFICATION_TIMESTAMP
    IS 'Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row.'
;



COMMENT ON TABLE OA_CONTENT.MEDIA_REF_DATA
    IS 'This table is used to store the reference data for media objects (like images, videos or PDF files). The actual picture is not stored inside this table, but a reference to the media file. With the stored reference data the actual media file can be retrieved from the reference system (e.g. MediaHub).  For one OBJECT_PAYLOAD row there can be many rows in the MEDIA_REF_DATA table, one for each language/locale. Some images may be valid for all languages. Then the LANGUAGE and LOCALE columns will contain two hyphens ("--") and only one MEDIA_REF_DATA row exists.  This table should only store references for content images, not icons, etc.  For rows in this table, the MIME_TYPE column in the OBJECT_PAYLOAD table only contains the media type (= first part of the MIME type before the "/"), which could be "image" of "video".'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.MEDIA_REF_DATA_ID
    IS 'Internal Id of the MEDIA_REF_DATA table. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.OBJECT_PAYLOAD_ID
    IS 'Reference to associated row in the OBJECT_PAYLOAD table.'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.DATA_ID_FROM_SOURCE
    IS 'Id, which identifies the media object data inside the source system. For media objects from ARKI4, the value can be retrieved from the y.id of the image or video. Example: "ID_017ba1f06e27e274354ae365170fe78e-209cd0c548ab5f5a354ae36548de85f3-de-DE".'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.LANGUAGE
    IS 'Language of the referenced mediafile.  Examples: "de", "en", ...  The attributes LANGUAGE and LOCALE can be concatenated: e.g. "de_DE", "en_GB", ... This field contains two hyphens ("--"), if the image is valid for all languages.'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.LOCALE
    IS 'This field refers to the localization of the LANGUAGE used in different countries.  For data from a ARKI4 Super-XML this field holds the value written in the "variant" field of the Super-XML. This field contains two hyphens ("--"), if the image is valid for all locales.'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.EXT_MEDIA_ID
    IS 'External media identifier. The EXT_MEDIA_ID identifies the media file inside the external reference system, e.g. in the MediaHub.  For images from ARKI4, which have y.io.type = ''mediahub-arkikipicng'', the value for EXT_MEDIA_ID can be found under //img/xxxparam with the following XPath expression:  //img/xxxparam[@key=''http://metadata.docufy.de/cms/dynamic/meta/mh-media-ref'']/@value Example value: ''1556''.'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.EXT_MEDIA_URL
    IS 'External media URL. The EXT_MEDIA_URL is used to retrieve the media file from the external reference system, e.g. in the MediaHub.   Example: yhref=https://mh.om-systems-int.cloud.corpintra.net/mm/arki/download/160213-160217-160595.jpg'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.EXT_MEDIA_FILENAME
    IS 'External media filename.'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.REVISION
    IS 'OA internal revision of the media ref data. For rows in the MEDIA_REF_DATA table the revision is copied from the version_from_source column and converted to integer.'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.VERSION_FROM_SOURCE
    IS 'Version of the media object data from the source system.  For objects from ARKI4 the origin of this field is y.io.version. This field is nullable, because some source systems might not have a version for their objects. Caution: the data type of this column is a string. So comparisons or min/max might not work: Ex. 100 < 21. Versions like "1.2.3" might be used in some source systems.'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.VALID_FROM
    IS 'Point of time, from when this MEDIA_REF_DATA row is valid. When inserting the row into the DB, this field is usually set to the current timestamp.'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.VALID_TO
    IS 'Point of time, until this MEDIA_REF_DATA row is valid. When inserting the row into the DB, this field is usually set to ''9999-12-31'' or INFINTY to indicate that it is valid infinitely. When updating an object to make it invalid, the VALID_TO field has to be set to a definite point in time. Remark: In the current implementation of OA Content Service VALID_FROM is never updated.'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.CREATION_TIMESTAMP
    IS 'Point in time (date and time), when the row was inserted into the database.'
;

COMMENT ON COLUMN OA_CONTENT.MEDIA_REF_DATA.MODIFICATION_TIMESTAMP
    IS 'Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row. Remark:  In the current implementation of OA Content Service the MODIFICATION_TIMESTAMP is always NULL, as rows in the table are never updated.'
;



COMMENT ON TABLE OA_CONTENT.XML_DATA
    IS 'This table stores the payload data for objects, where the content is an XML fragment, e.g. for topics, main menu items and sub menu items etc. from ARKI4.  For one row in the OBJECT_PAYLOAD table there can be many rows in the XML_DATA table, one for each combination of version_from_source, md5_checksum, language and locale.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.XML_DATA_ID
    IS 'Internal Id of the XML_DATA table. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.OBJECT_PAYLOAD_ID
    IS 'Reference to the associated row in the OBJECT_PAYLOAD table.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.DATA_ID_FROM_SOURCE
    IS 'Id, which identifies the object data inside the source system. For objects from ARKI4, the value can be retrieved from the y.id.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.LANGUAGE
    IS 'Language of the object data.  Examples: "de", "en", ...  The attributes LANGUAGE and LOCALE can be concatenated: e.g. "de_DE", "en_GB", ...'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.LOCALE
    IS 'This field refers to the localization of the LANGUAGE used in different countries.  For data from a ARKI4 Super-XML this field holds the value written in the "variant" field of the Super-XML.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.DATA
    IS 'This field contains the actual content data as an XML fragment. For data from ARKI4 the basis for these XML fragments comes from the Super-XML. CAUTION: If the XML content contains single quotes ('') (e.g. like in phonemes for keywords under indexterm), each single quote has to be escaped by another single quote ('''').'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.TITLE
    IS 'This optional column contains a title or heading for the XML content, which is stored in the data column of this table.  It can be used (aside from the attached keywords) to search for the content.   For data imported from an ARKI4 Super-XML file this column is populated with the title of a topic, extracted from the "title" or "overview-title" field, if this is present.  Remark: This column corresponds to the last column (E) in the old "keywords_cop.xls" file. It could also serve to display a search result.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.REVISION
    IS 'OA internal revision of the object data. Revision values start with 1, 2, 3, etc. For each combination of (object_payload_id, data_id_from_source, version_from_source, md5_checksum, language, locale) a new revision is created.  Remark:  The revisions are incremented in an order that is determined by the creation_timestamp, i.e. it might happen, that the revision is lower for a higher version_from_source, if the topic with the higher version_from_source was imported first.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.VERSION_FROM_SOURCE
    IS 'Version of the object data from the source system.  For objects from ARKI4 the origin of this field is y.io.version. This field is nullable, because some source systems might not have a version for their objects. Caution: the data type of this column is a string. So comparisons or min/max might not work: Ex. 100 < 21. Versions like "1.2.3" might be used in some source systems.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.MD5_CHECKSUM
    IS 'The MD5_CHECKSUM field contains a MD5 hash value for the content of the DATA column. It always consists of 32 hexadecimal digits.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.SCHEMA_REF
    IS 'Reference to the XML schema (XSD or DTD), which describes the structure of the XML data. It should contain the URL of the XSD- or DTD-file. Example for XML fragments from ARKI4 could be: "http://arki/xxxxml-v10.xsd".'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.VALID_FROM
    IS 'Point of time, from when this XML_DATA row is valid. When inserting the row into the DB, this field is usually set to the current timestamp.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.VALID_TO
    IS 'Point of time, until this XML_DATA row is valid. When inserting the row into the DB, this field is usually set to ''9999-12-31'' or the PostgreSQL value INFINITY, to indicate that it is valid infinitely. When updating an object to make it invalid, the VALID_TO field has to be set to a definite point in time. Remark: In the current implementation of OA Content Service VALID_TO is never updated.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.CREATION_TIMESTAMP
    IS 'Point in time (date and time), when the row was inserted into the database.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA.MODIFICATION_TIMESTAMP
    IS 'Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row. Remark:  In the current implementation of OA Content Service the MODIFICATION_TIMESTAMP is always NULL, as rows in the table are never updated. '
;



COMMENT ON TABLE OA_CONTENT.IMAGE_DATA
    IS 'CURRENTLY NOT USED !!!!  This table stores the payload data for objects, which represent an image. In contrary to the MEDIA_REF_DATA this table should be used to store actual images (as binary data of type BYTEA) and their metadata and not only references. This table will not be used to store images referenced in the ARKI4 Super-XML.  TODO: Maybe additional metadata columns are necessary, depending for what this table will be used.  TODO: Which columns will need additional indexes / unique constraints?'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.IMAGE_DATA_ID
    IS 'Internal Id of the IMAGE_DATA table. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.OBJECT_PAYLOAD_ID
    IS 'Reference to associated row in the OBJECT_PAYLOAD table.'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.DATA_ID_FROM_SOURCE
    IS 'Id, which identifies the image in the source system.'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.LANGUAGE
    IS 'Language of the image.  Examples: "de", "en", ...  The attributes LANGUAGE and LOCALE can be concatenated: e.g. "de_DE", "en_GB", ... This field contains two hyphens ("--"), if the image is valid for all languages.'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.LOCALE
    IS 'This field refers to the localization of the LANGUAGE used in different countries.  For data from a ARKI4 Super-XML this field holds the value written in the "variant" field of the Super-XML. This field contains two hyphens ("--"), if the image is valid for all locales. '
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.DATA
    IS 'Binary data of the actual image.'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.REVISION
    IS 'OA internal revision or version of the object data. Revisions of the same object may differ for different languages. The revision values start with 1, 2, 3, ...'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.VERSION_FROM_SOURCE
    IS 'Version of the object data from the source system.  This field is nullable, because some source systems might not have a version for their objects. Caution: the data type of this column is a string. So comparisons or min/max might not work: Ex. 100 < 21. Versions like "1.2.3" might be used in some source systems.'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.IMG_HEIGHT
    IS 'Height of the image in pixels.'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.IMG_WIDTH
    IS 'Width of the image in pixels.'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.MD5_CHECKSUM
    IS 'The MD5_CHECKSUM field contains a MD5 hash value for the content of the DATA column. It always consists of 32 hexadecimal digits.'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.LAYOUT_INFO
    IS 'Optional field for a layout information of the picture. Example value: "auto"  TODO: Is this column necessary? '
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.VALID_FROM
    IS 'Point of time, from when this IMAGE_DATA row is valid. When inserting the row into the DB, this field is usually set to the current timestamp.'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.VALID_TO
    IS 'Point of time, until this IMAGE_DATA row is valid. When inserting the row into the DB, this field is usually set to ''9999-12-31'' to indicate that it is valid infinitely. When updating an object to make it invalid, the VALID_TO field has to be set to a definite point in time.  TODO: Check if we can use the Postgres "infinity" value instead of this and how the timezone is affected for both solutions.'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.CREATION_TIMESTAMP
    IS 'Point in time (date and time), when the row was inserted into the database.'
;

COMMENT ON COLUMN OA_CONTENT.IMAGE_DATA.MODIFICATION_TIMESTAMP
    IS 'Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row.'
;



COMMENT ON TABLE OA_CONTENT.XML_DATA_SEARCH_META
    IS 'Table for the many-to-many relationship between the XML_DATA and SEARCH_META. Via this table search metadata can be attached to topics. One row in SEARCH_META (which stands for an indexterm) can be referenced by more than one topic in the XML_DATA table. Also one topic in XML_DATA can have more than one associated row in SEARCH_META, e.g. for different versions of the search metadata, when the version of the topic has not changed.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA_SEARCH_META.XML_DATA_SEARCH_META_ID
    IS 'Internal Id of the XML_DATA_SEARCH_META table. Used as PK. '
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA_SEARCH_META.XML_DATA_ID
    IS 'FK column. Reference to the associated row in the XML_DATA table.'
;

COMMENT ON COLUMN OA_CONTENT.XML_DATA_SEARCH_META.SEARCH_META_ID
    IS 'FK column. Reference to the associated row in the SEARCH_META table.'
;



COMMENT ON TABLE OA_CONTENT.KEYWORD
    IS 'This table contains keywords, which can be assigned to topics via a row in the SEARCH_META table.  One SEARCH_META row can have many associated keywords.  This table allows duplicates on the KEYWORD_VALUE column. I.e. that the same keyword can appear in this table multiple times, if it is attached to more than one topic.'
;

COMMENT ON COLUMN OA_CONTENT.KEYWORD.KEYWORD_ID
    IS 'Internal Id of the KEYWORD table. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.KEYWORD.SEARCH_META_ID
    IS 'Reference to the row in the SEARCH_META table, to which this keyword belongs.'
;

COMMENT ON COLUMN OA_CONTENT.KEYWORD.KEYWORD_VALUE
    IS 'The keyword itself. For input from an ARKI4 Super-XML file each keyword can be extracted from indexterm/keywords/keyword_entry/keyword. Example: "Diesel tanken".'
;



COMMENT ON TABLE OA_CONTENT.CONTENT_REQUEST
    IS 'This table is used by the OA Content Service to protocol content queries (Tag = "OAQuery") and bulk inserts (Tag = "OABulk").   One row in this table stands either for an "OAQuery" request or an "OABulk" request. It holds the unique Id of the request, the request itself (formatted as JSON), the response and a path to the result (formatted as JSON).  This protocol table makes it possible to reproduce the requests.  For OAQuery the steps are:    1. A row is inserted into the CONTENT_REQUEST table. The request is inserted into REQUEST column, STATUS = 1 (IN_PROGRESS). RESULT, RESULT_TIMESTAMP are empty (NULL), RESPONSE and RESPONSE_TIMESTAMP are also empty (NULL).   2. Asynchronous processing is started, HTTP response is performed and RESPONSE and RESPONSE_TIMESTAMP columns are populated => STATUS is still 1 (IN_PROGRESS).     3. Asynchronous processing is finished, RESULT and RESULT_TIMESTAMP columns are populated. STATUS = 2 (COMPLETED) if successful, 3 (FAILED) if processing failed.   For OA Bulk (POST /bulk) the steps are the same, except for the RESULT  column, which stays empty (NULL), when the request was successful.'
;

COMMENT ON COLUMN OA_CONTENT.CONTENT_REQUEST.CONTENT_REQUEST_ID
    IS 'Unique Id of the content request. PK of the table.'
;

COMMENT ON COLUMN OA_CONTENT.CONTENT_REQUEST.REQUEST_TYPE
    IS 'Type of the content request. Possible values: "B" for a "OABulk" import request, "Q" for a "OAQuery" content request   '
;

COMMENT ON COLUMN OA_CONTENT.CONTENT_REQUEST.REQUEST
    IS 'Request, formatted as JSON.'
;

COMMENT ON COLUMN OA_CONTENT.CONTENT_REQUEST.REQUEST_TIMESTAMP
    IS 'Timestamp, when the request was sent to the DB and when the row in this table was created.'
;

COMMENT ON COLUMN OA_CONTENT.CONTENT_REQUEST.RESPONSE
    IS 'Response message (Body of the http response). The column is set to NULL first and populated as soon as it is available.'
;

COMMENT ON COLUMN OA_CONTENT.CONTENT_REQUEST.RESPONSE_TIMESTAMP
    IS 'Timestamp, when the response was available and updated to this row of the table. Initially on inserting this column is set to NULL.'
;

COMMENT ON COLUMN OA_CONTENT.CONTENT_REQUEST.RESULT
    IS 'For OAQuery:  Path to the file that holds the result of the select statement for the query. The result in the file is formatted as JSON. On inserting the row the value of this column is set to NULL. It is updated with the path to the result, when the result is available.  The file is stored on the COS (= Cloud Object Store of the IBM Cloud). The path for the result file can be configured in the configmap. The filename is always ''result_<id>'', where <id> is the CONTENT_REQUEST_ID.  Example: ''cos//eu-de/ba-oacore-test-results/result_123.json''  For OABulk the result column is not populated.'
;

COMMENT ON COLUMN OA_CONTENT.CONTENT_REQUEST.RESULT_TIMESTAMP
    IS 'Timestamp, when the result was available and updated to this row of the table. Initially on inserting this column is set to NULL. (This column is also populated for OABulk, when the processing of the request is finished, although the result column stays empty.)'
;

COMMENT ON COLUMN OA_CONTENT.CONTENT_REQUEST.USER_ID
    IS 'User, who initiated the request. This should be provided from the service context.'
;

COMMENT ON COLUMN OA_CONTENT.CONTENT_REQUEST.STATUS
    IS 'Status of the content request. Possible values:  0 = NEW: initial default value (currently not used),  1 = IN_PROGRESS: request is in progress, REQUEST has been inserted into the table, RESPONSE is added when available, RESULT is not yet available,  2 = COMPLETED: request asynchronous processing has completed successfully. Result is available in RESULT column, 3 = FAILED:  Request asynchronous processing has failed. RESULT column is populated with an error message.'
;

COMMENT ON COLUMN OA_CONTENT.CONTENT_REQUEST.LOGFILE_PATH
    IS 'Path and filename of the logfile that is associated to this content request. The logfile is located in a bucket on the Cloud Object Store (COS) of the IBM Cloud.  Example: ''cos://eu-de/ba-oacore-test-logfiles/protocol_418.json'' The logfile path can be configured in the configmap. The filename is always ''protocol_<id>'', where <id> is the CONTENT_REQUEST_ID.'
;



COMMENT ON TABLE OA_CONTENT.PHONEME
    IS 'Table to store the phonemes, which are associated to keywords in the KEYWORD table. One keyword can have more than one phoneme.  Remark: This table is currently not used!'
;

COMMENT ON COLUMN OA_CONTENT.PHONEME.PHONEME_ID
    IS 'Internal Id of the PHONEME table. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.PHONEME.KEYWORD_ID
    IS 'Id of the row in the KEYWORD table, to which the phoneme belongs.'
;

COMMENT ON COLUMN OA_CONTENT.PHONEME.PHONEME_VALUE
    IS 'A phoneme string, which is associated to a keyword is a written description of how the keyword sounds. It is used to search for certain keywords by speech. For ARKI4 as input system this value is derived from the "main-phonem" or "alt-phonem" field, i.e. from "indexterm/keywords/keyword-entry/phonetics/main-phonem" or "indexterm/keywords/keyword-entry/phonetics/alt-phonems/alt-phonem".  Example:  A phoneme for the keyword "Diesel tanken" is "''di:.z$l_''tanK.k$n".  CAUTION !!!:  As the phoneme string might contain single quotes, these have to be escaped during INSERT. (In SQL this is done by doubling the quotes, which are part of the string.)'
;

COMMENT ON COLUMN OA_CONTENT.PHONEME.PHONEME_TYPE
    IS 'Type of the phoneme. Possible values: "M" = main phoneme,  "A"  = alternative phoneme.  If the phoneme is extracted from the "main-phonem" field in the Super-XML file, this column is set to "M",  if it is derived from an "alt-phonem" field it should be set to "A".'
;



COMMENT ON TABLE OA_CONTENT.SEARCH_META
    IS 'The SEARCH_META table is used to store search metadata.  The table serves as a kind of bracket for the keywords in the KEYWORD table, which can be used to find the associated topic. One topic in table XML_DATA can have 0 to n associated rows in SEARCH_META. But only one row in SEARCH_META with a specific version_from_source should be valid at a certain point in time.  For topics from ARKI4 the data to populate this table come from the "indexterm.ref/indexterm" XML fragment inside a topic.'
;

COMMENT ON COLUMN OA_CONTENT.SEARCH_META.SEARCH_META_ID
    IS 'Internal Id of the SEARCH_META table. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.SEARCH_META.SEARCH_META_ID_FROM_SOURCE
    IS 'Id, which identifies the SEARCH_META row inside the source system. For objects from ARKI4, the value can be retrieved from the field indexterm/y.id.'
;

COMMENT ON COLUMN OA_CONTENT.SEARCH_META.LANGUAGE
    IS 'Language of the search_meta data.  For data from ARKI4 this value is retrieved from indexterm/y.io.language. Examples: "de", "en", ...'
;

COMMENT ON COLUMN OA_CONTENT.SEARCH_META.LOCALE
    IS 'This field refers to the localization of the LANGUAGE used in different countries.  For data from ARKI4 this value is retrieved from indexterm/y.io.variant. Examples: "DE", "GB".'
;

COMMENT ON COLUMN OA_CONTENT.SEARCH_META.REVISION
    IS 'OA internal revision or version of the search_meta data. Revision values start with 1, 2, 3, etc. For each combination of (search_meta_id_from_source, version_from_source, md5_checksum, language, locale) a new revision is created.  Remark:  The revisions are incremented in an order that is determined by the creation_timestamp, i.e. it might happen, that the revision is lower for a higher version_from_source, if the indexterm with the higher version_from_source was imported first.'
;

COMMENT ON COLUMN OA_CONTENT.SEARCH_META.VERSION_FROM_SOURCE
    IS 'Version of the search_meta data from the source system.  For search_meta rows from ARKI4 the origin of this field is indexterm/y.io.version. This field is nullable, because some source systems might not have a version for their objects. Caution: the data type of this column is a string. So comparisons or min/max might not work: Ex. 100 < 21. Versions like "1.2.3" might be used in some source systems.'
;

COMMENT ON COLUMN OA_CONTENT.SEARCH_META.MD5_CHECKSUM
    IS 'MD5 hash value, which is calculated from the concatenated keywords under this indexterm. The keywords are at first sorted in alphabetical order and then concatenated.  Example: If you find the following two keywords under this indexterm ( ''petrol'' and ''fuel''), first these strings are ordered and concatenated (''fuelpetrol'') and then the MD5 hash is calculated from the concatenated string: ''ea85308178a3afab63012fefbcb70f5e''.'
;

COMMENT ON COLUMN OA_CONTENT.SEARCH_META.VALID_FROM
    IS 'Point of time, from when this SEARCH_META row is valid. When inserting the row into the DB, this field is usually set to the current timestamp.'
;

COMMENT ON COLUMN OA_CONTENT.SEARCH_META.VALID_TO
    IS 'Point of time, until this SEARCH_META row is valid. When inserting the row into the DB, this field is usually set to ''9999-12-31'' or INFINITY to indicate that it is valid infinitely. When updating an object to make it invalid, the VALID_TO field has to be set to a definite point in time. Remark: In the current implementation VALID_TO is never updated.'
;

COMMENT ON COLUMN OA_CONTENT.SEARCH_META.CREATION_TIMESTAMP
    IS 'Point in time (date and time), when the row was inserted into the database.'
;

COMMENT ON COLUMN OA_CONTENT.SEARCH_META.MODIFICATION_TIMESTAMP
    IS 'Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row. Remark:  In the current implementation of OA Content Service the MODIFICATION_TIMESTAMP is always NULL, as rows in the table are never updated. '
;



COMMENT ON TABLE OA_CONTENT.VALIDITY
    IS 'The VALIDITY table can store validities, which can be assigned to a content object. Validities can be of different types, which are defined in the VALIDITY_TYPE reference table. E.g. a validity for a topic object can be the vehicle equipment code (also known as FIO), for which this topic is valid. Objects can have 0 to many rows in the VALIDITY table.'
;

COMMENT ON COLUMN OA_CONTENT.VALIDITY.VALIDITY_ID
    IS 'Internal Id of the VALIDITY table. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.VALIDITY.OBJECT_ID
    IS 'Reference to the associated object in the OBJECT table.'
;

COMMENT ON COLUMN OA_CONTENT.VALIDITY.VALIDITY_TYPE_ID
    IS 'Id of the validity type. This column is a reference to the VALIDITY_TYPE table, where the possible validity types are defined.'
;

COMMENT ON COLUMN OA_CONTENT.VALIDITY.VALIDITY_CODE
    IS 'Value of the validity code. Example values for validities of type "equipment_code" (FIO):  - "ZX_581" (for automatic air conditioning) - "ZX_Diesel_L" (for all kinds of Diesel motors).'
;



COMMENT ON TABLE OA_CONTENT.VALIDITY_TYPE
    IS 'Reference table for the possible validity types.'
;

COMMENT ON COLUMN OA_CONTENT.VALIDITY_TYPE.VALIDITY_TYPE_ID
    IS 'Internal Id of the validity type. Used as PK.'
;

COMMENT ON COLUMN OA_CONTENT.VALIDITY_TYPE.VALIDITY_TYPE_NAME
    IS 'Name of the validity_type. Example value: "equipment_code", which defines a certain technical feature of a vehicle, like a certain motor, air conditioning, etc.'
;

COMMENT ON COLUMN OA_CONTENT.VALIDITY_TYPE.DESCRIPTION
    IS 'Optional description field, which can be used to describe the meaning of the validity type.'
;




-- Create V_OBJ_REL_OBJ: (Joins OBJECT, RELATION, OBJECT and OBJECT_TYPE, SOURCE_SYSTEM for each OBJECT)
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW oa_content.v_obj_rel_obj AS
 SELECT r.relation_id,
    r.object_id_1,
    ot1.object_type_name AS object_type_name_1,
    o1.object_type_from_source AS object_type_from_source_1,
    s1.source_system_name AS source_system_name_1,
    o1.object_id_from_source AS object_id_from_source_1,
    rt.relation_type_name,
    r.object_id_2,
    ot2.object_type_name AS object_type_name_2,
    o2.object_type_from_source AS object_type_from_source_2,
    s2.source_system_name AS source_system_name_2,
    o2.object_id_from_source AS object_id_from_source_2,
    r.object_id_context,
    ot3.object_type_name AS object_type_name_context,
    o3.object_type_from_source AS object_type_from_source_context,
    s3.source_system_name AS source_system_name_context,
    o3.object_id_from_source AS object_id_from_source_context
   FROM oa_content.object             o1
   JOIN oa_content.relation           r   ON (o1.object_id         = r.object_id_1)
   JOIN oa_content.object             o2  ON (o2.object_id         = r.object_id_2)
   JOIN oa_content.relation_type      rt  ON (r.relation_type_id   = rt.relation_type_id)

   JOIN oa_content.object_type        ot1 ON (o1.object_type_id    = ot1.object_type_id)
   JOIN oa_content.source_system      s1  ON (o1.source_system_id  = s1.source_system_id)
   JOIN oa_content.object_type        ot2 ON (o2.object_type_id    = ot2.object_type_id)
   JOIN oa_content.source_system      s2  ON (o2.source_system_id  = s2.source_system_id)

   LEFT JOIN oa_content.object        o3  ON (o3.object_id         = r.object_id_context)
   LEFT JOIN oa_content.object_type   ot3 ON (o3.object_type_id    = ot3.object_type_id)
   LEFT JOIN oa_content.source_system s3  ON (o3.source_system_id  = s3.source_system_id)
;

-- Create V_XML_OBJECT_ALL
--
-- View for all objects with data in table XML_DATA
--       (joins OBJECT, OBJECT_PAYLOAD, XML_DATA, XML_DATA_SEARCH_META, SEARCH_META, OBJECT_TYPE, SOURCE_SYSTEM):
-----------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW oa_content.v_xml_object_all AS
 SELECT o.object_id,
    ot.object_type_name,
    s.source_system_name,
    o.object_id_from_source,
    o.object_type_from_source,
    o.object_name_from_source,
    op.object_payload_id,
    op.mime_type,
    x.xml_data_id,
    x.data_id_from_source,
    x.language,
    x.locale,
    x.data,
    x.title,
    x.revision,
    x.version_from_source,
    x.md5_checksum,
    x.schema_ref,
    x.valid_from,
    x.valid_to,
    x.creation_timestamp,
    x.modification_timestamp,
    sm.search_meta_id,
    sm.search_meta_id_from_source,
    sm.language AS sm_language,
    sm.locale AS sm_locale,
    sm.revision AS sm_revision,
    sm.version_from_source AS sm_version_from_source,
    sm.md5_checksum AS sm_md5_checksum,
    sm.valid_from AS sm_valid_from,
    sm.valid_to AS sm_valid_to,
    sm.creation_timestamp AS sm_creation_timestamp,
    sm.modification_timestamp AS sm_modification_timestamp

   FROM   oa_content.object         o
     JOIN oa_content.object_type    ot  ON o.object_type_id     = ot.object_type_id
     JOIN oa_content.source_system  s   ON o.source_system_id   = s.source_system_id
     JOIN oa_content.object_payload op  ON o.object_id          = op.object_id
     JOIN oa_content.xml_data       x   ON op.object_payload_id = x.object_payload_id
     LEFT OUTER JOIN oa_content.xml_data_search_meta    xs  ON x.xml_data_id      = xs.xml_data_id
     LEFT OUTER JOIN oa_content.search_meta             sm  ON xs.search_meta_id  = sm.search_meta_id
;

-- Create V_XML_OBJECT_ALL_MAX_REV
--
-- View for all objects with data in table XML_DATA
--       (joins OBJECT, OBJECT_PAYLOAD, XML_DATA, XML_DATA_SEARCH_META, SEARCH_META, OBJECT_TYPE, SOURCE_SYSTEM)
-- In contrast to view V_XML_OBJECT_ALL this view only selects the latest revision
-- of each topic in table XML_DATA and the latest revision of the SEARCH_META for that latest revision of the topic.
-------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW oa_content.v_xml_object_all_max_rev AS
 SELECT o.object_id,
    ot.object_type_name,
    s.source_system_name,
    o.object_id_from_source,
    o.object_type_from_source,
    o.object_name_from_source,
    op.object_payload_id,
    op.mime_type,
    x.xml_data_id,
    x.data_id_from_source,
    x.language,
    x.locale,
    x.data,
    x.title,
    x.revision,
    x.version_from_source,
    x.md5_checksum,
    x.schema_ref,
    x.valid_from,
    x.valid_to,
    x.creation_timestamp,
    x.modification_timestamp,
    sm.search_meta_id,
    sm.search_meta_id_from_source,
    sm.language AS sm_language,
    sm.locale AS sm_locale,
    sm.revision AS sm_revision,
    sm.version_from_source AS sm_version_from_source,
    sm.md5_checksum AS sm_md5_checksum,
    sm.valid_from AS sm_valid_from,
    sm.valid_to AS sm_valid_to,
    sm.creation_timestamp AS sm_creation_timestamp,
    sm.modification_timestamp AS sm_modification_timestamp

   FROM   oa_content.object         o
     JOIN oa_content.object_type    ot  ON o.object_type_id     = ot.object_type_id
     JOIN oa_content.source_system  s   ON o.source_system_id   = s.source_system_id
     JOIN oa_content.object_payload op  ON o.object_id          = op.object_id
     JOIN oa_content.xml_data       x   ON op.object_payload_id = x.object_payload_id
     LEFT OUTER JOIN oa_content.xml_data_search_meta    xs  ON x.xml_data_id      = xs.xml_data_id
     LEFT OUTER JOIN oa_content.search_meta             sm  ON xs.search_meta_id  = sm.search_meta_id
   WHERE x.revision =
      (SELECT max(revision) FROM oa_content.xml_data x2
         WHERE x.data_id_from_source = x2.data_id_from_source
         AND   x.object_payload_id   = x2.object_payload_id
         AND   x.language            = x2.language
         AND   x.locale              = x2.locale
      )
    AND ( sm.revision =
            ( SELECT max(sm2.revision) AS max_s FROM oa_content.search_meta sm2
                    WHERE sm.search_meta_id_from_source = sm2.search_meta_id_from_source
                    AND   sm.language                   = sm2.language
                    AND   sm.locale                     = sm2.locale
            )
           OR sm.revision IS NULL   -- Case, that there is no SEARCH_META for a topic
        )
;


-- Create V_MEDIA_REF_OBJECT_ALL,
-- View for all objects with data in table MEDIA_REF_DATA
--     (joins OBJECT, OBJECT_PAYLOAD, MEDIA_REF_DATA_DATA, OBJECT_TYPE, SOURCE_SYSTEM):
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW oa_content.v_media_ref_object_all AS
 SELECT o.object_id,
    ot.object_type_name,
    s.source_system_name,
    o.object_id_from_source,
    o.object_type_from_source,
    o.object_name_from_source,
    op.object_payload_id,
    op.mime_type,
    m.media_ref_data_id,
    m.data_id_from_source,
    m.language,
    m.locale,
    m.ext_media_id,
    m.ext_media_url,
    m.ext_media_filename,
    m.revision,
    m.version_from_source,
    m.valid_from,
    m.valid_to,
    m.creation_timestamp,
    m.modification_timestamp

   FROM   oa_content.object          o
     JOIN oa_content.object_type     ot  ON o.object_type_id      = ot.object_type_id
     JOIN oa_content.source_system   s   ON o.source_system_id    = s.source_system_id
     JOIN oa_content.object_payload  op  ON o.object_id           = op.object_id
     JOIN oa_content.media_ref_data  m   ON op.object_payload_id  = m.object_payload_id
;

-- Create V_MEDIA_REF_OBJECT_ALL_MAX_REV
--
-- View for all objects with data in table MEDIA_REF_DATA
--       (joins OBJECT, OBJECT_PAYLOAD, MEDIA_REF_DATA, OBJECT_TYPE, SOURCE_SYSTEM)
-- In contrast to view V_MEDIA_REF_OBJECT_ALL this view only selects the latest revision
-- of each media reference in table MEDIA_REF_DATA.
--------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW oa_content.v_media_ref_object_all_max_rev AS
 SELECT o.object_id,
    ot.object_type_name,
    s.source_system_name,
    o.object_id_from_source,
    o.object_type_from_source,
    o.object_name_from_source,
    op.object_payload_id,
    op.mime_type,
    m.media_ref_data_id,
    m.data_id_from_source,
    m.language,
    m.locale,
    m.ext_media_id,
    m.ext_media_url,
    m.ext_media_filename,
    m.revision,
    m.version_from_source,
    m.valid_from,
    m.valid_to,
    m.creation_timestamp,
    m.modification_timestamp

   FROM   oa_content.object          o
     JOIN oa_content.object_type     ot  ON o.object_type_id      = ot.object_type_id
     JOIN oa_content.source_system   s   ON o.source_system_id    = s.source_system_id
     JOIN oa_content.object_payload  op  ON o.object_id           = op.object_id
     JOIN oa_content.media_ref_data  m   ON op.object_payload_id  = m.object_payload_id
   WHERE m.revision =
      (SELECT max(revision) FROM oa_content.media_ref_data m2
         WHERE m.data_id_from_source = m2.data_id_from_source
         AND   m.object_payload_id   = m2.object_payload_id
         AND   m.language            = m2.language
         AND   m.locale              = m2.locale
      )
;

-- Create V_OBJECT_ALL_MAX_REV
--
-- View that combines the SELECT statements from V_XML_OBJECT_ALL_MAX_REV and V_MEDIA_REF_OBJECT_ALL_MAX_REV
-- by combining the results of the individual SELECT statements via UNION ALL.
--
-- Data are selected from OBJECT, OBJECT_PAYLOAD, XML_DATA, MEDIA_REF_DATA, OBJECT_TYPE, SOURCE_SYSTEM,
-- XML_DATA_SEARCH_META, SEARCH_META (if available).
-- Missing columns in each SELECT are substituted by a NULL value.
-- A row_number column is added as an artificial first column, as it is needed by the appliction frameword as a unique Id.
-- An artificial new second column is added, which lets you know, from which data table the results origin.
--
-- This view selects the latest revision of all xml_data and media_ref_data objects.
--------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW oa_content.v_object_all_max_rev AS
SELECT row_number() OVER (ORDER BY sub_query.data_table_name desc, sub_query.object_id, sub_query.xml_data_id, sub_query.search_meta_id, sub_query.media_ref_data_id) AS row_number,
       * FROM
(
SELECT
    'xml_data' AS data_table_name,
    o.object_id,
    ot.object_type_name,
    s.source_system_name,
    o.object_id_from_source,
    o.object_type_from_source,
    o.object_name_from_source,
    op.object_payload_id,
    op.mime_type,
    x.xml_data_id,
    NULL AS media_ref_data_id,
    x.data_id_from_source,
    x.language,
    x.locale,
    x.data,
    x.title,
    NULL AS ext_media_id,
    NULL AS ext_media_url,
    NULL as ext_media_filename,
    x.revision,
    x.version_from_source,
    x.md5_checksum,
    x.schema_ref,
    x.valid_from,
    x.valid_to,
    x.creation_timestamp,
    x.modification_timestamp,
    sm.search_meta_id,
    sm.search_meta_id_from_source,
    sm.language AS sm_language,
    sm.locale AS sm_locale,
    sm.revision AS sm_revision,
    sm.version_from_source AS sm_version_from_source,
    sm.md5_checksum AS sm_md5_checksum,
    sm.valid_from AS sm_valid_from,
    sm.valid_to AS sm_valid_to,
    sm.creation_timestamp AS sm_creation_timestamp,
    sm.modification_timestamp AS sm_modification_timestamp

   FROM   oa_content.object         o
     JOIN oa_content.object_type    ot  ON o.object_type_id     = ot.object_type_id
     JOIN oa_content.source_system  s   ON o.source_system_id   = s.source_system_id
     JOIN oa_content.object_payload op  ON o.object_id          = op.object_id
     JOIN oa_content.xml_data       x   ON op.object_payload_id = x.object_payload_id
     LEFT OUTER JOIN oa_content.xml_data_search_meta    xs  ON x.xml_data_id      = xs.xml_data_id
     LEFT OUTER JOIN oa_content.search_meta             sm  ON xs.search_meta_id  = sm.search_meta_id
   WHERE x.revision = -- maximum revision for the same data_id_from_source under the same object_payload (= under the same object)
      (SELECT max(revision) FROM oa_content.xml_data x2
         WHERE x.data_id_from_source = x2.data_id_from_source
         AND   x.object_payload_id   = x2.object_payload_id
         AND   x.language            = x2.language
         AND   x.locale              = x2.locale
      )
   AND  (sm.revision = ( SELECT max(sm2.revision) AS max_s FROM oa_content.search_meta sm2
                         WHERE sm.search_meta_id_from_source = sm2.search_meta_id_from_source
                         AND   sm.language                   = sm2.language
                         AND   sm.locale                     = sm2.locale
                       )
         OR sm.revision IS NULL   -- Case, that there is no SEARCH_META for a topic
        )
UNION ALL

SELECT
    'media_ref_data' AS data_table_name,
    o.object_id,
    ot.object_type_name,
    s.source_system_name,
    o.object_id_from_source,
    o.object_type_from_source,
    o.object_name_from_source,
    op.object_payload_id,
    op.mime_type,
    NULL AS xml_data_id,
    m.media_ref_data_id,
    m.data_id_from_source,
    m.language,
    m.locale,
    NULL AS data,
    NULL AS title,
    m.ext_media_id,
    m.ext_media_url,
    m.ext_media_filename,
    m.revision,
    m.version_from_source,
    NULL AS md5_checksum,
    NULL AS schema_ref,
    m.valid_from,
    m.valid_to,
    m.creation_timestamp,
    m.modification_timestamp,
    NULL AS search_meta_id,
    NULL AS search_meta_id_from_source,
    NULL AS sm_language,
    NULL AS sm_locale,
    NULL AS sm_revision,
    NULL AS sm_version_from_source,
    NULL AS sm_md5_checksum,
    NULL AS sm_valid_from,
    NULL AS sm_valid_to,
    NULL AS sm_creation_timestamp,
    NULL AS sm_modification_timestamp

   FROM   oa_content.object          o
     JOIN oa_content.object_type     ot  ON o.object_type_id      = ot.object_type_id
     JOIN oa_content.source_system   s   ON o.source_system_id    = s.source_system_id
     JOIN oa_content.object_payload  op  ON o.object_id           = op.object_id
     JOIN oa_content.media_ref_data  m   ON op.object_payload_id  = m.object_payload_id
   WHERE m.revision = -- maximum revision for the same data_id_from_source under the same object_payload (= under the same object)
      (SELECT max(revision) FROM oa_content.media_ref_data m2
         WHERE m.data_id_from_source = m2.data_id_from_source
         AND   m.object_payload_id   = m2.object_payload_id
         AND   m.language            = m2.language
         AND   m.locale              = m2.locale
      )
) AS sub_query
;


-- Create V_OBJECT_ALL
--
-- View that combines the SELECT statements from V_XML_OBJECT_ALL and V_MEDIA_REF_OBJECT_ALL
-- by combining the results of the individual SELECT statements via UNION ALL.
--
-- Data are selected from OBJECT, OBJECT_PAYLOAD, XML_DATA, MEDIA_REF_DATA, OBJECT_TYPE, SOURCE_SYSTEM,
-- XML_DATA_SEARCH_META, SEARCH_META (if available).
-- Missing columns in each SELECT are substituted by a NULL value.
-- A row_number column is added as an artificial first column, as it is needed by the appliction frameword as a unique Id.
-- An artificial new second column is added, which lets you know, from which data table the results origin.
--
-- This view selects all revisions of all xml_data and media_ref_data objects.
--------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW oa_content.v_object_all AS
SELECT row_number() OVER (ORDER BY sub_query.data_table_name desc, sub_query.object_id, sub_query.xml_data_id, sub_query.search_meta_id, sub_query.media_ref_data_id) AS row_number,
       * FROM
(
SELECT
    'xml_data' AS data_table_name,
    o.object_id,
    ot.object_type_name,
    s.source_system_name,
    o.object_id_from_source,
    o.object_type_from_source,
    o.object_name_from_source,
    op.object_payload_id,
    op.mime_type,
    x.xml_data_id,
    NULL AS media_ref_data_id,
    x.data_id_from_source,
    x.language,
    x.locale,
    x.data,
    x.title,
    NULL AS ext_media_id,
    NULL AS ext_media_url,
    NULL AS ext_media_filename,
    x.revision,
    x.version_from_source,
    x.md5_checksum,
    x.schema_ref,
    x.valid_from,
    x.valid_to,
    x.creation_timestamp,
    x.modification_timestamp,
    sm.search_meta_id,
    sm.search_meta_id_from_source,
    sm.language AS sm_language,
    sm.locale AS sm_locale,
    sm.revision AS sm_revision,
    sm.version_from_source AS sm_version_from_source,
    sm.md5_checksum AS sm_md5_checksum,
    sm.valid_from AS sm_valid_from,
    sm.valid_to AS sm_valid_to,
    sm.creation_timestamp AS sm_creation_timestamp,
    sm.modification_timestamp AS sm_modification_timestamp

   FROM   oa_content.object         o
     JOIN oa_content.object_type    ot  ON o.object_type_id     = ot.object_type_id
     JOIN oa_content.source_system  s   ON o.source_system_id   = s.source_system_id
     JOIN oa_content.object_payload op  ON o.object_id          = op.object_id
     JOIN oa_content.xml_data       x   ON op.object_payload_id = x.object_payload_id
     LEFT OUTER JOIN oa_content.xml_data_search_meta    xs  ON x.xml_data_id      = xs.xml_data_id
     LEFT OUTER JOIN oa_content.search_meta             sm  ON xs.search_meta_id  = sm.search_meta_id

UNION ALL

SELECT
    'media_ref_data'AS data_table_nmae,
    o.object_id,
    ot.object_type_name,
    s.source_system_name,
    o.object_id_from_source,
    o.object_type_from_source,
    o.object_name_from_source,
    op.object_payload_id,
    op.mime_type,
    NULL AS xml_data_id,
    m.media_ref_data_id,
    m.data_id_from_source,
    m.language,
    m.locale,
    NULL AS data,
    NULL AS title,
    m.ext_media_id,
    m.ext_media_url,
    m.ext_media_filename,
    m.revision,
    m.version_from_source,
    NULL AS md5_checksum,
    NULL AS schema_ref,
    m.valid_from,
    m.valid_to,
    m.creation_timestamp,
    m.modification_timestamp,
    NULL AS search_meta_id,
    NULL AS search_meta_id_from_source,
    NULL AS sm_language,
    NULL AS sm_locale,
    NULL AS sm_revision,
    NULL AS sm_version_from_source,
    NULL AS sm_md5_checksum,
    NULL AS sm_valid_from,
    NULL AS sm_valid_to,
    NULL AS sm_creation_timestamp,
    NULL AS sm_modification_timestamp

   FROM   oa_content.object          o
     JOIN oa_content.object_type     ot  ON o.object_type_id      = ot.object_type_id
     JOIN oa_content.source_system   s   ON o.source_system_id    = s.source_system_id
     JOIN oa_content.object_payload  op  ON o.object_id           = op.object_id
     JOIN oa_content.media_ref_data  m   ON op.object_payload_id  = m.object_payload_id
) AS sub_query
;


-- Create V_XML_DATA_SEARCH_META:
--
-- Example View for selecting search_meta, keywords and phonemes for a topic,
-- (Join of tables XML_DATA, XML_DATA_SEARCH_META, SEARCH_META, KEYWORD, PHONEME)
---------------------------------------------------------------------------------

CREATE OR REPLACE VIEW oa_content.v_xml_data_search_meta AS
 SELECT x.xml_data_id,
    x.object_payload_id,
    x.data_id_from_source,
    x.language,
    x.locale,
    x.title,
    xs.xml_data_search_meta_id,
    s.search_meta_id,
    s.search_meta_id_from_source,
    s.revision,
    s.version_from_source,
    s.md5_checksum,
    k.keyword_id,
    k.keyword_value,
    p.phoneme_id,
    p.phoneme_value,
    p.phoneme_type

 FROM oa_content.xml_data x
 LEFT OUTER JOIN oa_content.xml_data_search_meta xs ON x.xml_data_id = xs.xml_data_id
 LEFT OUTER JOIN oa_content.search_meta s           ON xs.search_meta_id = s.search_meta_id
 LEFT OUTER JOIN oa_content.keyword k               ON s.search_meta_id = k.search_meta_id
 LEFT OUTER JOIN oa_content.phoneme p               ON k.keyword_id = p.keyword_id
;

-- Create V_SEARCH_META_KEYWORDS_MD5:
--
-- Example View for checking, if in table SEARCH_META the column MD5_CHECKSUM, that was populated by the application,
-- matches the MD5 checksum that was calculated by the DB by concatenating the ordered keywors below each row in SEARCH_META:
-----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW oa_content.v_search_meta_keywords_md5 AS
   SELECT sm.search_meta_id, sm.search_meta_id_from_source, sm.language, sm.locale, sm.revision, sm.version_from_source, sm.md5_checksum,
          sub_sel_keywordstring.concatenated_keywords_md5,
          CASE WHEN sm.md5_checksum = sub_sel_keywordstring.concatenated_keywords_md5 THEN 'true' ELSE 'false' END AS md5_matches,
          sub_sel_keywordstring.concatenated_keywords_string,
          sm.creation_timestamp
   FROM oa_content.search_meta sm
   JOIN
      (SELECT
          s.search_meta_id,
          STRING_AGG(COALESCE(k.keyword_value, ''), '' ORDER BY k.keyword_value)         AS concatenated_keywords_string,  -- no delimiter
          MD5(STRING_AGG(COALESCE(k.keyword_value, ''), '' ORDER BY k.keyword_value))    AS concatenated_keywords_md5
       FROM      oa_content.search_meta s
       LEFT JOIN oa_content.keyword     k ON s.search_meta_id = k.search_meta_id -- left outer join for case that  an indexterm/search_meta doesn't have keywords below
       GROUP BY s.search_meta_id
       ORDER BY s.search_meta_id
      ) sub_sel_keywordstring
   ON (sm.search_meta_id = sub_sel_keywordstring.search_meta_id)
   ORDER BY sm.search_meta_id
;

-- Create V_OBJECT_VALIDITY: (Joins OBJECT, VALIDITY and VALIDITY_TYPE for topic objects)
--
-- (uses LEFT OUTER => also objects with no row in VALIDITY are selected)
---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW oa_content.v_object_validity AS
 SELECT
    o.object_id,
    o.object_id_from_source,
    v.validity_id,
    v.validity_type_id,
    v.validity_code,
    vt.validity_type_name
   FROM              oa_content.object         o
     LEFT OUTER JOIN oa_content.validity       v  ON (o.object_id = v.object_id)
     LEFT OUTER JOIN oa_content.validity_type  vt ON (v.validity_type_id = vt.validity_type_id)
   WHERE o.object_type_id =
        (SELECT object_type_id FROM oa_content.object_type WHERE object_type_name = 'topic')
;

-- Create V_OBJECT_N_TUPLE:
--
-- This view displays the N-Tuple-Hash of an object as a string.
-- It also seperates the y.io.id within the object_id_from_source from the N-Tuple-MD5-Hash.
-- The view can also be used to check if the MD5-Hash, that was appended to the object_id_from_source,
-- matches the MD5 hash, that was calculated from the string, which results from the is-valid-for relations.
-------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW oa_content.v_object_n_tuple AS

SELECT  object_id_1,
        ot.object_type_name,
        o1.object_type_from_source,
        o1.object_id_from_source,
        vehicle_line || state_of_construction || market || target_device || info_product AS n_tuple_string,
        split_part(o1.object_id_from_source, '-', 1) AS y_io_id_only,      -- 1. part before '-' is the y.io.id
        split_part(o1.object_id_from_source, '-', 2) AS n_tuple_md5_hash,  -- 2. part after  '-' is the N-Tuple-MD5-Hash
        MD5(vehicle_line || state_of_construction || market || target_device || info_product) AS md5_calculated_from_n_tuple_string,
        CASE WHEN split_part(o1.object_id_from_source, '-', 2) = MD5(vehicle_line || state_of_construction || market || target_device || info_product)
             THEN 'true' ELSE 'false'
        END                                                          AS md5_matches
FROM
(
   SELECT
      t.object_id_1,

      (SELECT v.business_line || v.vehicle_line_lead || v.vehicle_line_variant || v.vehicle_line_market
       FROM oa_content.v_obj_rel_obj r
       JOIN oa_content.vehicle_line  v ON (r.object_id_2 = v.object_id)
       WHERE r.object_id_1 = t.object_id_1
       AND   relation_type_name = 'is-valid-for'
       AND   object_type_name_2 = 'vehline'
      )                                          AS vehicle_line,

      (SELECT soc.state_of_construction
       FROM oa_content.v_obj_rel_obj r
       JOIN oa_content.state_of_construction soc ON (r.object_id_2 = soc.object_id)
       WHERE r.object_id_1 = t.object_id_1
       AND   relation_type_name = 'is-valid-for'
       AND   object_type_name_2 = 'soc'
      )                                          AS state_of_construction,

      (SELECT m.market
       FROM oa_content.v_obj_rel_obj r
       JOIN oa_content.market  m ON (r.object_id_2 = m.object_id)
       WHERE r.object_id_1 = t.object_id_1
       AND   relation_type_name = 'is-valid-for'
       AND   object_type_name_2 = 'market'
      )                                          AS market,

      (SELECT tdev.device || tdev.model || tdev.model_variant || tdev.device_market
       FROM oa_content.v_obj_rel_obj r
       JOIN oa_content.target_device tdev ON (r.object_id_2 = tdev.object_id)
       WHERE r.object_id_1 = t.object_id_1
       AND   relation_type_name = 'is-valid-for'
       AND   object_type_name_2 = 'tdev'
      )                                          AS target_device,

      (SELECT ip.ip_name
       FROM oa_content.v_obj_rel_obj r
       JOIN oa_content.info_product ip ON (r.object_id_2 = ip.object_id)
       WHERE r.object_id_1 = t.object_id_1
       AND   relation_type_name = 'is-valid-for'
       AND   object_type_name_2 = 'ip'
      )                                          AS info_product

FROM oa_content.v_obj_rel_obj t
GROUP BY t.object_id_1
ORDER BY t.object_id_1
) metadata_validities
JOIN oa_content.object      o1 ON (o1.object_id = metadata_validities.object_id_1)
JOIN oa_content.object_type ot ON (o1.object_type_id = ot.object_type_id)
;

-- This script inserts initial data into the OA-DB.
-- It is used during the installation of a new OA-DB after creating the empty tables.
-- ----------------------------------------------------------------------------------


-- ------------------------------------------------------------------------
-- ------------------------------------------------------------------------
-- OA_CONTENT data domain:
-- ------------------------------------------------------------------------
-- ------------------------------------------------------------------------

------------------------------------
-- 0.00 Entries in SYS_PARAM table:
------------------------------------

-- System parameter for the version of the OA-DB:
INSERT INTO oa_content.sys_param (sys_param_id, par_name, par_value, par_description)
   VALUES (-1, 'OA_DB_VERSION', '1.8.5', 'Version of the OA-DB');

-- System parameters for parts of the OA URI:  (different parts are concatenated with ':' as delimiter)
INSERT INTO oa_content.sys_param (sys_param_id, par_name, par_value, par_description)
   VALUES (-2, 'OA_URI_SCHEME', 'urn', 'First part of URI for OA: scheme');
INSERT INTO oa_content.sys_param (sys_param_id, par_name, par_value, par_description)
   VALUES (-3, 'OA_URI_AUTHORITY', 'com:mercedes-benz:oa', 'Second part of URI for OA: authority');
INSERT INTO oa_content.sys_param (sys_param_id, par_name, par_value, par_description)
   VALUES (-4, 'OA_URI_SYSTEM_IDENTIFIER', 'system', 'Third part of URI for OA: only used for source systems and external systems, not for objects, where third part is the object type.');


-------------------------------------------------------------
-- 0. Entries in Ref Tables, which do not represent objects:
-------------------------------------------------------------

-----------------------------------------------------------
-- 0.1 Object Types (Table OBJECT_TYPE):
-----------------------------------------------------------

-- Object types for objects without a payload: ----------
INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-1, 'ip', 'Information Product');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-2, 'tdev', 'Target Device');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-3, 'vehline', 'Vehicle Line');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-4, 'market', 'Market');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-5, 'pub_release', 'Publication Release (No longer used!)');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-6, 'paid', 'Publication Edition (PA_ID)');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-7, 'soc', 'State of construction');
-- -------------------------------------------------------

-- Object types for objects with a payload: ----------
INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-100, 'main_menu_item', 'Item, which is an entry in the main menu, e.g. of the DiBA. For input from ARKI4 Super-XMLs it corresponds to an item of type "arki-frag-functionlist".');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-101, 'sub_menu_item', 'Item, which is an entry of a sub menu on levels below the main menu, e.g. of the DiBA. For input from ARKI4 Super-XMLs it corresponds to an item of type "arki-frag-title".');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-102, 'topic', 'Topic');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-103, 'media_ref', 'Reference to a media file, e.g. an image, a video or a PDF file, which is stored in an external reference system and not in the OA-DB.');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-104, 'cb_intent', 'Chatbot Intent');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-105, 'cb_answer', 'Chatbot Answer');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-106, 'cb_utterance', 'Chatbot Utterance');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-107, 'cb_entity', 'Chatbot Entity');

INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-108, 'parameter_list', 'Parameter List (Identifiers)');

-- Object types for placeholder:
INSERT INTO oa_content.object_type
	(object_type_id, object_type_name, description)
	VALUES (-1000, 'placeholder', 'Used for placeholder values');




-- -------------------------------------------------------

-----------------------------------------------------------
-- 0.2 Relation Types (Table RELATION_TYPE):
-----------------------------------------------------------

INSERT INTO oa_content.relation_type
	(relation_type_id, relation_type_name, description)
	VALUES (-1, 'is-valid-for', 'Validity Relation between an object with payload and an object without payload. Ex.: A topic object is valid for a certain target device object.');

INSERT INTO oa_content.relation_type
	(relation_type_id, relation_type_name, description)
	VALUES (-2, 'references', 'Relation between two objects with payload. E.g. a topic references another topic or a topic references an image.');

INSERT INTO oa_content.relation_type
	(relation_type_id, relation_type_name, description)
	VALUES (-3, 'is-child-of', 'Relation, which establishes a hierarchy between two objects. E.g. an object of type sub_menu_item is a child of an object of type main_menu_item.');

INSERT INTO oa_content.relation_type
	(relation_type_id, relation_type_name, description)
	VALUES (-4, 'is-assigned-to', '!!! Currently not used !!! Was intended for relationship between topic and indexterm, but indexterm is not modelled as an object now, but as metadata of the payload table XML_DATA.');

INSERT INTO oa_content.relation_type
	(relation_type_id, relation_type_name, description)
	VALUES (-5, 'has-next-sibling',
	'Relation, which establishes an order between two objects, which have the same parent in a hierarchy. Object_A has-next-sibling Object_B means that Object_A appears before Object_B in the order.');

-----------------------------------------------------------
-- 0.3 Source Systems (Table SOURCE_SYSTEM):
-----------------------------------------------------------

INSERT INTO oa_content.source_system
	(source_system_id, source_system_name, description)
	VALUES (-1, 'oa', 'The OA System itself. This should be used for objects, which are defined internally in the OA System, e.g. for objects without payload, like Information Products, Target Devices, etc.');

INSERT INTO oa_content.source_system
	(source_system_id, source_system_name, description)
	VALUES (-2, 'arki4', 'ARKI4 as source system for owners manuals. Input is provided via a Super-XML file based on XML schema http://arki/xxxxml-v10.xsd.');

INSERT INTO oa_content.source_system
	(source_system_id, source_system_name, description)
	VALUES (-3, 'ba-platform', 'BA Platform as source system for normalized values for the masterdata (like vehicle lines, target devices, markets etc.).');


-----------------------------------------------------------
-- 0.4 Validity types (Table VALIDITY_TYPE):
-----------------------------------------------------------
INSERT INTO oa_content.validity_type
	(validity_type_id, validity_type_name, description)
	VALUES (-1, 'equipment_code', 'Vehicle Equipment Code (e.g. a FIO Code, FIO = Faba Information Object). Example: ZX_228');



------------------------------------------------------------------------------
-- Placeholder OBJECT, used as a default value for RELATION.OBJECT_ID_CONTEXT:
------------------------------------------------------------------------------
INSERT INTO oa_content.object
	(object_id, object_type_id, source_system_id, object_id_from_source, object_type_from_source, object_name_from_source)
	VALUES (-1, -1000, -1, 'default for object_id_context', null, null);