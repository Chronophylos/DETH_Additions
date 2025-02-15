#include "script_component.hpp"

params ["_unit", "_killer", "_instigator", "_useEffects"];

if (!isServer) exitWith {};
if (!isPlayer _killer) exitWith {};

private _hashes = [
    [
        ["player_name", name _killer],
        ["player_uid", getPlayerUID _killer],
        ["unit", name _unit]
    ],
    [
        ['count', 1]
    ]
];

TRACE_1("Player kill",_hashes);
["playerKill", _hashes] call CBA_fnc_serverEvent;
