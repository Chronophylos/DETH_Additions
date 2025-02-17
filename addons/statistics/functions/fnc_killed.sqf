#include "script_component.hpp"

params ["_unit", "_killer", "_instigator", "_useEffects"];

if (!isServer) exitWith {};
if (!isPlayer _killer) exitWith {};

private _targetUID = getPlayerUID _unit;
if (_targetUID isEqualTo "") then {
    _targetUID = "unknown";
};

private _isPVP = isPlayer _unit;
private _isSuicide = _killer isEqualTo _unit;
private _isTeamKill = side _killer isEqualTo side _unit;

private _hashes = [
    [
        ["player_name", name _killer],
        ["player_uid", getPlayerUID _killer],
        ["target_name", name _unit],
        ["target_uid", _targetUID],
        ["isPVP", _isPVP],
        ["isSuicide", _isSuicide],
        ["isTeamKill", _isTeamKill]
    ],
    [
        ["count", 1],
        ["position_x", getPos _unit select 0],
        ["position_y", getPos _unit select 1],
        ["position_z", getPos _unit select 2]
    ]
];

TRACE_1("Player kill",_hashes);
["playerKill", _hashes] call CBA_fnc_serverEvent;
