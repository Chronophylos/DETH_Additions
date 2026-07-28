#include "script_component.hpp"
/*
 * Author: Chronophylos
 * Flags a newly initialized rebel vehicle when the auto flag setting is on.
 * Hooked to Antistasi's AIVehInit event, which fires for every vehicle that
 * passes through A3A_fnc_AIVEHinit: garage placements, bought vehicles, and
 * AI-created rebel vehicles.
 *
 * The event is local to whichever machine spawned the vehicle, usually a
 * client. applyFlag forwards to the server, so the server stays the single
 * writer.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Side <SIDE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle, teamPlayer] call DTA_flags_fnc_handleVehicleInit
 */

params ["_vehicle", "_side"];

if (!GVAR(autoFlag)) exitWith {};

if (isNull _vehicle) exitWith {
    TRACE_1("handleVehicleInit called with invalid vehicle",_vehicle);
};

// teamPlayer is Antistasi's rebel side, enemy and civilian vehicles stay unflagged
if (_side isNotEqualTo teamPlayer) exitWith {};

// same classes the ACE actions and the killed handler cover, which keeps
// statics, crates and other AIVehInit subjects out
private _isVehicle = _vehicle isKindOf "Car"
    || {_vehicle isKindOf "Tank"}
    || {_vehicle isKindOf "Helicopter"}
    || {_vehicle isKindOf "Plane"}
    || {_vehicle isKindOf "Ship_F"};

if (!_isVehicle) exitWith {
    TRACE_1("Not a flaggable vehicle",_vehicle);
};

TRACE_2("Auto flagging vehicle",_vehicle,_side);

[_vehicle] call FUNC(applyFlag);
