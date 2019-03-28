REM ***********************
-- Done by Dimitrii Korolevskii , Andrii Kosenko and Olga Rudina
-- ID: 156103160,155701162 and 039949136
-- Date: 11.22.2018
-- Purpouse:  Assignment 2 - DBS301
REM ***********************

SET SERVEROUTPUT ON;

SET FEEDBACK OFF; 


REM
REM This PART of script will drop all CONSTRAINTS AND TABLES 

BEGIN
    DBMS_OUTPUT.PUT_LINE('Delete tables and data if exist...');
END;
/  

DROP TABLE jwaddresses CASCADE CONSTRAINTS; 

DROP TABLE jwadvertising CASCADE CONSTRAINTS; 

DROP TABLE jwadvertisingoutlet CASCADE CONSTRAINTS; 

DROP TABLE jwagencyinfo CASCADE CONSTRAINTS; 

DROP TABLE jwareas CASCADE CONSTRAINTS; 

DROP TABLE jwclientagenciesinfo CASCADE CONSTRAINTS; 

DROP TABLE jwclient CASCADE CONSTRAINTS; 

DROP TABLE jwadvertising CASCADE CONSTRAINTS; 

DROP TABLE jwclientinfo CASCADE CONSTRAINTS; 

DROP TABLE jwpropclient CASCADE CONSTRAINTS; 

DROP TABLE jwseller CASCADE CONSTRAINTS; 

DROP TABLE jwpropseller CASCADE CONSTRAINTS; 

DROP TABLE jwproperty CASCADE CONSTRAINTS; 

DROP TABLE jwbridge_ad_outlet CASCADE CONSTRAINTS; 

DROP TABLE jwpropadvertising CASCADE CONSTRAINTS; 

SET FEEDBACK ON;


REM
REM This PART of the script create JWAREAS table. 
CREATE TABLE jwareas 
  ( 
     areaid          NUMBER(6), 
     areaname        VARCHAR2(25) NOT NULL, 
     areadescription VARCHAR2(100), 
     CONSTRAINT areas_areaid_pk PRIMARY KEY(areaid) 
  ); 


REM
REM This PART of the script inserts meaningful data to JWAREAS table. 
INSERT INTO jwareas 
VALUES      (4000, 
             'Scarborough', 
'Administrative district. It occupies the eastern part of the city.'
); 

INSERT INTO jwareas 
VALUES      (4013, 
             'North York', 
'Administrative district. It is located directly north of Old Toronto.'
); 

INSERT INTO jwareas 
VALUES      (4026, 
             'Etobicoke', 
'Is an administrative district and former city that makes up the western part of Toronto.' 
); 

INSERT INTO jwareas 
VALUES      (4039, 
             'Toronto Central', 
             'Is the city centre and main central business district of Toronto.' 
); 

INSERT INTO jwareas 
VALUES      (4052, 
             'East York', 
             'It is separated by the Don River from the former City of Toronto.' 
); 

INSERT INTO jwareas 
VALUES      (4065, 
             'York', 
'It is located northwest of Old Toronto, southwest of North York and east of Etobicoke.' 
); 




REM
REM This PART of the script create JWSCHOOLS table.
CREATE TABLE jwschools 
  ( 
     schoolid   NUMBER(6), 
     schooltype VARCHAR2(10) NOT NULL, 
     schoolname VARCHAR2(100) NOT NULL, 
     areaid     NUMBER(6), 
     CONSTRAINT school_schoolid_pk PRIMARY KEY(schoolid), 
     CONSTRAINT school_schooltype CHECK(schooltype IN ('High', 'Elementary', 
     'Middle')), 
     CONSTRAINT area_fk FOREIGN KEY(areaid) REFERENCES jwareas(areaid) 
  ); 


REM
REM This PART of the script inserts meaningful data to JWSCHOOLS table.
INSERT INTO jwschools 
VALUES      (2200, 
             'Elementary', 
             'Adam Beck Junior Public School', 
             4000); 

INSERT INTO jwschools 
VALUES      (2213, 
             'Middle', 
             'Africentric Alternative School', 
             4013); 

INSERT INTO jwschools 
VALUES      (2226, 
             'Elementary', 
             'Agincourt Junior Public School', 
             4000); 

