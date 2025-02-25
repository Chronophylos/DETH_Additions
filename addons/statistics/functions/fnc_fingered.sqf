#include "script_component.hpp"
/*
 * Author: Your Name
 * Handles the ace_finger_fingered event and records measurements when the source is ACE_player
 *
 * Arguments:
 * 0: Source Unit (can be self) <OBJECT>
 * 1: Position being pointed at (ASL) <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, [0, 0, 0]] call DTA_statistics_fnc_fingered
 *
 * Public: No
 */

params ["_sourceUnit", "_pointPosition"];

if (!local _sourceUnit) exitWith {};
if (_sourceUnit isNotEqualTo ACE_player) exitWith {};

// Format data as hashes to match other statistics functions
private _hashes = [
    [
        ["player_name", name _sourceUnit],
        ["player_uid", getPlayerUID _sourceUnit]
    ],
    [
        ["count", 1],
        ["position_x", _pointPosition select 0],
        ["position_y", _pointPosition select 1],
        ["position_z", _pointPosition select 2]
    ]
];

TRACE_1("Player finger pointed",_hashes);
[QGVAR(fingered), _hashes] call CBA_fnc_serverEvent;
