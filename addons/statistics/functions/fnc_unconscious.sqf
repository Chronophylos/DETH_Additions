#include "script_component.hpp"

/*
 * Author: Chronophylos
 * Handles unconscious state changes for statistics tracking
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Unconscious State <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, true] call DTA_statistics_fnc_unconscious
 */

params ["_unit", "_unconsciousState"];

private _hashes = [
    [
        ["player_name", name _unit],
        ["player_uid", getPlayerUID _unit]
    ],
    [
        ["unconscious", _unconsciousState],
        ["position_x", getPos _unit select 0],
        ["position_y", getPos _unit select 1],
        ["position_z", getPos _unit select 2]
    ]
];

TRACE_1("Player unconscious",_hashes);
[QGVAR(unconscious), _hashes] call CBA_fnc_serverEvent;
