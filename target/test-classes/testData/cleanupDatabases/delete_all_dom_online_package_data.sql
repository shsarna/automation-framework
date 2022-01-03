
DROP VIEW IF EXISTS DOM_ONLINE_PACKAGE.v_online_package_validity CASCADE
;


DROP TABLE IF EXISTS DOM_ONLINE_PACKAGE.SYS_PARAM CASCADE
;

DROP TABLE IF EXISTS DOM_ONLINE_PACKAGE.VALIDITY CASCADE
;

DROP TABLE IF EXISTS DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE CASCADE
;

DROP TABLE IF EXISTS DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE CASCADE
;

DROP TABLE IF EXISTS DOM_ONLINE_PACKAGE.DATA_CARD CASCADE
;

DROP TABLE IF EXISTS DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY CASCADE
;

DROP TABLE IF EXISTS DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE CASCADE
;

DROP TABLE IF EXISTS DOM_ONLINE_PACKAGE.INSTRUCTION CASCADE
;

DROP TABLE IF EXISTS DOM_ONLINE_PACKAGE.MEDIA CASCADE
;

DROP TABLE IF EXISTS DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_MEDIA CASCADE
;

DROP TABLE IF EXISTS DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE CASCADE
;



CREATE SCHEMA IF NOT EXISTS dom_online_package;
SET search_path to 'dom_online_package';



CREATE TABLE DOM_ONLINE_PACKAGE.SYS_PARAM
(
	SYS_PARAM_ID bigserial NOT NULL,    -- Internal Id. Primary key of the table.
	PAR_NAME text NOT NULL,    -- Name of the parameter.  This must be unique for all rows in the table.
	PAR_VALUE text NOT NULL,    -- Value of the parameter.
	PAR_DESCRIPTION text NULL    -- Description of the parameter. It should describe the meaning of the specific parameter or for what purpose the parameter is needed.
)
;

CREATE TABLE DOM_ONLINE_PACKAGE.VALIDITY
(
	VALIDITY_ID bigserial NOT NULL,    -- The artificial primary key.
	VALIDITY_TYPE text NOT NULL,    -- The logical validity/meta data types. As of now these would be the possible values:  pa-id business-line vehicle-line vehicle-line-variant vehicle-market state-of-construction market device device-model device-model-variant device-market device-layout information-product
	VALIDITY_VALUE text NOT NULL    -- The specific value for the validity named VALIDITY_TYPE.  Example: 'ECE/ROW' for VALIDITY_TYPE = 'market'
)
;

CREATE TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE
(
	DOM_ONLINE_PACKAGE_ID bigserial NOT NULL,    -- The internal id of the DOM Online Package resource inside the DOM Online Package service.
	ONLINE_PACKAGE_STATUS text NOT NULL,    -- Status of the online package creation.  Possible values are: 'error', 'started' and 'completed'
	LANGUAGE text NOT NULL,    -- Language Examples: "de", "en", ...   The attributes LANGUAGE and LOCALE can be concatenated: e.g. "de_DE", "en_GB", ...
	LOCALE text NOT NULL,    -- This field refers to the localization of the LANGUAGE used in different countries.
	HASH_VALUE text NOT NULL,    -- A hash value over all editorial codes stored in the table DATA_CARD.
	REVISION smallint NOT NULL,    -- Revision of the online package (for the specific hash value).
	LOG text NULL,    -- A column to store the complete logging regarding the process of package creation.  Single log entries are composed as an object in JSON and always appended to the existing log text.
	VALID_FROM timestamp(6) with time zone NOT NULL   DEFAULT '-infinity',    -- Point of time, from when this row is valid. Default: -infinity
	VALID_TO timestamp(6) with time zone NOT NULL   DEFAULT 'infinity',    -- Point of time, until this row is valid.  Default: infinity
	CREATION_TIMESTAMP timestamp(6) with time zone NOT NULL,    -- Point in time (date and time), when the row was inserted into the database.
	MODIFICATION_TIMESTAMP timestamp(6) with time zone NULL    -- Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row.
)
;

