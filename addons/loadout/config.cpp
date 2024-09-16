#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = { QGVAR(moduleCreateLoadout) };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "A3_Modules_F" };
        author = "Chronophylos";
        VERSION_CONFIG;
    };
};

class CfgFactionClasses
{
    class NO_CATEGORY;
    class deth_additions_loadout: NO_CATEGORY
    {
        displayName = "DETH Additions - Loadout";
    };
};

#include "CfgVehicles.hpp"