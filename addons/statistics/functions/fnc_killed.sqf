#include "script_component.hpp"

params ["_unit", "_killer", "_instigator", "_useEffects"];

if (!isServer) exitWith {};

if (isPlayer unit) exitWith {
    _hashes = [
        ["tags", [
            ["playerName", name _unit],
            ["playerUID", getPlayerUID _unit]
        ]],
        ["fields", [
            ["killer", name _killer],
            ["instigator", name _instigator]
        ]]
    ];

    ["playerDeath", _hashes] call CBA_fnc_serverEvent;
};

if (isPlayer _killer) exitWith {
    _hashes = [
        ["tags", [
            ["playerName", name _killer],
            ["playerUID", getPlayerUID _unit]
        ]],
        ["fields", [
            ["unit", name _unit],
            ["instigator", name _instigator]
        ]]
    ];

    ["playerKill", _hashes] call CBA_fnc_serverEvent;
};