CREATE TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE
(
	DOM_ONLINE_PACKAGE_RESOURCE_ID bigserial NOT NULL,    -- An artificial primary key for this table.
	DOM_ONLINE_PACKAGE_ID bigint NOT NULL,    -- Reference to DOM_ONLINE_PACKAGE
	ID_TAG text NOT NULL,    -- An identifying tag/name for the kind of resource that is stored.  As of now the only planned ID_TAG is 	- 'DB'  Note that there is a unique constraint for DOM_ONLINE_PACKAGE_ID and ID_TAG in this table. One ID must only exist once for one online package.
	RESOURCE_ID bigint NULL,    -- The (internal) ID of the resource that is stored.  For now there is just one resource planned, which is the database resource of the DOM Content service:  DOM_DATABASE_RESOURCE.DOM_DATABASE_RESOURCE_ID (Vehicle Backend DB).
	RESOURCE_URL text NOT NULL,    -- This is the full/complete URL to the object/resource in the artifactory.  E.g. 'https://ntg7oa.mercedes-benz.com/artifactory/5471248923493484/README.md'
	MD5_CHECKSUM text NOT NULL    -- This column contains an MD5 hash value for the file that is stored in the given RESOURCE_URL. It always consists of 32 hexadecimal digits.
)
;

CREATE TABLE DOM_ONLINE_PACKAGE.DATA_CARD
(
	DATA_CARD_ID bigserial NOT NULL,    -- The artificial primary key.
	DOM_ONLINE_PACKAGE_ID bigint NOT NULL,    -- Reference to DOM_ONLINE_PACKAGE
	EDITORIAL_CODE text NOT NULL    -- Editorial code stored as text. Example: ZN19
)
;

