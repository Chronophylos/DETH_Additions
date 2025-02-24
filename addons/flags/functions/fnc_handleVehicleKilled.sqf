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

// Skip if no valid vehicle
if (isNull _vehicle) exitWith {
    TRACE_1("No valid vehicle found",_vehicle);
};

// Remove flag if present
if (_vehicle in GVAR(flaggedVehicles)) then {
    [_vehicle] call FUNC(resetFlag);
};

// Remove texture if present
if (_vehicle in GVAR(coloredVehicles)) then {
    [_vehicle] call FUNC(resetTexture);
};
