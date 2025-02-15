#include "script_component.hpp"

params ["_unit", "_corpse"];

if (!isServer) exitWith {};
if (!isPlayer _unit) exitWith {};

private _tags = [
    ["player_name", name _unit],
    ["player_uid", getPlayerUID _unit]
];
private _fields = [
    ["count", 1]
];

private _hashes = [
    _tags,
    _fields
];

TRACE_1("Respawned",_hashes);
["respawned", _hashes] call CBA_fnc_serverEvent;
