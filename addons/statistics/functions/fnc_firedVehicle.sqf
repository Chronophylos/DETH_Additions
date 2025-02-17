#include "script_component.hpp"

//IGNORE_PRIVATE_WARNING ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle", "_gunner", "_turret"];

if (!local _gunner) exitWith {};

private _hashes = [
    [
        ["player_name", name _gunner],
        ["player_uid", getPlayerUID _gunner],
        ["vehicle", typeOf _vehicle],
        ["turret", _turret],
        ["weapon", _weapon],
        ["muzzle", _muzzle],
        ["mode", _mode],
        ["ammo", _ammo],
        ["magazine", _magazine]
    ],
    [
        ["count", 1],
        ["muzzle_velocity", velocity _projectile],
        ["position_x", getPos _vehicle select 0],
        ["position_y", getPos _vehicle select 1],
        ["position_z", getPos _vehicle select 2]
    ]
];

TRACE_1("Player fired",_hashes);
["playerFiredVehicle", _hashes] call CBA_fnc_serverEvent;
