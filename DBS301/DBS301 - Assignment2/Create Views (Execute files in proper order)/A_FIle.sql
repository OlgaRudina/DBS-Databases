REM (Run it before executing Create Views.sql,B_File.sql and C_File.sql)
-- First file. Create function for parametrized views.

--****
CREATE OR REPLACE PACKAGE pkg_global_propid AS
    g_propid jwproperty.propertyid%type;
    g_year jwproperty.datesold%type;
END pkg_global_propid;
--****

--END OF FILE--