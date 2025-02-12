#include "script_component.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile"];

if (!isServer) exitWith {};
if (!isPlayer unit) exitWith {};

_hashes = [
    ["tags", [
        ["playerName", name _unit],
        ["playerUID", getPlayerUID _unit]
    ]],
    ["fields", [
        ["weapon", _weapon],
        ["muzzle", _muzzle],
        ["mode", _mode],
        ["ammo", _ammo],
        ["magazine", _magazine]
    ]]
];

["playerStats", _hashes] call CBA_fnc_serverEvent;
