#include "script_component.hpp"
/*
 * Author: Chronophylos
 * Applies the configured vehicle color to a vehicle and remembers its original
 * texture. Clients forward the request to the server so there is a single writer
 * and the color survives the requesting player disconnecting.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call DTA_flags_fnc_applyTexture
 */

params ["_target"];

if (isNull _target) exitWith {
    WARNING("applyTexture called with invalid target");
};

if (!isServer) exitWith {
    [QGVAR(applyTexture), [_target]] call CBA_fnc_serverEvent;
};

// two requests racing must not overwrite the remembered texture with our own
if ([_target] call FUNC(hasTexture)) exitWith {
    TRACE_1("Texture already applied",_target);
};

private _texture = GVAR(vehicleColor) call BIS_fnc_colorRGBAtoTexture;

TRACE_2("Applying texture",_target,_texture);

// vehicles without hidden selections report no textures, an empty string
// restores the config default on reset
private _oldTexture = getObjectTextures _target param [0, ""];
SETPVAR(_target,GVAR(oldTexture),_oldTexture);

_target setObjectTextureGlobal [0, _texture];
