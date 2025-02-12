#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"dta_main"};
        author = "Chronophylos";
        authors[] = {"Chronophylos"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
