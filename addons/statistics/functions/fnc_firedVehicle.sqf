#include "script_component.hpp"

//IGNORE_PRIVATE_WARNING ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle", "_gunner", "_turret"];

if (!isServer) exitWith {};

private _velocity = velocity _projectile;
private _position = getPos _vehicle;
private _hashes = [
    [
        ["session_id", GVAR(sessionId)],
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
        ["muzzle_velocity_x", _velocity select 0],
        ["muzzle_velocity_y", _velocity select 1],
        ["muzzle_velocity_z", _velocity select 2],
        ["position_x", _position select 0],
        ["position_y", _position select 1],
        ["position_z", _position select 2]
    ]
];

TRACE_1("Player fired",_hashes);
[QGVAR(firedVehicle), _hashes] call CBA_fnc_serverEvent;
