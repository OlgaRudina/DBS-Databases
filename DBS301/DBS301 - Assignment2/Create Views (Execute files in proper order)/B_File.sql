REM (Run it before executing Create Views.sql and C_File.sql)
-- Second file. Create function for parametrized views.

--****
CREATE OR REPLACE PACKAGE pkg_param_manager AS
    PROCEDURE set_propid(p_propid jwproperty.propertyid%TYPE);
    FUNCTION get_propid RETURN jwproperty.propertyid%TYPE;
    PROCEDURE set_year(p_year jwproperty.datesold%TYPE);
    FUNCTION get_year RETURN jwproperty.datesold%TYPE;
END pkg_param_manager;
--****

--END OF FILE--