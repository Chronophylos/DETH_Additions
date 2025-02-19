#include "script_component.hpp"

if (!isServer) exitWith {};

if (isNil QGVAR(sessionId)) then {
    GVAR(sessionId) = hashValue systemTime;
};

private _hashes = [
    [],
    [
        ["session_id", GVAR(sessionId)]
    ]
];


TRACE_1("Session info",_hashes);
[QGVAR(session), _hashes] call CBA_fnc_serverEvent;
