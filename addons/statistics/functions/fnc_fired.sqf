#include "script_component.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

if (!isServer) exitWith {};
if (!isPlayer _unit) exitWith {};

private _hashes = [
    [
        ["player_name", name _unit],
        ["player_uid", getPlayerUID _unit],
        ["weapon", _weapon],
        ["muzzle", _muzzle],
        ["mode", _mode],
        ["ammo", _ammo],
        ["magazine", _magazine]
    ],
    [
        ["muzzle_velocity", velocity _projectile]
    ]
];

TRACE_1("Player fired",_hashes);
["playerFired", _hashes] call CBA_fnc_serverEvent;
