#include "script_component.hpp"

private _isAntistasiLoaded = isClass (configFile >> "CfgPatches" >> "A3A_ultimate");

if (_isAntistasiLoaded) then {
    [FUNC(antistasi), 10, []] call CBA_fnc_addPerFrameHandler;
};
