#include "script_component.hpp"
/*
 * Author: Chronophylos
 * Re-applies the configured vehicle color to every currently colored vehicle.
 * Server only. setObjectTextureGlobal has a global effect, so one pass here
 * reaches every client. The list is derived from the public oldTexture variable
 * instead of a tracking array so it stays correct when the player who applied
 * the color disconnects.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call DTA_flags_fnc_refreshTextures
 */

if (!isServer) exitWith {};

private _texture = GVAR(vehicleColor) call BIS_fnc_colorRGBAtoTexture;
private _colored = vehicles select {[_x] call FUNC(hasTexture)};

TRACE_2("Refreshing textures",_texture,count _colored);

{
    _x setObjectTextureGlobal [0, _texture];
} forEach _colored;
