#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {};
        author = "Chronophylos";
        authors[] = {"Chronophylos"};
        url = ECSTRING(main,URL);
    };
};

#include "CfgEventHandlers.hpp"
