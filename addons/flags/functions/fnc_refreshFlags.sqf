#include "script_component.hpp"
/*
 * Author: Chronophylos
 * Re-applies the configured flag texture to every currently flagged vehicle.
 * Server only. forceFlagTexture has a global effect, so one pass here reaches
 * every client. The list is derived from engine state instead of a tracking
 * array so it stays correct when the player who applied the flag disconnects.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call DTA_flags_fnc_refreshFlags
 */

if (!isServer) exitWith {};

private _texture = call FUNC(getFlagTexture);

if (_texture isEqualTo "") exitWith {
    WARNING("No flag texture available, keeping current flags");
};

private _flagged = vehicles select {[_x] call FUNC(hasFlag)};

TRACE_2("Refreshing flags",_texture,count _flagged);

{
    _x forceFlagTexture _texture;
} forEach _flagged;
