#include "script_component.hpp"

params ["_target"];

// make sure the code runs in scheduled environment
if (!canSuspend) exitWith {
    TRACE_1("resetTexture called in unscheduled environment",_target);
    _this spawn FUNC(resetTexture);
};

private _oldTexture = GETVAR(_target,GVAR(oldTexture),nil);

if (isNil "_oldTexture") exitWith {
    WARNING("No old texture found");
};

TRACE_2("Resetting texture",_target,_oldTexture);

_target setObjectTextureGlobal [0, _oldTexture];

SETVAR(_target,GVAR(oldTexture),nil);

GVAR(coloredVehicles) = GVAR(coloredVehicles) - [_target];
