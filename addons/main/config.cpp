#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_main", "ace_main"};
        author = "Chronophylos";
        authors[] = { "Chronophylos" };
        url = CSTRING(URL);
        VERSION_CONFIG;
    };
};

class CfgMods {
    class PREFIX {
        dir = "@deth_additions";
        name = "DETH Additions";
        picture = "A3\Ui_f\data\Logos\arma3_expansion_alpha_ca";
        hidePicture = "true";
        hideName = "true";
    };
};

#include "CfgSettings.hpp"
#include "CfgModuleCategories.hpp"
