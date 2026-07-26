#include "script_component.hpp"
/*
 * Author: Chronophylos
 * Applies the configured flag texture to a vehicle. Clients forward the request
 * to the server so there is a single writer and the flag survives the requesting
 * player disconnecting.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call DTA_flags_fnc_applyFlag
 */

params ["_target"];

if (isNull _target) exitWith {
    WARNING("applyFlag called with invalid target");
};

if (!isServer) exitWith {
    [QGVAR(applyFlag), [_target]] call CBA_fnc_serverEvent;
};

TRACE_2("Applying flag",_target,GVAR(flagTexture));

// global effect, reaches every client from here
_target forceFlagTexture GVAR(flagTexture);