INSERT INTO jwschools 
VALUES      (2239, 
             'High', 
             'Agnes Macphail Public School', 
             4000); 

INSERT INTO jwschools 
VALUES      (2252, 
             'Elementary', 
             'Albion Heights Junior Middle School', 
             4026); 

INSERT INTO jwschools 
VALUES      (2265, 
             'Elementary', 
             'Alexander Muir/Gladstone Ave Junior and Senior Public School', 
             4039); 

INSERT INTO jwschools 
VALUES      (2278, 
             'Middle', 
             'Alexander Stirling Public School', 
             4000); 

INSERT INTO jwschools 
VALUES      (2291, 
             'Elementary', 
             'Alexmuir Junior Public School', 
             4000); 

INSERT INTO jwschools 
VALUES      (2304, 
             'Elementary', 
             'Allenby Junior Public School', 
             4039); 

INSERT INTO jwschools 
VALUES      (2317, 
             'Elementary', 
             'ALPHA Alternative Junior School', 
             4039); 

INSERT INTO jwschools 
VALUES      (2330, 
             'Middle', 
             'ALPHA II Alternative School', 
             4039); 

INSERT INTO jwschools 
VALUES      (2343, 
             'High', 
             'Alvin Curling Public School', 
             4000); 

INSERT INTO jwschools 
VALUES      (2356, 
             'Middle', 
             'Amesbury Middle School', 
             4013); 

INSERT INTO jwschools 
VALUES      (2382, 
             'Middle', 
             'Ancaster Public School', 
             4013); 

INSERT INTO jwschools 
VALUES      (2395, 
             'High', 
             'Annette Street Junior and Senior Public School', 
             4039); 

INSERT INTO jwschools 
VALUES      (2408, 
             'Middle', 
             'Anson Park Public School', 
             4000); 

INSERT INTO jwschools 
VALUES      (2421, 
             'Elementary', 
             'Anson S Taylor Junior Public School', 
             4000); 

INSERT INTO jwschools 
VALUES      (2434, 
             'Middle', 
             'Arbor Glen Public School', 
             4013); 

INSERT INTO jwschools 
VALUES      (2447, 
             'High', 
             'Armour Heights Public School', 
             4013); 

INSERT INTO jwschools 
VALUES      (2460, 
             'High', 
             'Avondale Elementary Alternative School', 
             4013); 
             
            
            

REM
REM This PART of the script create JWADDRESSES table.
CREATE TABLE jwaddresses 
  ( 
     addressid  NUMBER(6), 
     street     VARCHAR2(50) NOT NULL, 
     city       VARCHAR2(30) NOT NULL, 
     province   VARCHAR2(2), 
     postalcode VARCHAR(10) NOT NULL, 
     areaid     NUMBER(6), 
     CONSTRAINT addresses_addressid_pk PRIMARY KEY(addressid), 
     CONSTRAINT addresses_areas_areaid_fk FOREIGN KEY(areaid) REFERENCES jwareas 
     (areaid) 
  );   
     
             
REM
REM This PART of the script inserts meaningful data to JWADDRESSES table. 
INSERT INTO jwaddresses 
VALUES      (2000, 
             '67 Inglewood Dr', 
             'GTA', 
             'ON', 
             'M4T1H5', 
             4039); 

INSERT INTO jwaddresses 
VALUES      (2013, 
             '23 Wilket Rd', 
             'GTA', 
             'ON', 
             'M2L1N6', 
             4013); 

INSERT INTO jwaddresses 
VALUES      (2026, 
             '111 Military Trail', 
             'GTA', 
             'ON', 
             'M1C1A7', 
             4000); 

INSERT INTO jwaddresses 
VALUES      (2039, 
             '34 Lake Shore Blvd W', 
             'GTA', 
             'ON', 
             'M8V2Z6', 
             4026); 

INSERT INTO jwaddresses 
VALUES      (2052, 
             '98 Annette St', 
             'GTA', 
             'ON', 
             'M6P1N4', 
             4065); 

INSERT INTO jwaddresses 
VALUES      (2065, 
             '111 Dunkirk Rd', 
             'GTA', 
             'ON', 
             'M4C2L9', 
             4052); 

INSERT INTO jwaddresses 
VALUES      (2078, 
             '765 Lombard St', 
             'GTA', 
             'ON', 
             'M5C2V3', 
             4039); 

