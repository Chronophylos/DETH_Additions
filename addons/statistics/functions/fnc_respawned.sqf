#include "script_component.hpp"

params ["_unit", "_corpse"];

if (!isServer) exitWith {};
if (!isPlayer _unit) exitWith {};

private _hashes = [
    [
        ["player_name", name _unit],
        ["player_uid", getPlayerUID _unit]
    ],
    [
        ["count", 1]
    ]
];

TRACE_1("Respawned",_hashes);
["playerRespawned", _hashes] call CBA_fnc_serverEvent;
