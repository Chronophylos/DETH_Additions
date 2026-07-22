#include "script_component.hpp"
/*
 * Author: Chronophylos
 * Handles vehicle destroyed event to remove flags and textures
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Killer <OBJECT>
 * 2: Instigator <OBJECT>
 * 3: Use Effects <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle, _killer, _instigator, _useEffects] call DTA_flags_fnc_handleVehicleKilled
 */

params ["_vehicle", "_killer", "_instigator", "_useEffects"];

if (isNull _vehicle) exitWith {
    TRACE_1("No valid vehicle found",_vehicle);
};

// Prefer engine/public state over machine-local tracking arrays (applier may have disconnected)
if (getForcedFlagTexture _vehicle isNotEqualTo "") then {
    [_vehicle] call FUNC(resetFlag);
};

private _oldTexture = GETVAR(_vehicle,GVAR(oldTexture),nil);
if (!isNil "_oldTexture") then {
    [_vehicle] call FUNC(resetTexture);
};