INSERT INTO jwaddresses 
VALUES      (2091, 
             '1 Keele St', 
             'GTA', 
             'ON', 
             'M3M2H4', 
             4013); 

INSERT INTO jwaddresses 
VALUES      (2104, 
             '21 Sheppard Ave E', 
             'GTA', 
             'ON', 
             'M1S5B2', 
             4000); 

INSERT INTO jwaddresses 
VALUES      (2117, 
             '76 The Queensway', 
             'GTA', 
             'ON', 
             'M8Z1N8', 
             4026); 
             
             
             

REM
REM This PART of the script create JWCLIENTAGENCIESINFO table.
CREATE TABLE jwclientagenciesinfo 
  ( 
     agencyid    NUMBER(6), 
     agencyname  VARCHAR2(30) NOT NULL, 
     phonenumber VARCHAR2(20) NOT NULL, 
     CONSTRAINT clientagenciesinfo_pk PRIMARY KEY(agencyid) 
  ); 
             
             
REM
REM This PART of the script inserts meaningful data to JWCLIENTAGENCIESINFO table.
INSERT INTO jwclientagenciesinfo 
VALUES      (1200, 
             'Bluetrain Inc.', 
             '877-754-1163'); 

INSERT INTO jwclientagenciesinfo 
VALUES      (1213, 
             'OKD Marketing', 
             '905-632-8850'); 

INSERT INTO jwclientagenciesinfo 
VALUES      (1226, 
             'SeeResponse', 
             '437-800-2014'); 

INSERT INTO jwclientagenciesinfo 
VALUES      (1239, 
             'Locomotive', 
             '514-524-5678'); 

INSERT INTO jwclientagenciesinfo 
VALUES      (1252, 
             'Atomic Motion', 
             '613-748-7655'); 

INSERT INTO jwclientagenciesinfo 
VALUES      (1265, 
             'OneMethod', 
             '416-649-0180'); 

INSERT INTO jwclientagenciesinfo 
VALUES      (1278, 
             'Intrigue', 
             '587-790-9514'); 

INSERT INTO jwclientagenciesinfo 
VALUES      (1291, 
             'Sid Lee', 
             '587-990-2927'); 

INSERT INTO jwclientagenciesinfo 
VALUES      (1304, 
             'Loopmedia', 
             '289-947-1498'); 

INSERT INTO jwclientagenciesinfo 
VALUES      (1317, 
             'GOWIDE', 
             '647-701-4451'); 
             
             


REM
REM This PART of the script create JWPROPERTYCATEGORY table.
CREATE TABLE jwpropertycategory 
  ( 
     categoryid     NUMBER(6), 
     propertytype   VARCHAR2(30) NOT NULL, 
     landsize       NUMBER(6), 
     maintenancefee NUMBER(6), 
     CONSTRAINT propertycategory_pk PRIMARY KEY(categoryid), 
     CONSTRAINT propertycategory_propertytype CHECK( propertytype IN ('Condo', 
     'Family')) 
  ); 
             
             
REM
REM This PART of the script inserts meaningful data to JWPROPERTYCATEGORY table.
INSERT INTO jwpropertycategory 
VALUES      (1000, 
             'Condo', 
             0, 
             1000); 

INSERT INTO jwpropertycategory 
VALUES      (1013, 
             'Family', 
             45000, 
             0); 

INSERT INTO jwpropertycategory 
VALUES      (1026, 
             'Condo', 
             0, 
             400); 

INSERT INTO jwpropertycategory 
VALUES      (1039, 
             'Family', 
             12000, 
             0); 

INSERT INTO jwpropertycategory 
VALUES      (1052, 
             'Condo', 
             0, 
             390); 

INSERT INTO jwpropertycategory 
VALUES      (1065, 
             'Family', 
             37000, 
             0); 

INSERT INTO jwpropertycategory 
VALUES      (1078, 
             'Family', 
             37000, 
             0); 

INSERT INTO jwpropertycategory 
VALUES      (1091, 
             'Condo', 
             0, 
             500); 

INSERT INTO jwpropertycategory 
VALUES      (1104, 
             'Family', 
             31000, 
             0); 

INSERT INTO jwpropertycategory 
VALUES      (1117, 
             'Condo', 
             0, 
             850); 
             



