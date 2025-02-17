#include "script_component.hpp"

if (!isServer) exitWith {};

private _sessionId = missionNamespace getVariable "sessionId";
if (isNil "_sessionId") then {
    _sessionId = hashValue systemTime;
    missionNamespace setVariable ["sessionId", _sessionId];
};

private _hashes = [
    [],
    [
        ["session_id", _sessionId],
    ]
];

TRACE_1("Session info", _hashes);
[QGVAR(session), _hashes] call CBA_fnc_serverEvent;
