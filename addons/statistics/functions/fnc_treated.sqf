#include "script_component.hpp"

params ["_caller", "_target", "_bodyPart", "_treatment", "_itemUser", "_usedItem", "_createLitter"];

if (!isPlayer _caller) exitWith {};

private _targetUID = getPlayerUID _target;
if (_targetUID == "") then {
    _targetUID = "unknown";
};

private _hashes = [
    [
        ["player_name", name _caller],
        ["player_uid", getPlayerUID _caller],
        ["target_name", name _target],
        ["target_uid", _targetUID],
        ["body_part", _bodyPart]
    ],
    [
        ["treatment", _treatment],
        ["used_item", _usedItem]
    ]
];

TRACE_1("Treated",_hashes);
[QGVAR(treated), _hashes] call CBA_fnc_serverEvent;