REM
REM This PART of the script create JWPROPERTYPARAMETERS table. 
CREATE TABLE jwpropertyparameters 
  ( 
     propertyparametersid NUMBER(6), 
     bedroomqty           NUMBER(2) NOT NULL, 
     bathroomqty          NUMBER(2) NOT NULL, 
     buildingsize         NUMBER(5), 
     price                NUMBER(9) NOT NULL, 
     CONSTRAINT propertyparameters_pk PRIMARY KEY(propertyparametersid) 
  ); 
             
             
REM
REM This PART of the script inserts meaningful data to JWPROPERTYPARAMETERS table.
INSERT INTO jwpropertyparameters 
VALUES      (345, 
             2, 
             1, 
             2500, 
             12980000); 

INSERT INTO jwpropertyparameters 
VALUES      (358, 
             1, 
             2, 
             3000, 
             11990000); 

INSERT INTO jwpropertyparameters 
VALUES      (371, 
             2, 
             1, 
             2300, 
             1998000); 

INSERT INTO jwpropertyparameters 
VALUES      (384, 
             1, 
             2, 
             2100, 
             3289000); 

INSERT INTO jwpropertyparameters 
VALUES      (397, 
             2, 
             2, 
             2800, 
             1499900); 

INSERT INTO jwpropertyparameters 
VALUES      (410, 
             1, 
             3, 
             2225, 
             1798000); 

INSERT INTO jwpropertyparameters 
VALUES      (423, 
             2, 
             3, 
             2100, 
             2808000); 

INSERT INTO jwpropertyparameters 
VALUES      (436, 
             1, 
             3, 
             2444, 
             3128000); 

INSERT INTO jwpropertyparameters 
VALUES      (449, 
             3, 
             1, 
             2439, 
             1678000); 

INSERT INTO jwpropertyparameters 
VALUES      (463, 
             1, 
             2, 
             4000, 
             3908000); 




REM
REM This PART of the script create JWPROPERTY table.
CREATE TABLE jwproperty 
  ( 
     propertyid           NUMBER(6), 
     addressid            NUMBER(6), 
     categoryid           NUMBER(6), 
     propertyparametersid NUMBER(6), 
     agencyid             NUMBER(6),  
     dateSold             Date,
     CONSTRAINT property_pk PRIMARY KEY(propertyid), 
     CONSTRAINT addresses_fk FOREIGN KEY(addressid) REFERENCES jwaddresses( 
     addressid), 
     CONSTRAINT propertyparameters_fk FOREIGN KEY(propertyparametersid) 
     REFERENCES jwpropertyparameters(propertyparametersid), 
     CONSTRAINT propertycategory_fk FOREIGN KEY(categoryid) REFERENCES 
     jwpropertycategory(categoryid), 
     CONSTRAINT clientagencyinfo_fk FOREIGN KEY(agencyid) REFERENCES 
     jwclientagenciesinfo(agencyid), 
     CONSTRAINT addressid_uk UNIQUE(addressid), 
     CONSTRAINT property_params_id_uk UNIQUE(propertyparametersid), 
     CONSTRAINT propertycategory_uk UNIQUE(categoryid)
  ); 

REM
REM This PART of the script inserts meaningful data to JWPROPERTY table.
INSERT INTO jwproperty 
VALUES      (2870, 
             2000, 
             1000, 
             345, 
             1200,
             to_date(20180327, 'YYYYMMDD')); 

INSERT INTO jwproperty 
VALUES      (2883, 
             2013, 
             1013, 
             358, 
             1213,
             null); 

INSERT INTO jwproperty 
VALUES      (2896, 
             2026, 
             1026, 
             371, 
             1226,
             to_date(20171114, 'YYYYMMDD')); 

INSERT INTO jwproperty 
VALUES      (2922, 
             2039, 
             1039, 
             384, 
             1239,
             null); 

INSERT INTO jwproperty 
VALUES      (2935, 
             2052, 
             1052, 
             397, 
             1252,
             to_date(20180211, 'YYYYMMDD')); 

INSERT INTO jwproperty 
VALUES      (2948, 
             2065, 
             1065, 
             410, 
             1265,
             null); 

