#include "script_component.hpp"

private _isAntistasiLoaded = isClass (configFile >> "CfgPatches" >> "A3A_ultimate");

if (_isAntistasiLoaded) then {
    INFO("Antistasi detected");
    [{!isNil "A3A_startupState" && A3A_startupState isEqualTo "completed"}, {
        LOG("Antistasi startup complete, adding per frame handler");
        [FUNC(antistasi), 10, []] call CBA_fnc_addPerFrameHandler;
    }] call CBA_fnc_waitUntilAndExecute;
};

[FUNC(score), 10, []] call CBA_fnc_addPerFrameHandler;