CREATE TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY
(
	DOM_ONLINE_PACKAGE_VALIDITY_ID bigserial NOT NULL,    -- Artificial key
	DOM_ONLINE_PACKAGE_ID bigint NOT NULL,    -- Reference to DOM_ONLINE_PACKAGE
	VALIDITY_ID bigint NOT NULL,    -- Reference to VALIDITY
	SORT_ORDER integer NOT NULL   DEFAULT 1,    -- For some VALIDITY a DOM_ONLINE_PACKAGE can have several VALIDITY_VALUE for the same VALIDITY_TYPE.  (That is: The validities are given in a list. To distinct these we use SORT_ORDER, starting with 1 for the first list entry. Validities which don't come with a list are defaulted to 1.)
	VALID_FROM timestamp(6) with time zone NOT NULL   DEFAULT '-infinity',    -- Indicates the timestamp at which the validity starts.
	VALID_TO timestamp(6) with time zone NOT NULL   DEFAULT 'infinity'    -- Indicates the timestamp at which the validity ends.
)
;

CREATE TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE
(
	DOM_UPDATE_PACKAGE_ID bigserial NOT NULL,    -- The internal id of the DOM Update Package resource inside the DOM Online Package service.
	UPDATE_PACKAGE_STATUS text NOT NULL,    -- Status of the update package creation.  Possible values are: 'error', 'started' and 'completed'
	CREATION_TIMESTAMP timestamp(6) with time zone NOT NULL,    -- Point in time (date and time), when the row was inserted into the database.
	MODIFICATION_TIMESTAMP timestamp(6) with time zone NULL    -- Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row.
)
;

CREATE TABLE DOM_ONLINE_PACKAGE.INSTRUCTION
(
	INSTRUCTION_ID bigserial NOT NULL,    -- The artificial primary key.
	DOM_UPDATE_PACKAGE_ID bigint NOT NULL,    -- Reference to DOM_UPDATE_PACKAGE
	INSTRUCTION_TYPE integer NOT NULL,    -- Numerical type of the instruction. Example: 101
	INSTRUCTION_DATA text NOT NULL    -- Details of the instruction. Example:  '{"dbId":"DOM_CONTENT_DB","tableName":"NODE"}', '{"NODE_ID":1000001,"PARENT_NODE_ID":null,"OBJECT_ID_FROM_SOURCE":"2e119106434a89f6354ae36570e2ef1c","ORDER_NO":0}'
)
;

CREATE TABLE DOM_ONLINE_PACKAGE.MEDIA
(
	MEDIA_ID bigserial NOT NULL,    -- The artificial primary key.
	MEDIA_TYPE integer NOT NULL,    -- Numerical type of the media.
	MEDIA_URL text NOT NULL,    -- Complete URL to download the media file. Example: http://www.akamai.com/oa/2aaa5b4420c86cb2354ae36539c22f51_1_de-DE.jpg
	LANGUAGE text NOT NULL,    -- Language Examples: "de", "en", ...
	LOCALE text NOT NULL    -- This field refers to the localization of the LANGUAGE used in different countries.
)
;

CREATE TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_MEDIA
(
	DOM_UPDATE_PACKAGE_MEDIA_ID bigserial NOT NULL,    -- Artificial key
	DOM_UPDATE_PACKAGE_ID bigint NOT NULL,    -- Reference to DOM_UPDATE_PACKAGE
	MEDIA_ID bigint NOT NULL    -- Reference to MEDIA
)
;

CREATE TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE
(
	DOM_UPDATE_ONLINE_PACKAGE_ID bigserial NOT NULL,    -- Artificial key
	DOM_UPDATE_PACKAGE_ID bigint NOT NULL,    -- Reference to DOM_UPDATE_PACKAGE
	DOM_ONLINE_PACKAGE_ID_VEHICLE bigint NOT NULL,    -- The reference to the  DOM_ONLINE_PACKAGE to specify the version currently installed on the vehicle.
	DOM_ONLINE_PACKAGE_ID_BACKEND bigint NOT NULL    -- The reference to the  DOM_ONLINE_PACKAGE to specify the most current version available in the backend.
)
;

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE DOM_ONLINE_PACKAGE.SYS_PARAM ADD CONSTRAINT PK_SYS_PARAM
	PRIMARY KEY (SYS_PARAM_ID)
;

ALTER TABLE DOM_ONLINE_PACKAGE.SYS_PARAM
  ADD CONSTRAINT UK_SYS_PARAM_SEC_KEY UNIQUE (PAR_NAME)
;

ALTER TABLE DOM_ONLINE_PACKAGE.VALIDITY ADD CONSTRAINT PK_VALIDITY
	PRIMARY KEY (VALIDITY_ID)
;

ALTER TABLE DOM_ONLINE_PACKAGE.VALIDITY
  ADD CONSTRAINT UK_VALIDITY_SEC_KEY UNIQUE (VALIDITY_TYPE,VALIDITY_VALUE)
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE ADD CONSTRAINT PK_DOM_ONLINE_PACKAGE
	PRIMARY KEY (DOM_ONLINE_PACKAGE_ID)
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE ADD CONSTRAINT PK_DOM_ONLINE_PACKAGE_RESOURCE
	PRIMARY KEY (DOM_ONLINE_PACKAGE_RESOURCE_ID)
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE
  ADD CONSTRAINT UK_DOM_ONLINE_PACKAGE_RESOURCE_SEC_KEY UNIQUE (DOM_ONLINE_PACKAGE_ID,ID_TAG)
;

CREATE INDEX IXFK_DOM_ONLINE_PACKAGE_RESOURCE_DOM_ONLINE_PACKAGE ON DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE (DOM_ONLINE_PACKAGE_ID ASC)
;

ALTER TABLE DOM_ONLINE_PACKAGE.DATA_CARD ADD CONSTRAINT PK_DATA_CARD
	PRIMARY KEY (DATA_CARD_ID)
;

ALTER TABLE DOM_ONLINE_PACKAGE.DATA_CARD
  ADD CONSTRAINT UK_DATA_CARD UNIQUE (DOM_ONLINE_PACKAGE_ID,EDITORIAL_CODE)
;

CREATE INDEX IXFK_DATA_CARD_DOM_ONLINE_PACKAGE ON DOM_ONLINE_PACKAGE.DATA_CARD (DOM_ONLINE_PACKAGE_ID ASC)
;

CREATE INDEX IX_DATA_CARD_EDITORIAL_CODE ON DOM_ONLINE_PACKAGE.DATA_CARD (EDITORIAL_CODE ASC)
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY ADD CONSTRAINT PK_DOM_ONLINE_PACKAGE_VALIDITY
	PRIMARY KEY (DOM_ONLINE_PACKAGE_VALIDITY_ID)
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY
  ADD CONSTRAINT UK_DOM_ONLINE_PACKAGE_VALIDITY_SEC_KEY UNIQUE (DOM_ONLINE_PACKAGE_ID,VALIDITY_ID,SORT_ORDER,VALID_FROM,VALID_TO)
;

CREATE INDEX IXFK_DOM_ONLINE_PACKAGE_VALIDITY_DOM_ONLINE_PACKAGE ON DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY (DOM_ONLINE_PACKAGE_ID ASC)
;

CREATE INDEX IXFK_DOM_ONLINE_PACKAGE_VALIDITY_VALIDITY ON DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY (VALIDITY_ID ASC)
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE ADD CONSTRAINT PK_DOM_UPDATE_PACKAGE
	PRIMARY KEY (DOM_UPDATE_PACKAGE_ID)
;

ALTER TABLE DOM_ONLINE_PACKAGE.INSTRUCTION ADD CONSTRAINT PK_INSTRUCTION
	PRIMARY KEY (INSTRUCTION_ID)
;

CREATE INDEX IXFK_INSTRUCTIONS_DOM_UPDATE_PACKAGE ON DOM_ONLINE_PACKAGE.INSTRUCTION (DOM_UPDATE_PACKAGE_ID ASC)
;

ALTER TABLE DOM_ONLINE_PACKAGE.MEDIA ADD CONSTRAINT PK_MEDIA
	PRIMARY KEY (MEDIA_ID)
;

ALTER TABLE DOM_ONLINE_PACKAGE.MEDIA
  ADD CONSTRAINT UK_MEDIA UNIQUE (MEDIA_TYPE,MEDIA_URL,LANGUAGE,LOCALE)
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_MEDIA ADD CONSTRAINT PK_DOM_ONLINE_PACKAGE_MEDIA
	PRIMARY KEY (DOM_UPDATE_PACKAGE_MEDIA_ID)
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_MEDIA
  ADD CONSTRAINT UK_DOM_ONLINE_PACKAGE_MEDIA UNIQUE (DOM_UPDATE_PACKAGE_ID,MEDIA_ID)
;

CREATE INDEX IXFK_DOM_UPDATE_PACKAGE_MEDIA_DOM_UPDATE_PACKAGE ON DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_MEDIA (DOM_UPDATE_PACKAGE_ID ASC)
;

CREATE INDEX IXFK_DOM_UPDATE_PACKAGE_MEDIA_MEDIA ON DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_MEDIA (MEDIA_ID ASC)
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE ADD CONSTRAINT PK_DOM_UPDATE_ONLINE_PACKAGE
	PRIMARY KEY (DOM_UPDATE_ONLINE_PACKAGE_ID)
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE
  ADD CONSTRAINT UK_DOM_UPDATE_ONLINE_PACKAGE UNIQUE (DOM_UPDATE_PACKAGE_ID,DOM_ONLINE_PACKAGE_ID_VEHICLE,DOM_ONLINE_PACKAGE_ID_BACKEND)
;

CREATE INDEX IXFK_DOM_UPDATE_ONLINE_PACKAGE_DOM_ONLINE_PACKAGE ON DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE (DOM_ONLINE_PACKAGE_ID_VEHICLE ASC)
;

CREATE INDEX IXFK_DOM_UPDATE_ONLINE_PACKAGE_DOM_ONLINE_PACKAGE_02 ON DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE (DOM_ONLINE_PACKAGE_ID_BACKEND ASC)
;

CREATE INDEX IXFK_DOM_UPDATE_ONLINE_PACKAGE_DOM_UPDATE_PACKAGE ON DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE (DOM_UPDATE_PACKAGE_ID ASC)
;

/* Create Foreign Key Constraints */

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE ADD CONSTRAINT FK_DOM_ONLINE_PACKAGE_RESOURCE_DOM_ONLINE_PACKAGE
	FOREIGN KEY (DOM_ONLINE_PACKAGE_ID) REFERENCES DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE (DOM_ONLINE_PACKAGE_ID) ON DELETE Cascade ON UPDATE Cascade
;

ALTER TABLE DOM_ONLINE_PACKAGE.DATA_CARD ADD CONSTRAINT FK_DATA_CARD_DOM_ONLINE_PACKAGE
	FOREIGN KEY (DOM_ONLINE_PACKAGE_ID) REFERENCES DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE (DOM_ONLINE_PACKAGE_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY ADD CONSTRAINT FK_DOM_ONLINE_PACKAGE_VALIDITY_DOM_ONLINE_PACKAGE
	FOREIGN KEY (DOM_ONLINE_PACKAGE_ID) REFERENCES DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE (DOM_ONLINE_PACKAGE_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY ADD CONSTRAINT FK_DOM_ONLINE_PACKAGE_VALIDITY_VALIDITY
	FOREIGN KEY (VALIDITY_ID) REFERENCES DOM_ONLINE_PACKAGE.VALIDITY (VALIDITY_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE DOM_ONLINE_PACKAGE.INSTRUCTION ADD CONSTRAINT FK_INSTRUCTIONS_DOM_UPDATE_PACKAGE
	FOREIGN KEY (DOM_UPDATE_PACKAGE_ID) REFERENCES DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE (DOM_UPDATE_PACKAGE_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_MEDIA ADD CONSTRAINT FK_DOM_UPDATE_PACKAGE_MEDIA_DOM_UPDATE_PACKAGE
	FOREIGN KEY (DOM_UPDATE_PACKAGE_ID) REFERENCES DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE (DOM_UPDATE_PACKAGE_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_MEDIA ADD CONSTRAINT FK_DOM_UPDATE_PACKAGE_MEDIA_MEDIA
	FOREIGN KEY (MEDIA_ID) REFERENCES DOM_ONLINE_PACKAGE.MEDIA (MEDIA_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE ADD CONSTRAINT FK_DOM_UPDATE_ONLINE_PACKAGE_DOM_ONLINE_PACKAGE_BACKEND
	FOREIGN KEY (DOM_ONLINE_PACKAGE_ID_BACKEND) REFERENCES DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE (DOM_ONLINE_PACKAGE_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE ADD CONSTRAINT FK_DOM_UPDATE_ONLINE_PACKAGE_DOM_ONLINE_PACKAGE_VEHICLE
	FOREIGN KEY (DOM_ONLINE_PACKAGE_ID_VEHICLE) REFERENCES DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE (DOM_ONLINE_PACKAGE_ID) ON DELETE No Action ON UPDATE No Action
;

ALTER TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE ADD CONSTRAINT FK_DOM_UPDATE_ONLINE_PACKAGE_DOM_UPDATE_PACKAGE
	FOREIGN KEY (DOM_UPDATE_PACKAGE_ID) REFERENCES DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE (DOM_UPDATE_PACKAGE_ID) ON DELETE No Action ON UPDATE No Action
;

/* Create Table Comments, Sequences for Autonumber Columns */

COMMENT ON TABLE DOM_ONLINE_PACKAGE.SYS_PARAM
	IS 'This table is used to store the names and values of system parameters, which are valid for the whole system, like software versions, paths, etc.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.SYS_PARAM.SYS_PARAM_ID
	IS 'Internal Id. Primary key of the table.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.SYS_PARAM.PAR_NAME
	IS 'Name of the parameter.  This must be unique for all rows in the table.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.SYS_PARAM.PAR_VALUE
	IS 'Value of the parameter.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.SYS_PARAM.PAR_DESCRIPTION
	IS 'Description of the parameter. It should describe the meaning of the specific parameter or for what purpose the parameter is needed.'
;



COMMENT ON TABLE DOM_ONLINE_PACKAGE.VALIDITY
	IS 'A table to give validity values for content and for packages.  So this table defines specific string values for specific validities that can be refered by other tables.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.VALIDITY.VALIDITY_ID
	IS 'The artificial primary key.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.VALIDITY.VALIDITY_TYPE
	IS 'The logical validity/meta data types. As of now these would be the possible values:  pa-id business-line vehicle-line vehicle-line-variant vehicle-market state-of-construction market device device-model device-model-variant device-market device-layout information-product'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.VALIDITY.VALIDITY_VALUE
	IS 'The specific value for the validity named VALIDITY_TYPE.  Example: ''ECE/ROW'' for VALIDITY_TYPE = ''market'''
;



COMMENT ON TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE
	IS 'This table is used to protocol the creation of DOM-Online-Packages created by the DOM Online Package Service.  It represents the resource onlinepackages of the DOM Online Package Service. '
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_ID
	IS 'The internal id of the DOM Online Package resource inside the DOM Online Package service.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE.ONLINE_PACKAGE_STATUS
	IS 'Status of the online package creation.  Possible values are: ''error'', ''started'' and ''completed'''
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE.LANGUAGE
	IS 'Language Examples: "de", "en", ...   The attributes LANGUAGE and LOCALE can be concatenated: e.g. "de_DE", "en_GB", ... '
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE.LOCALE
	IS 'This field refers to the localization of the LANGUAGE used in different countries. '
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE.HASH_VALUE
	IS 'A hash value over all editorial codes stored in the table DATA_CARD.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE.REVISION
	IS 'Revision of the online package (for the specific hash value).'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE.LOG
	IS 'A column to store the complete logging regarding the process of package creation.  Single log entries are composed as an object in JSON and always appended to the existing log text.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE.VALID_FROM
	IS 'Point of time, from when this row is valid. Default: -infinity'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE.VALID_TO
	IS 'Point of time, until this row is valid.  Default: infinity'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE.CREATION_TIMESTAMP
	IS 'Point in time (date and time), when the row was inserted into the database.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE.MODIFICATION_TIMESTAMP
	IS 'Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row.'
;



COMMENT ON TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE
	IS 'This table is depending in a 1:n relationship from table DOM_ONLINE_PACKAGE to store a list of artifactory resources for the resource onlinepackages.  One package resource could contain several resource objects that are stored in an artifactory.  Each entry in this table contains as payload the distinct ID_TAG (ID_TAG is unique for one /onlinepackages resource) and the complete RESOURCE_URL.  As of now the only planned resource is DB.  The RESOURCE_URL shall point to the location where the dom-content-data.db is stored.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE.DOM_ONLINE_PACKAGE_RESOURCE_ID
	IS 'An artificial primary key for this table.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE.DOM_ONLINE_PACKAGE_ID
	IS 'Reference to DOM_ONLINE_PACKAGE'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE.ID_TAG
	IS 'An identifying tag/name for the kind of resource that is stored.  As of now the only planned ID_TAG is 	- ''DB''  Note that there is a unique constraint for DOM_ONLINE_PACKAGE_ID and ID_TAG in this table. One ID must only exist once for one online package.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE.RESOURCE_ID
	IS 'The (internal) ID of the resource that is stored.  For now there is just one resource planned, which is the database resource of the DOM Content service:  DOM_DATABASE_RESOURCE.DOM_DATABASE_RESOURCE_ID (Vehicle Backend DB). '
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE.RESOURCE_URL
	IS 'This is the full/complete URL to the object/resource in the artifactory.  E.g. ''https://ntg7oa.mercedes-benz.com/artifactory/5471248923493484/README.md'''
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_RESOURCE.MD5_CHECKSUM
	IS 'This column contains an MD5 hash value for the file that is stored in the given RESOURCE_URL. It always consists of 32 hexadecimal digits.'
;



COMMENT ON TABLE DOM_ONLINE_PACKAGE.DATA_CARD
	IS 'A table to store the editorial codes of a car, which are relevant for the creation of the Online Package.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DATA_CARD.DATA_CARD_ID
	IS 'The artificial primary key.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DATA_CARD.DOM_ONLINE_PACKAGE_ID
	IS 'Reference to DOM_ONLINE_PACKAGE'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DATA_CARD.EDITORIAL_CODE
	IS 'Editorial code stored as text. Example: ZN19'
;



COMMENT ON TABLE DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY
	IS 'Many-to-many relation between DOM_ONLINE_PACKAGE and VALIDITY'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY.DOM_ONLINE_PACKAGE_VALIDITY_ID
	IS 'Artificial key'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY.DOM_ONLINE_PACKAGE_ID
	IS 'Reference to DOM_ONLINE_PACKAGE'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY.VALIDITY_ID
	IS 'Reference to VALIDITY'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY.SORT_ORDER
	IS 'For some VALIDITY a DOM_ONLINE_PACKAGE can have several VALIDITY_VALUE for the same VALIDITY_TYPE.  (That is: The validities are given in a list. To distinct these we use SORT_ORDER, starting with 1 for the first list entry. Validities which don''t come with a list are defaulted to 1.)'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY.VALID_FROM
	IS 'Indicates the timestamp at which the validity starts.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_VALIDITY.VALID_TO
	IS 'Indicates the timestamp at which the validity ends. '
;



COMMENT ON TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE
	IS 'This table is used to protocol the creation of DOM UPDATE packages created by the DOM Online Package Service.  It represents the resource updatepackages of the DOM Online Package Service. '
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE.DOM_UPDATE_PACKAGE_ID
	IS 'The internal id of the DOM Update Package resource inside the DOM Online Package service.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE.UPDATE_PACKAGE_STATUS
	IS 'Status of the update package creation.  Possible values are: ''error'', ''started'' and ''completed'''
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE.CREATION_TIMESTAMP
	IS 'Point in time (date and time), when the row was inserted into the database.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE.MODIFICATION_TIMESTAMP
	IS 'Point in time (date and time), when the row was updated. Is initially set to NULL, when inserting a row.'
;



COMMENT ON TABLE DOM_ONLINE_PACKAGE.INSTRUCTION
	IS 'A table to store the necessary instructions after identifying the differences between the installed package in the car and the available data in the backend.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.INSTRUCTION.INSTRUCTION_ID
	IS 'The artificial primary key.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.INSTRUCTION.DOM_UPDATE_PACKAGE_ID
	IS 'Reference to DOM_UPDATE_PACKAGE'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.INSTRUCTION.INSTRUCTION_TYPE
	IS 'Numerical type of the instruction. Example: 101'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.INSTRUCTION.INSTRUCTION_DATA
	IS 'Details of the instruction. Example:  ''{"dbId":"DOM_CONTENT_DB","tableName":"NODE"}'', ''{"NODE_ID":1000001,"PARENT_NODE_ID":null,"OBJECT_ID_FROM_SOURCE":"2e119106434a89f6354ae36570e2ef1c","ORDER_NO":0}'''
;



COMMENT ON TABLE DOM_ONLINE_PACKAGE.MEDIA
	IS 'A table to store the necessary media files after identifying the differences between the installed package in the car and the available data in the backend.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.MEDIA.MEDIA_ID
	IS 'The artificial primary key.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.MEDIA.MEDIA_TYPE
	IS 'Numerical type of the media.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.MEDIA.MEDIA_URL
	IS 'Complete URL to download the media file. Example: http://www.akamai.com/oa/2aaa5b4420c86cb2354ae36539c22f51_1_de-DE.jpg'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.MEDIA.LANGUAGE
	IS 'Language Examples: "de", "en", ... '
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.MEDIA.LOCALE
	IS 'This field refers to the localization of the LANGUAGE used in different countries. '
;



COMMENT ON TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_MEDIA
	IS 'Many-to-many relation between DOM_UPDATE_PACKAGE and MEDIA'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_MEDIA.DOM_UPDATE_PACKAGE_MEDIA_ID
	IS 'Artificial key'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_MEDIA.DOM_UPDATE_PACKAGE_ID
	IS 'Reference to DOM_UPDATE_PACKAGE'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_MEDIA.MEDIA_ID
	IS 'Reference to MEDIA'
;



COMMENT ON TABLE DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE
	IS 'Many-to-many relation between DOM_UPDATE_PACKAGE and DOM_ONLINE_PACKAGE.   This table contains two foreign key constraints to the table DOM_ONLINE_PACKAGE, one for the vehicle and one for the backend database.  Example for a POST /updatepackages:  {   "message": {     onlinePackageList: [       {         "onlinePackageIdVehicle": "1",         "onlinePackageIdBackend": "101"       },       {         "onlinePackageIdVehicle": "2",         "onlinePackageIdBackend": "201"       },       {         "onlinePackageIdVehicle": "3",         "onlinePackageIdBackend": "301"       }     ]   } }  The message above will lead to this result in the database:  DOM_UPDATE_ONLINE_PACKAGE_ID | DOM_UPDATE_PACKAGE_ID | DOM_ONLINE_PACKAGE_ID_VEHICLE | DOM_ONLINE_PACKAGE_ID_BACKEND 1 | 1001 | 1 | 101 2 | 1001 | 2 | 201 3 | 1001 | 3 | 301'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE_ID
	IS 'Artificial key'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE.DOM_UPDATE_PACKAGE_ID
	IS 'Reference to DOM_UPDATE_PACKAGE'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_ID_VEHICLE
	IS 'The reference to the  DOM_ONLINE_PACKAGE to specify the version currently installed on the vehicle.'
;

COMMENT ON COLUMN DOM_ONLINE_PACKAGE.DOM_UPDATE_ONLINE_PACKAGE.DOM_ONLINE_PACKAGE_ID_BACKEND
	IS 'The reference to the  DOM_ONLINE_PACKAGE to specify the most current version available in the backend.'
;



/* Create Views */

CREATE VIEW DOM_ONLINE_PACKAGE.v_online_package_validity AS
select
	pv.dom_online_package_id,
	v.validity_type,
	v.validity_value,
	p.language,
	p.locale
from
	dom_online_package.dom_online_package p
	inner join dom_online_package.dom_online_package_validity pv
		on p.dom_online_package_id = pv.dom_online_package_id
	inner join dom_online_package.validity v
		on pv.validity_id = v.validity_id
where
	current_timestamp between pv.valid_from and pv.valid_to
;


INSERT INTO dom_online_package.sys_param (sys_param_id, par_name, par_value, par_description)
	VALUES (DEFAULT, 'DOM_ONLINE_PACKAGE_DB_VERSION', '1.1.3', 'Version of the DOM Online Package DB')
;