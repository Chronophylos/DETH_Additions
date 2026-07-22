#include "script_component.hpp"

// TODO: split into multiple measurements

if (!hasInterface) exitWith {};
if (isNil QGVAR(sessionId)) exitWith {};

private _unit = ACE_player;
if (isNull _unit || {!isPlayer _unit}) exitWith {};

private _fields = [
    ["rank_name", rank _unit],
    ["rank_index", [_unit] call A3A_fnc_numericRank select 0],
    ["is_undercover", (captive _unit) && {!(_unit getVariable ["incapacitated", false])}]
];

if (!isNil {_unit getVariable "moneyX"}) then { _fields pushBack ["money", _unit getVariable "moneyX"] };
if (!isNil {_unit getVariable "isAFK"}) then { _fields pushBack ["is_afk", _unit getVariable ["isAFK", false]] };

private _hashes = [
    [
        ["session_id", GVAR(sessionId)],
        ["player_name", name _unit],
        ["player_uid", getPlayerUID _unit]
    ],
    _fields
];

TRACE_1("Antistasi player update",_hashes);
[QGVAR(antistasiPlayer), _hashes] call CBA_fnc_serverEvent;
