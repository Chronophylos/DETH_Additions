#include "script_component.hpp"

if (!isServer) exitWith {};

private _hashes = [
    [
        ["session_id", GVAR(sessionId)]
    ],
    [
        ["running", true]
    ]
];


TRACE_1("Session info",_hashes);
[QGVAR(session), _hashes] call CBA_fnc_serverEvent;