INSERT INTO jwproperty 
VALUES      (2961, 
             2078, 
             1078, 
             423, 
             1278,
             to_date(20180303, 'YYYYMMDD')); 

INSERT INTO jwproperty 
VALUES      (2974, 
             2091, 
             1091, 
             436, 
             1291,
             null); 

INSERT INTO jwproperty 
VALUES      (2987, 
             2104, 
             1104, 
             449, 
             1304,
             to_date(20180810, 'YYYYMMDD')); 

INSERT INTO jwproperty 
VALUES      (3000, 
             2117, 
             1117, 
             463, 
             1317,
             null); 
             
       


REM
REM This PART of the script create JWSELLER table.
CREATE TABLE jwseller 
  ( 
     sellerid            NUMBER(6), 
     firstname           VARCHAR(30) NOT NULL, 
     lastname            VARCHAR(30) NOT NULL, 
     phonenumber         VARCHAR2(20) NOT NULL, 
     email               VARCHAR(20), 
     ownershippercentage NUMBER(3) DEFAULT 100,
     CONSTRAINT seller_pk PRIMARY KEY(sellerid), 
     CONSTRAINT ownershippercentage_range CHECK(ownershippercentage BETWEEN 0 
     AND 100) 
  ); 
             
             
REM
REM This PART of the script inserts meaningful data to JWSELLER table. 
INSERT INTO jwseller 
VALUES      (20, 
             'Helen', 
             'Cabrera', 
             '403-336-4803', 
             'dbanarse@gmail.com', 
             50); 

INSERT INTO jwseller 
VALUES      (33, 
             'Kristian', 
             'Hill', 
             '226-471-4358', 
             'cgreuter@gmail.com',
             0); 

INSERT INTO jwseller 
VALUES      (46, 
             'Giada', 
             'Austin', 
             '581-601-2817', 
             'crypt@gmail.com', 
             27); 

INSERT INTO jwseller 
VALUES      (59, 
             'Ramon', 
             'Bullock', 
             '819-437-7320', 
             'jandrese@gmail.com', 
             25); 

INSERT INTO jwseller 
VALUES      (72, 
             'Aliya', 
             'Ferguson', 
             '902-453-6464', 
             'damian@gmail.com', 
             49); 

INSERT INTO jwseller 
VALUES      (85, 
             'Gauge', 
             'Koch', 
             '438-275-6448', 
             'payned@gmail.com', 
             30); 

INSERT INTO jwseller 
VALUES      (98, 
             'Milly', 
             'Knorr', 
             '819-634-5034', 
             'manuals@gmail.com', 
             0); 

INSERT INTO jwseller 
VALUES      (111, 
             'Ella', 
             'Janusz', 
             '819-448-9564', 
             'mfburgo@gmail.com', 
             20); 

INSERT INTO jwseller 
VALUES      (124, 
             'Catina', 
             'Dipaolo', 
             '418-731-1192', 
             'preneel@gmail.com', 
             17); 

INSERT INTO jwseller 
VALUES      (137, 
             'Muoi', 
             'Schacher', 
             '705-599-8787', 
             'jugalator@gmail.com', 
             41); 
             
             
             

REM
REM This PART of the script create JWPROPSELLER table.
CREATE TABLE jwpropseller 
  ( 
     propertyid NUMBER(6), 
     sellerid   NUMBER(6), 
     CONSTRAINT propseller_pk PRIMARY KEY(propertyid, sellerid), 
     CONSTRAINT seller_fk FOREIGN KEY(sellerid) REFERENCES jwseller(sellerid), 
     CONSTRAINT propseller_property_fk FOREIGN KEY(propertyid) REFERENCES 
     jwproperty(propertyid) 
  ); 

             
REM
REM This PART of the script inserts meaningful data to JWPROPSELLER table.
INSERT INTO jwpropseller 
VALUES      (2870, 
             20); 

INSERT INTO jwpropseller 
VALUES      (2883, 
             33); 

INSERT INTO jwpropseller 
VALUES      (2896, 
             46); 

INSERT INTO jwpropseller 
VALUES      (2922, 
             59); 

INSERT INTO jwpropseller 
VALUES      (2935, 
             72); 

INSERT INTO jwpropseller 
VALUES      (2948, 
             85); 

INSERT INTO jwpropseller 
VALUES      (2961, 
             98); 

