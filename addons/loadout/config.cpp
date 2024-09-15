class CfgPatches
{
    class dta_loadout
    {
        name = "DETH Additions - Loadout";
        author = "Chronophylos";
        requiredVersion = 1.0;
        units[] = { "dta_ModuleCreateLoadout", "dta_ModuleApplyLoadout" };
        requiredAddons[] = { "A3_Modules_F" };
    };
};

class CfgFactionClasses
{
    class NO_CATEGORY;
    class dta_loadout: NO_CATEGORY
    {
        displayName = "DETH Additions - Loadout";
    };
};

#include "CfgVehicles.hpp"
#include "CfgFunctions.hpp"