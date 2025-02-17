#include "script_component.hpp"

if (!isServer) exitWith {};

//IGNORE_PRIVATE_WARNING ["_unit, _state(BOOL)"];

private _hashes = [
    [
        ["player_name", name _unit],
        ["player_uid", getPlayerUID _unit]
    ],
    [
        ["unconscious", _state],
        ["position_x", getPos _unit select 0],
        ["position_y", getPos _unit select 1],
        ["position_z", getPos _unit select 2]
    ]
];

TRACE_1("Player unconscious",_hashes);
["playerUnconscious", _hashes] call CBA_fnc_serverEvent;
