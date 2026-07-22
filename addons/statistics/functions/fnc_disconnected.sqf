#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];

private _hashes = [
    [
        ["session_id", GVAR(sessionId)],
        ["player_name", _name],
        ["player_uid", _uid],
        ["jip", _jip]
    ],
    [
        ["status", "disconnected"]
    ]
];

TRACE_1("Player disconnected",_hashes);
[QGVAR(connection), _hashes] call CBA_fnc_serverEvent;

