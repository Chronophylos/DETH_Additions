#include "script_component.hpp"

params ["_target"];

// make sure the code runs in scheduled environment
if (!canSuspend) exitWith {
    TRACE_1("resetTexture called in unscheduled environment",_target);
    _this spawn FUNC(resetTexture);
};

private _oldTexture = GETVAR(_target,GVAR(oldTexture),nil);
private _oldMaterial = GETVAR(_target,GVAR(oldMaterial),nil);

if (isNil "_oldTexture" || isNil "_oldMaterial") exitWith {
    WARNING("No old textures or material found");
};

TRACE_2("Resetting texture",_target,_oldTexture);

_target setObjectMaterialGlobal [0, _oldMaterial];
sleep 0.01;
_target setObjectTextureGlobal [0, _oldTexture];

SETVAR(_target,GVAR(oldTexture),nil);
SETVAR(_target,GVAR(oldMaterial),nil);
