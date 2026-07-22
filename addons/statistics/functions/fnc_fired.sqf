#include "script_component.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

if (isNil QGVAR(sessionId)) exitWith {};
if (!local _unit) exitWith {};

private _velocity = velocity _projectile;
private _position = getPos _unit;
private _hashes = [
    [
        ["session_id", GVAR(sessionId)],
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
        ["muzzle_velocity_x", _velocity select 0],
        ["muzzle_velocity_y", _velocity select 1],
        ["muzzle_velocity_z", _velocity select 2],
        ["position_x", _position select 0],
        ["position_y", _position select 1],
        ["position_z", _position select 2]
    ]
];

TRACE_1("Player fired",_hashes);
[QGVAR(fired), _hashes] call CBA_fnc_serverEvent;