INSERT INTO jwpropseller 
VALUES      (2974, 
             111); 

INSERT INTO jwpropseller 
VALUES      (2987, 
             124); 

INSERT INTO jwpropseller 
VALUES      (3000, 
             137); 
             
             
             

REM
REM This PART of the script create JWCLIENTINFO table.
CREATE TABLE jwclientinfo 
  ( 
     clientid                NUMBER(6), 
     firstname               VARCHAR2(30) NOT NULL, 
     lastname                VARCHAR2(30) NOT NULL, 
     phonenumber             VARCHAR2(20) NOT NULL, 
     email                   VARCHAR2(20), 
     ammountpaidforreferring NUMBER(6) DEFAULT 0, 
     CONSTRAINT clientinfo_clientid_pk PRIMARY KEY(clientid) 
  ); 

             
REM
REM This PART of the script inserts meaningful data to JWCLIENTINFO table.
INSERT INTO jwclientinfo 
VALUES      (1758, 
             'Shannon', 
             'Lozano', 
             '450-857-2251', 
             'gomor@gmail.com', 
             100); 

INSERT INTO jwclientinfo 
VALUES      (1771, 
             'Juliet', 
             'Cherry', 
             '581-263-7099', 
             'frode@gmail.com', 
             500); 

INSERT INTO jwclientinfo 
VALUES      (1784, 
             'Jaron', 
             'Giles', 
             '709-329-4805', 
             'pierce@gmail.com', 
             160); 

INSERT INTO jwclientinfo 
VALUES      (1797, 
             'Malcolm', 
             'Hudson', 
             '819-632-5527', 
             'baveja@gmail.com', 
             200); 

INSERT INTO jwclientinfo 
VALUES      (1810, 
             'Michelle', 
             'Briggs', 
             '604-331-4890', 
             'balchen@gmail.com', 
             240); 

INSERT INTO jwclientinfo 
VALUES      (1823, 
             'Mason', 
             'Livingston', 
             '647-713-5607', 
             'sinclair@gmail.com', 
             190); 

INSERT INTO jwclientinfo 
VALUES      (1836, 
             'Allen', 
             'Perrotti', 
             '902-323-1264', 
             'mhassel@gmail.com', 
             206); 

INSERT INTO jwclientinfo 
VALUES      (1849, 
             'Jackson', 
             'Schamber', 
             '613-464-4230', 
             'dogdude@gmail.com', 
             310); 

INSERT INTO jwclientinfo 
VALUES      (1862, 
             'Eden', 
             'Heinecke', 
             '579-859-8739', 
             'timlinux@gmail.com', 
             189); 

INSERT INTO jwclientinfo 
VALUES      (1875, 
             'Marianela', 
             'Dison', 
             '289-569-4175', 
             'mcrawfor@gmail.com', 
             239); 
             
             
             

REM
REM This PART of the script create JWPROPCLIENT table.
CREATE TABLE jwpropclient 
  ( 
     propertyid NUMBER(6), 
     clientid   NUMBER(6), 
     CONSTRAINT propclient_pk PRIMARY KEY(propertyid, clientid), 
     CONSTRAINT clientinfo_fk FOREIGN KEY(clientid) REFERENCES jwclientinfo( 
     clientid), 
     CONSTRAINT propclient_property_fk FOREIGN KEY(propertyid) REFERENCES 
     jwproperty(propertyid) 
  ); 


REM
REM This PART of the script inserts meaningful data to JWPROPCLIENT table.
INSERT INTO jwpropclient 
VALUES      (2870, 
             1758); 

INSERT INTO jwpropclient 
VALUES      (2883, 
             1771); 

INSERT INTO jwpropclient 
VALUES      (2896, 
             1784); 

INSERT INTO jwpropclient 
VALUES      (2922, 
             1797); 

INSERT INTO jwpropclient 
VALUES      (2935, 
             1810); 

INSERT INTO jwpropclient 
VALUES      (2948, 
             1823); 

INSERT INTO jwpropclient 
VALUES      (2961, 
             1836); 

INSERT INTO jwpropclient 
VALUES      (2974, 
             1849); 

INSERT INTO jwpropclient 
VALUES      (2987, 
             1862); 

INSERT INTO jwpropclient 
VALUES      (3000, 
             1875); 
             
             
            

