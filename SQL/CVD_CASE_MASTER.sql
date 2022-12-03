 CREATE SEQUENCE  "CASE_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE;
 
 

  CREATE TABLE "CVD_CASE_MASTER" 
   (	"CASE_ID" NUMBER(20,0) NOT NULL ENABLE, 
	"SOURCE" VARCHAR2(60) NOT NULL ENABLE, 
	"CASE_TYPE" VARCHAR2(10) NOT NULL ENABLE, 
	"FIRST_NAME" VARCHAR2(30) NOT NULL ENABLE, 
	"LAST_NAME" VARCHAR2(30) NOT NULL ENABLE, 
	"PHONE" VARCHAR2(15) NOT NULL ENABLE, 
	"EMAIL" VARCHAR2(30), 
	"DATE_OF_BIRTH" DATE NOT NULL ENABLE, 
	"NATIONAL_ID" VARCHAR2(20) NOT NULL ENABLE, 
	"NATIONAL_ID_TYPE" VARCHAR2(30) NOT NULL ENABLE, 
	"STREET_ADDRESS" VARCHAR2(50) NOT NULL ENABLE, 
	"CITY" VARCHAR2(30) NOT NULL ENABLE, 
	"STATE" VARCHAR2(30) NOT NULL ENABLE, 
	"POSTAL" VARCHAR2(30) NOT NULL ENABLE, 
	"COUNTRY" VARCHAR2(30) NOT NULL ENABLE, 
	"CREATE_DATE" DATE NOT NULL ENABLE, 
	"UPDATE_DATE" DATE NOT NULL ENABLE, 
	"CREATE_BY" VARCHAR2(30), 
	"UPDATE_BY" VARCHAR2(30), 
	 CONSTRAINT "CASE_ID_PK" PRIMARY KEY ("CASE_ID"));
 

CREATE OR REPLACE TRIGGER "CASE_ID_TR" 
    BEFORE INSERT ON "CVD_CASE_MASTER"
    FOR EACH ROW
BEGIN
  SELECT CASE_SEQ.NEXTVAL
  INTO   :new.CASE_ID
  FROM   dual;
END;


ALTER TRIGGER "CASE_ID_TR" ENABLE;

select * from CVD_CASE_MASTER;

CREATE OR replace PROCEDURE insert_covid_master (
in_source           IN VARCHAR2,
in_case_type        IN VARCHAR2, 
in_first_name       IN VARCHAR2, 
in_last_name        IN VARCHAR2, 
in_phone            IN VARCHAR2, 
in_email            IN VARCHAR2, 
in_date_of_birth    IN VARCHAR2, 
in_national_id      IN VARCHAR2, 
in_national_id_type IN VARCHAR2, 
in_street_address   IN VARCHAR2, 
in_city             IN VARCHAR2, 
in_state            IN VARCHAR2, 
in_postal           IN VARCHAR2, 
in_country          IN VARCHAR2, 
in_create_date      IN VARCHAR2, 
in_update_date      IN VARCHAR2, 
in_create_by        IN VARCHAR2, 
in_update_by        IN VARCHAR2, 
out_case_id         OUT NUMBER) 
AS 
BEGIN 
    INSERT INTO cvd_case_master 
                (source, 
                 case_type, 
                 first_name, 
                 last_name, 
                 phone, 
                 email, 
                 date_of_birth, 
                 national_id, 
                 national_id_type, 
                 street_address, 
                 city, 
                 state, 
                 postal, 
                 country, 
                 create_date, 
                 update_date, 
                 create_by, 
                 update_by) 
    VALUES     (in_source, 
                in_case_type, 
                in_first_name, 
                in_last_name, 
                in_phone, 
                in_email, 
                To_date(in_date_of_birth, 'YYYY-MM-DD'), 
                in_national_id, 
                in_national_id_type, 
                in_street_address, 
                in_city, 
                in_state, 
                in_postal, 
                in_country, 
                To_date(in_create_date, 'YYYY-MM-DD'), 
                To_date(in_update_date, 'YYYY-MM-DD'), 
                in_create_by, 
                in_update_by) 
    returning case_id INTO out_case_id; 
END insert_covid_master; 

/ 

