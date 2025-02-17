#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        skipWhenMissingDependencies = 1;
        requiredAddons[] = {"dta_main", "ace_medical"};
        author = "Chronophylos";
        authors[] = {"Chronophylos"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
