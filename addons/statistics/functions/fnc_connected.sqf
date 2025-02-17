#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

if (_name isEqualTo "__SERVER__") exitWith {};

private _hashes = [
    [
        ["player_name", _name],
        ["player_uid", _uid],
        ["jip", _jip]
    ],
    [
        ["status", "connected"]
    ]
];

TRACE_1("Player connected",_hashes);
["playerConnection", _hashes] call CBA_fnc_serverEvent;
