--Create VIews File 

SET FEEDBACK ON;
SET SERVEROUTPUT ON;

-- View 2 - client list including current clients and past clients,
-- who already bought property 
CREATE OR REPLACE VIEW CLIENT_LIST AS (
      SELECT clientid AS "Client#",
        firstname || ' ' || lastname AS "Client Name",
        phonenumber AS "Phone#",
        email AS "E-mail",
        propertytype AS "Property Type"
            FROM jwclientinfo
                JOIN jwpropclient USING (clientid)
                JOIN jwproperty USING (propertyid)
                JOIN jwpropertycategory USING(categoryid)
);


-- View 3 - information about all properies,
-- sold and currently for sale    
CREATE OR REPLACE VIEW PROPERTIES AS (
    SELECT propertyid AS "Property#",
        landsize || ' sq ft' AS "Land Size",
        maintenancefee AS "Maintenance Fee",
        street AS "Street",
        province AS "Province",
        postalcode AS "Postal Code",
        COALESCE(to_char(dateSold), ' ') AS "Sold on"
            FROM jwproperty
            JOIN jwpropertycategory USING (categoryid)
            JOIN jwaddresses USING (addressid)
);



-- View 4 - total sale for inserted year 
CREATE OR REPLACE VIEW ANNUAL_SALE AS (
    SELECT COALESCE(to_char(SUM(price), '$999,999,999'), '$0') AS "Income for selected year"
    FROM jwpropertyparameters
        JOIN jwproperty USING(propertyparametersid)
    WHERE EXTRACT(YEAR FROM dateSold) = coalesce(to_char(extract(year from pkg_param_manager.get_year)), to_char(dateSold))
);


-- View 5 - detaled information for selected year TODO
CREATE OR REPLACE VIEW SalesByYear AS(
SELECT propertyid AS "Property#",
    city AS "City",
    province AS "Province",
    postalcode AS "Postal Code",
    price AS "Price",
    dateSold AS "Sale date"
        FROM jwproperty
        JOIN jwaddresses USING (addressid)
        JOIN jwpropertyparameters USING (propertyparametersid)
    WHERE EXTRACT(YEAR FROM dateSold) = coalesce(to_char(extract(year from pkg_param_manager.get_year)), to_char(dateSold))
);
    
    
-- View 6 - Show information about all schools by property id
CREATE OR REPLACE VIEW SchooldByPropertyId AS (
SELECT COALESCE(to_char(schoolid), '-') AS "School ID",
    COALESCE(to_char(schooltype), '-') AS "School type",
    COALESCE(to_char(schoolname), '-') AS "School name",
    COALESCE(to_char(areaname), '-') AS "Area name",
    COALESCE(to_char(propertyid), '-') AS "Property ID"
FROM jwproperty
    JOIN jwaddresses USING(addressid)
    LEFT OUTER JOIN jwareas USING(areaid)
    FULL OUTER JOIN jwschools USING(areaid)
    WHERE propertyid = coalesce(pkg_param_manager.get_propid, propertyid)
);


-- View 7 -  Shows date when Advertising has been posted and Advertising type  
CREATE OR REPLACE VIEW ADVERTISING AS ( 
    SELECT advertisingid AS "Advertising#",     
        outlettype AS "Outlet Type", 
        to_date(dateposted, 'DD-MM-YYYY') AS "Date Posted", 
        ownername AS "Owner Name", 
        ownerphonenumber AS "Phone Number", 
        to_char(price, '$999,999,999') AS "Price" 
            FROM jwadvertising 
            LEFT JOIN jwbridge_ad_outlet USING (advertisingid) 
            FULL JOIN jwadvertisingoutlet USING (outletid) 
); 


--VIEWS TESTING 
------------------------------------------

-- testing view 1 (SELLERS_PRICING_LIST)

--SELECT * FROM SELLERS_PRICING_LIST
--    ORDER BY "Price" DESC;

-- testing view 2 (CLIENT_LIST)

--SELECT * FROM CLIENT_LIST
--    ORDER BY "Client#";

-- testing view 3 (PROPERTIES)
--SELECT * FROM PROPERTIES
--    ORDER BY "Sold on" DESC;

-- testing view 4

--EXEC pkg_param_manager.set_year(to_date(2018, 'YYYY'));
--SELECT * FROM annual_sale;

--EXEC pkg_param_manager.set_year(to_date(2017, 'YYYY'));
--SELECT * FROM annual_sale;

-- testing view 5


--EXEC pkg_param_manager.set_year(to_date(2018, 'YYYY'));
--SELECT * FROM SalesByYear;

--EXEC pkg_param_manager.set_year(to_date(2017, 'YYYY'));
--SELECT * FROM SalesByYear;


-- testing view 6 (SchooldByPropertyId)

--EXEC pkg_param_manager.set_propid(2870);
--SELECT * FROM SchooldByPropertyId;

--EXEC pkg_param_manager.set_propid(2883);
--SELECT * FROM SchooldByPropertyId;

-- testing view 7 (Advertising)

--SELECT * FROM ADVERTISING order by "Outlet Type";


--END OF FILE--