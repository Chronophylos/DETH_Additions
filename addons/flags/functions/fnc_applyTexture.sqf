#include "script_component.hpp"

params ["_target"];

// make sure the code runs in scheduled environment
if (!canSuspend) exitWith {
    TRACE_2("applyTexture called in unscheduled environment",_target,_saveOldTexture);
    [_target, _saveOldTexture] spawn FUNC(applyTexture);
};

private _color = GVAR(vehicleColor);
private _texture = _color call BIS_fnc_colorRGBAtoTexture;

TRACE_3("Applying texture",_target,_texture,_saveOldTexture);

private _oldTexture = getObjectTextures _target select 0;
SETPVAR(_target,GVAR(oldTexture),_oldTexture);

_target setObjectTextureGlobal [0, _texture];

GVAR(coloredVehicles) pushBack _target;