REM
REM This PART of the script create JWADVERTISING table.
CREATE TABLE jwadvertising 
  ( 
     advertisingid NUMBER(6), 
     dateposted    DATE, 
     price         NUMBER(6), 
     CONSTRAINT advertisingid_pk PRIMARY KEY(advertisingid) 
  ); 

             
REM
REM This PART of the script inserts meaningful data to JWADVERTISING table.
INSERT INTO jwadvertising 
VALUES      (456, 
             To_date('07-DEC-2018', 'dd-MON-yyyy'), 
             '100'); 

INSERT INTO jwadvertising 
VALUES      (469, 
             To_date('11-JUN-2018', 'dd-MON-yyyy'), 
             '80'); 

INSERT INTO jwadvertising 
VALUES      (482, 
             To_date('14-JUL-2018', 'dd-MON-yyyy'), 
             '210'); 

INSERT INTO jwadvertising 
VALUES      (495, 
             To_date('22-JAN-2018', 'dd-MON-yyyy'), 
             '130'); 

INSERT INTO jwadvertising 
VALUES      (508, 
             To_date('28-MAR-2018', 'dd-MON-yyyy'), 
             '70'); 

INSERT INTO jwadvertising 
VALUES      (521, 
             To_date('17-APR-2018', 'dd-MON-yyyy'), 
             '200'); 

INSERT INTO jwadvertising 
VALUES      (534, 
             To_date('24-MAY-2018', 'dd-MON-yyyy'), 
             '85'); 

INSERT INTO jwadvertising 
VALUES      (547, 
             To_date('02-OCT-2018', 'dd-MON-yyyy'), 
             '78'); 

INSERT INTO jwadvertising 
VALUES      (560, 
             To_date('12-NOV-2018', 'dd-MON-yyyy'), 
             '205'); 

INSERT INTO jwadvertising 
VALUES      (573, 
             To_date('23-FEB-2018', 'dd-MON-yyyy'), 
             '175'); 
            



REM
REM This PART of the script create JWADVERTISINGOUTLET table.
CREATE TABLE jwadvertisingoutlet 
  ( 
     outletid         NUMBER(6), 
     ownername        VARCHAR(50) NOT NULL, 
     ownerphonenumber VARCHAR(20) NOT NULL, 
     outlettype       VARCHAR(9) NOT NULL, 
     CONSTRAINT advertisingoutlet_outletid_pk PRIMARY KEY(outletid), 
     CONSTRAINT advertisingoutlet_outlettype CHECK(outlettype IN ('Newspaper', 
     'Magazine', 'Web Site')) 
  ); 
             
             
REM
REM This PART of the script inserts meaningful data to JWADVERTISINGOUTLET table.
INSERT INTO jwadvertisingoutlet 
VALUES      (129, 
             'Linda', 
             '416-555-0129', 
             'Magazine'); 

INSERT INTO jwadvertisingoutlet 
VALUES      (142, 
             'Dawn', 
             '416-555-0130', 
             'Web Site'); 

INSERT INTO jwadvertisingoutlet 
VALUES      (155, 
             'Nancy', 
             '416-555-0100', 
             'Newspaper'); 

INSERT INTO jwadvertisingoutlet 
VALUES      (168, 
             'Gianna', 
             '416-555-0110', 
             'Web Site'); 

INSERT INTO jwadvertisingoutlet 
VALUES      (181, 
             'Brenda', 
             '416-555-0116', 
             'Newspaper'); 

INSERT INTO jwadvertisingoutlet 
VALUES      (194, 
             'Maike', 
             '416-555-0190', 
             'Magazine'); 

INSERT INTO jwadvertisingoutlet 
VALUES      (207, 
             'Lourie', 
             '705-331-4413', 
             'Newspaper'); 

INSERT INTO jwadvertisingoutlet 
VALUES      (220, 
             'Charlesetta', 
             '289-335-1873', 
             'Web Site'); 

INSERT INTO jwadvertisingoutlet 
VALUES      (233, 
             'Trinh', 
             '506-264-8774', 
             'Magazine'); 

INSERT INTO jwadvertisingoutlet 
VALUES      (246, 
             'Lucy', 
             '226-356-2792', 
             'Newspaper'); 
             
             
             

