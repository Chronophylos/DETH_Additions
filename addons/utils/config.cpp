#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {QGVAR(OnewayTeleporter)};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"dta_main", "ace_interact_menu", "A3_Modules_F"};
        author = "Chronophylos";
        authors[] = {"Chronophylos"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
