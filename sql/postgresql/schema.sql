CREATE SEQUENCE ituserpassword_s
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

CREATE TABLE ituserpassword
(
  id integer NOT NULL DEFAULT nextval(('ituserpassword_s'::text)::regclass),
  contentobject_id integer NOT NULL,
  last_password_change integer NOT NULL,
  last_passwords character varying(2000),
  CONSTRAINT ituserlogs_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);