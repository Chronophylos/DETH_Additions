#include "script_component.hpp"

if (!isServer) exitWith {};

{
    private _scores = getPlayerScores _x;
    if (count _scores == 0) exitWith {};

    private _hashes = [
        [
            ["player_name", name _x],
            ["player_uid", getPlayerUID _x]
        ],
        [
            ["infantry", _scores select 0],
            ["vehicles", _scores select 1],
            ["armor", _scores select 2],
            ["air", _scores select 3],
            ["deaths", _scores select 4],
            ["total", _scores select 5]
        ]
    ];

    TRACE_1("Score",_hashes);
    [QGVAR(score), _hashes] call CBA_fnc_serverEvent;
} forEach call CBA_fnc_players;