REM
REM This PART of the script create JWBRIDGE_AS_OUTLET table.
CREATE TABLE jwbridge_ad_outlet 
  ( 
     advertisingid NUMBER(6), 
     outletid      NUMBER(6), 
     CONSTRAINT bridge_ad_outlet_pk PRIMARY KEY (advertisingid, outletid), 
     CONSTRAINT advertising_fk FOREIGN KEY (advertisingid) REFERENCES 
     jwadvertising(advertisingid), 
     CONSTRAINT outletid_fk FOREIGN KEY (outletid) REFERENCES 
     jwadvertisingoutlet(outletid) 
  ); 
  
      
REM
REM This PART of the script inserts meaningful data to JWBRIDGE_AS_OUTLET table.
INSERT INTO jwbridge_ad_outlet 
VALUES      (456, 
             129); 

INSERT INTO jwbridge_ad_outlet 
VALUES      (469, 
             142); 

INSERT INTO jwbridge_ad_outlet 
VALUES      (482, 
             155); 

INSERT INTO jwbridge_ad_outlet 
VALUES      (495, 
             168); 

INSERT INTO jwbridge_ad_outlet 
VALUES      (508, 
             181); 

INSERT INTO jwbridge_ad_outlet 
VALUES      (521, 
             194); 

INSERT INTO jwbridge_ad_outlet 
VALUES      (534, 
             207); 

INSERT INTO jwbridge_ad_outlet 
VALUES      (547, 
             220); 

INSERT INTO jwbridge_ad_outlet 
VALUES      (560, 
             233); 

INSERT INTO jwbridge_ad_outlet 
VALUES      (573, 
             246); 
             
  
  
  
REM
REM This PART of the script create JWPROPADVERTISING  table. 
CREATE TABLE jwpropadvertising 
  ( 
     propertyid    NUMBER(6), 
     advertisingid NUMBER(6), 
     CONSTRAINT propadvertising_pk PRIMARY KEY(propertyid, advertisingid), 
     CONSTRAINT advertisingid_fk FOREIGN KEY(advertisingid) REFERENCES 
     jwadvertising(advertisingid), 
     CONSTRAINT propadvertising_property_fk FOREIGN KEY(propertyid) REFERENCES 
     jwproperty(propertyid) 
  ); 
  
             
REM
REM This PART of the script inserts meaningful data to JWPROPADVERTISING  table. 
INSERT INTO jwpropadvertising 
VALUES      (2870, 
             456); 

INSERT INTO jwpropadvertising 
VALUES      (2883, 
             469); 

INSERT INTO jwpropadvertising 
VALUES      (2896, 
             482); 

INSERT INTO jwpropadvertising 
VALUES      (2922, 
             495); 

INSERT INTO jwpropadvertising 
VALUES      (2935, 
             508); 

INSERT INTO jwpropadvertising 
VALUES      (2948, 
             521); 

INSERT INTO jwpropadvertising 
VALUES      (2961, 
             534); 

INSERT INTO jwpropadvertising 
VALUES      (2974, 
             547); 

INSERT INTO jwpropadvertising 
VALUES      (2987, 
             560); 

INSERT INTO jwpropadvertising 
VALUES      (3000, 
             573); 

       
REM END OF FILE 

SET FEEDBACK OFF;

DECLARE
    rc SYS_REFCURSOR;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Number of values inserted for each table:');
    OPEN rc FOR SELECT COUNT(*) jwschools FROM jwschools;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwareas FROM jwareas;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwaddresses FROM jwaddresses;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwpropertyparameters FROM jwpropertyparameters;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwpropertycategory FROM jwpropertycategory;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwclientagenciesinfo FROM jwclientagenciesinfo;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwadvertisingoutlet FROM jwadvertisingoutlet;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwadvertising FROM jwadvertising;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwclientinfo FROM jwclientinfo;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwpropclient FROM jwpropclient;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwseller FROM jwseller;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwpropseller FROM jwpropseller;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwproperty FROM jwproperty;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwbridge_ad_outlet FROM jwbridge_ad_outlet;
    dbms_sql.return_result(rc);
    OPEN rc FOR SELECT COUNT(*) jwpropadvertising FROM jwpropadvertising;
    dbms_sql.return_result(rc);
END;

SET FEEDBACK ON;

--END OF FILE--
