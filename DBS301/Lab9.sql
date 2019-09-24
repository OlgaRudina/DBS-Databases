-- ***********************
-- Name: Olga Rudina
-- ID: 039949136
-- Date: 19-Nov-2018
-- Purpose: Lab 9 DBS301
-- ***********************

-- 1.	Create table SALESREP and load it with data from table EMPLOYEES table.
CREATE TABLE salesrep (
    repid        NUMBER(6),
    fname        VARCHAR2(20),
    lname        VARCHAR2(25),
    phone#       VARCHAR2(20),
    salary       NUMBER(8,2),
    commission   NUMBER(2,2)
);

INSERT INTO salesrep (
    repid,
    fname,
    lname,
    phone#,
    salary,
    commission
)
    SELECT
        employee_id,
        first_name,
        last_name,
        phone_number,
        salary,
        commission_pct
    FROM
        employees
    WHERE
        department_id = 80;

--2.	Create CUST table. Load the table with these values in the chart. 

CREATE TABLE cust (
    cust#       NUMBER(6),
    custname    VARCHAR2(30) NOT NULL,
    city        VARCHAR2(20) NOT NULL,
    raiting     CHAR(1),
    comments    VARCHAR2(200),
    salesrep#   NUMBER(7)
);

INSERT INTO cust (
    cust#,
    custname,
    city,
    raiting,
    salesrep#
) VALUES (
    501,
    'ABC LTD.',
    'Montreal',
    'C',
    149
);

INSERT INTO cust (
    cust#,
    custname,
    city,
    raiting,
    salesrep#
) VALUES (
    502,
    'Black Giant',
    'Ottawa',
    'B',
    174
);

INSERT INTO cust (
    cust#,
    custname,
    city,
    raiting,
    salesrep#
) VALUES (
    503,
    'Mother Goose',
    'London',
    'B',
    174
);

INSERT INTO cust (
    cust#,
    custname,
    city,
    raiting,
    salesrep#
) VALUES (
    701,
    'BLUE SKY LTD',
    'Vancouver',
    'B',
    176
);

INSERT INTO cust (
    cust#,
    custname,
    city,
    raiting,
    salesrep#
) VALUES (
    702,
    'MIKE and SAM Inc.',
    'Kingston',
    'A',
    174
);

INSERT INTO cust (
    cust#,
    custname,
    city,
    raiting,
    salesrep#
) VALUES (
    703,
    'RED PLANET',
    'Mississauga',
    'C',
    174
);

INSERT INTO cust (
    cust#,
    custname,
    city,
    raiting,
    salesrep#
) VALUES (
    717,
    'BLUE SKY LTD',
    'Regina',
    'D',
    176
);

--3.	Create table GOODCUST by using following columns but only if their 
--rating is A or B. 

CREATE TABLE goodcust (
    custid       NUMBER(6),
    "Name"       VARCHAR2(30),
    "Location"   VARCHAR2(20),
    repid        NUMBER(7)
);

INSERT INTO goodcust (
    custid,
    "Name",
    "Location",
    repid
)
    SELECT
        cust#,
        custname,
        city,
        salesrep#
    FROM
        cust
    WHERE
        raiting IN (
            'A',
            'B'
        );

-- 4. add new column to table SALESREP called JobCode 

ALTER TABLE salesrep ADD jobcode VARCHAR2(12);

DESC salesrep;

-- 5. Declare column Salary in table SALESREP as mandatory one and 
-- Column Location in table GOODCUST as optional one.

ALTER TABLE salesrep MODIFY (
    salary NOT NULL
);

ALTER TABLE goodcust MODIFY (
    "Location" NULL
);

--6.Lengthen FNAME in SALESREP to 37. 
-- The result of a DESCRIBE should show it happening	

ALTER TABLE salesrep MODIFY
    fname VARCHAR2(37);

DESCRIBE salesrep;

SELECT
    MAX(length("Name") )
FROM
    goodcust;

ALTER TABLE goodcust MODIFY
    "Name" VARCHAR(25);

DESCRIBE goodcust;

--7.	Now get rid of the column JobCode in table SALESREP 
-- in a way that will not affect daily performance. 

ALTER TABLE salesrep SET UNUSED ( jobcode );

DESCRIBE salesrep;

--8.	Declare PK constraints in both new tables ? RepId and CustId

ALTER TABLE salesrep ADD CONSTRAINT repid_pk PRIMARY KEY ( repid );

ALTER TABLE goodcust ADD CONSTRAINT custid_pk PRIMARY KEY ( custid );

--9.	Declare UK constraints in both new tables ? Phone# and Name

ALTER TABLE salesrep ADD CONSTRAINT phone_uk UNIQUE ( phone# );

ALTER TABLE goodcust ADD CONSTRAINT goodcust_uk UNIQUE ( "Name" );

--10.	Restrict amount of Salary column to be in the range [6000, 12000] 
-- and Commission to be not more than 50%.

ALTER TABLE salesrep
    ADD CONSTRAINT salary_ck CHECK ( ( salary BETWEEN 6000 AND 12000 )
                                     AND commission < 0.5 );

--11.	Ensure that only valid RepId numbers from table SALESREP 
-- may be entered in the table GOODCUST. 
-- Why this statement has failed?

ALTER TABLE goodcust
    ADD CONSTRAINT goodcust_fk FOREIGN KEY ( repid )
        REFERENCES salesrep ( repid );

--12.	Firstly write down the values for RepId column in table GOODCUST 
-- and then make all these values blank. 
-- Now redo the question 10. Was it successful? 

SELECT
    repid
FROM
    goodcust;

UPDATE goodcust
SET
    repid = NULL;

ALTER TABLE goodcust
    ADD CONSTRAINT goodcust_fk FOREIGN KEY ( repid )
        REFERENCES salesrep ( repid );

--13.	Disable this FK constraint now and enter old values for 
-- RepId in table GOODCUST and save them. 
-- Then try to enable your FK constraint. What happened? 

ALTER TABLE goodcust DISABLE CONSTRAINT goodcust_fk;

UPDATE goodcust
SET
    repid = 201
WHERE
    custid = 501;

UPDATE goodcust
SET
    repid = 202
WHERE
    custid = 502;

UPDATE goodcust
SET
    repid = 202
WHERE
    custid = 503;

UPDATE goodcust
SET
    repid = 102
WHERE
    custid = 701;

UPDATE goodcust
SET
    repid = 107
WHERE
    custid = 702;

UPDATE goodcust
SET
    repid = 107
WHERE
    custid = 703;

UPDATE goodcust
SET
    repid = 102
WHERE
    custid = 717;

ALTER TABLE goodcust ENABLE CONSTRAINT goodcust_fk;

--14.	Get rid of this FK constraint. 
-- Then modify your CK constraint from question 9 to allow Salary 
-- amounts from 5000 to 15000.

ALTER TABLE goodcust DROP CONSTRAINT goodcust_fk;

ALTER TABLE salesrep DROP CONSTRAINT salary_ck;

ALTER TABLE salesrep
    ADD CONSTRAINT salary_ck CHECK ( salary BETWEEN 5000 AND 15000 );

--15.	Describe both new tables SALESREP and GOODCUST and then show all 
-- constraints for these two tables by running the following query:

DESCRIBE salesrep;

DESCRIBE goodcust;

SELECT
    constraint_name,
    constraint_type,
    search_condition,
    table_name
FROM
    user_constraints
WHERE
    table_name IN (
        'SALESREP',
        'GOODCUST'
    )
ORDER BY
    4,
    2;