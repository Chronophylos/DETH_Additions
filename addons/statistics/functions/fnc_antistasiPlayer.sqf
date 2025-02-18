#include "script_component.hpp"

// TODO: split into multiple measurements

if (!isServer) exitWith {};

private _players = CBA_fnc_players;

TRACE_1("Antistasi player update",_players);

{
    private _fields = [
        ["rank_name", rank _x],
        ["rank_index", [_x] call A3A_fnc_numericRank select 0],
        ["is_undercover", (captive _x) && {!(_x getVariable ["incapacitated", false])}]
    ];

    // Player stats - combine checks and pushBack in one step
    if (!isNil {_x getVariable "moneyX"}) then { _fields pushBack ["money", _x getVariable "moneyX"] };
    if (!isNil {_x getVariable "isAFK"}) then { _fields pushBack ["is_afk", _x getVariable ["isAFK", false]] };

    private _hashes = [
        [
            ["player_name", name _x],
            ["player_uid", getPlayerUID _x]
        ],
        _fields
    ];

    TRACE_1("Antistasi player update",_hashes);
    [QGVAR(antistasiPlayer), _hashes] call CBA_fnc_serverEvent;
} forEach _players;
