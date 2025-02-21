#include "script_component.hpp"

params ["_target"];

// make sure the code runs in scheduled environment
if (!canSuspend) exitWith {
    TRACE_1("applyTexture called in unscheduled environment",_target);
    _this spawn FUNC(applyTexture);
};

TRACE_2("Applying texture",_target,GVAR(vehicleTexture));

private _oldTexture = getObjectTextures _target select 0;
private _oldMaterial = getObjectMaterials _target select 0;
SETPVAR(_target,GVAR(oldTexture),_oldTexture);
SETPVAR(_target,GVAR(oldMaterial),_oldMaterial);

_target setObjectMaterialGlobal [0, "\a3\data_f\default.rvmat"];
sleep 0.01;
_target setObjectTextureGlobal [0, GVAR(vehicleTexture)];
