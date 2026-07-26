#include "script_component.hpp"
/*
 * Author: Chronophylos
 * Removes a forced flag texture from a vehicle. Clients forward the request to
 * the server so there is a single writer.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call DTA_flags_fnc_resetFlag
 */

params ["_target"];

if (isNull _target) exitWith {
    WARNING("resetFlag called with invalid target");
};

if (!isServer) exitWith {
    [QGVAR(resetFlag), [_target]] call CBA_fnc_serverEvent;
};

TRACE_1("Resetting flag",_target);

_target forceFlagTexture "";
