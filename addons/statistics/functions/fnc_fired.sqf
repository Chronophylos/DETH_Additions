#include "script_component.hpp"

if (!isServer) exitWith {};

//IGNORE_PRIVATE_WARNING ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle", "_gunner", "_turret"];

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
        ["count", 1],
        ["muzzle_velocity", velocity _projectile],
        ["position_x", getPos _unit select 0],
        ["position_y", getPos _unit select 1],
        ["position_z", getPos _unit select 2]
    ]
];

TRACE_1("Player fired",_hashes);
[QGVAR(fired), _hashes] call CBA_fnc_serverEvent;
