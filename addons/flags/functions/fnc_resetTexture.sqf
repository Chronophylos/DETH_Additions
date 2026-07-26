#include "script_component.hpp"
/*
 * Author: Chronophylos
 * Restores a vehicle's original texture. Clients forward the request to the
 * server so there is a single writer.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call DTA_flags_fnc_resetTexture
 */

params ["_target"];

if (isNull _target) exitWith {
    WARNING("resetTexture called with invalid target");
};

if (!isServer) exitWith {
    [QGVAR(resetTexture), [_target]] call CBA_fnc_serverEvent;
};

private _oldTexture = GETVAR(_target,GVAR(oldTexture),nil);

// benign when two requests race, the first one already restored the texture
if (isNil "_oldTexture") exitWith {
    TRACE_1("No old texture found",_target);
};

TRACE_2("Resetting texture",_target,_oldTexture);

_target setObjectTextureGlobal [0, _oldTexture];

SETPVAR(_target,GVAR(oldTexture),nil);
