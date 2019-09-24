REM (Run it before executing Create Views.sql)
-- Third file. Create function for parametrized views 

--****
CREATE OR REPLACE PACKAGE BODY pkg_param_manager AS
--
PROCEDURE set_propid(p_propid jwproperty.propertyid%TYPE)
AS
BEGIN
    pkg_global_propid.g_propid := p_propid;
END;
FUNCTION get_propid return jwproperty.propertyid%TYPE
IS 
BEGIN
    RETURN pkg_global_propid.g_propid;
END;
--
procedure set_year(p_year jwproperty.datesold%TYPE)
AS
BEGIN
    pkg_global_propid.g_year := p_year;
END;
function get_year RETURN jwproperty.datesold%TYPE
IS
BEGIN
    RETURN pkg_global_propid.g_year;
END;
--
END pkg_param_manager;
--****

--END OF FILE--
