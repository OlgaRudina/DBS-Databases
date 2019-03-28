-- ***********************
-- Name: Olga Rudina
-- ID: 039949136
-- Date: 26-Nov-2018
-- Purpose: Lab 10 DBS301
-- ***********************



-- 1.	Create table CITIES from table LOCATIONS, 
-- but only for location numbers less than 2000 
--(do NOT create this table from scratch, i.e. create and insert in one statement).

CREATE TABLE cities
    AS
        ( SELECT
            *
        FROM
            locations
        WHERE
            location_id < 2000
        );

--2.	Create table TOWNS from table LOCATIONS, 
-- but only for location numbers less than 1500 (do NOT create this table from scratch). 
-- This table will have same structure as table CITIES. 

CREATE TABLE towns
    AS
        ( SELECT
            *
        FROM
            locations
        WHERE
            location_id < 1500
        );

-- 3. Now you will empty your RECYCLE BIN with one powerful command. Then remove your table TOWNS, 
-- so that will remain in the recycle bin. Check that it is really there and what time was removed. 
-- Hint: Show RecycleBin,   Purge, Flashback

PURGE RECYCLEBIN;

DROP TABLE towns;

SHOW recyclebin;

--4.	Restore your table TOWNS from recycle bin and describe it. Check what is in your recycle bin now.

FLASHBACK TABLE towns TO BEFORE DROP;

DESCRIBE towns;

SHOW recyclebin;

--5.	Now remove table TOWNS so that does NOT remain in the recycle bin. 
-- Check that is really NOT there and then try to restore it. Explain what happened?

DROP TABLE towns PURGE;

SHOW recyclebin;

FLASHBACK TABLE towns TO BEFORE DROP;

-- The table can't be restored because it is not in recycle bin.

--6. Create simple view called CAN_CITY_VU, based on table CITIES so that will contain 
-- only columns Street_Address, Postal_Code, City and State_Province for locations only in CANADA. 
-- Then display all data from this view.

CREATE VIEW can_city_vu AS
    ( SELECT
        street_address,
        postal_code,
        city,
        state_province
    FROM
        cities
    WHERE
        country_id LIKE 'CA'
    );

SELECT
    *
FROM
    can_city_vu;

--7.	Modify your simple view so that will have following aliases instead of original column names: 
-- Str_Adr, P_Code, City and Prov and also will include cities from ITALY as well. 
-- Then display all data from this view. 

CREATE OR REPLACE VIEW can_city_vu AS
    ( SELECT
        street_address   AS "Str_Adr",
        postal_code      AS "P_Code",
        city             AS "City",
        state_province   AS "Prov"
    FROM
        cities
    WHERE
        country_id IN (
            'CA',
            'IT'
        )
    );

SELECT
    *
FROM
    can_city_vu;

--8.	Create complex view called CITY_DNAME_VU, based on tables LOCATIONS and DEPARTMENTS, so that will contain only columns 
--Department_Name, City and State_Province for locations in ITALY or CANADA. 
--Include situations even when city does NOT have department established yet. Then display all data from this view.

CREATE VIEW city_dname_vu AS
    ( SELECT
        city,
        state_province,
        department_name
    FROM
        locations
        FULL JOIN departments USING ( location_id )
    WHERE
        country_id IN (
            'CA',
            'IT'
        )
    );

SELECT
    *
FROM
    city_dname_vu;

--9.	Modify your complex view so that will have following aliases instead of original column names: 
--DName, City and Prov and also will include all cities outside United States 
--Include situations even when city does NOT have department established yet. Then display all data from this view.

CREATE OR REPLACE VIEW city_dname_vu AS
    ( SELECT
        city              AS "City",
        state_province    AS "Prov",
        department_name   AS "DName"
    FROM
        locations
        FULL JOIN departments USING ( location_id )
    WHERE
        country_id NOT IN (
            'US'
        )
    );

SELECT
    *
FROM
    city_dname_vu;

--10.	Check in the Data Dictionary what Views (their names and definitions) are created so far in your account. 
-- Then drop your CITY_DNAME_VU and check Data Dictionary again. What is different?

SELECT
    view_name
FROM
    user_views;

DROP VIEW city_dname_vu;

SELECT
    view_name
FROM
    user_views;

--CITY_DNAME_VU is not in user_views anymore.