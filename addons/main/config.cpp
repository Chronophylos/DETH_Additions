#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main"};
        author = "Chronophylos";
        VERSION_CONFIG;
    };
};

class CfgMods {
    class PREFIX {
        dir = "@deth_additions";
        name = "DETH Additions";
    };
};