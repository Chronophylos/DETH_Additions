#include "script_component.hpp"

if (!isServer) exitWith {};

private _fields = [];
private _tags = [];

// HR and Resources
private _hr = if (!isNil {server getVariable "hr"}) then { _fields pushBack ["hr", server getVariable "hr"]; server getVariable "hr" };
private _money = if (!isNil {server getVariable "resourcesFIA"}) then { _fields pushBack ["money", server getVariable "resourcesFIA"]; server getVariable "resourcesFIA" };

// Commander and Rally Point
if (!isNil "theBoss" && {!isNull theBoss}) then { _fields pushBack ["commander", name theBoss] };
if (!isNil "isRallyPointPlaced") then { _fields pushBack ["rally_point_deployed", isRallyPointPlaced] };

// War Level
if (!isNil "tierWar") then { _fields pushBack ["war_level", tierWar] };

// Rivals
if (!isNil "inactivityLevelRivals") then { _fields pushBack ["rivals_level", inactivityLevelRivals] };
if (!isNil "areRivalsEnabled") then { _fields pushBack ["rivals_enabled", areRivalsEnabled] };
if (!isNil "areRivalsDiscovered") then { _fields pushBack ["rivals_discovered", areRivalsDiscovered] };
if (!isNil "areRivalsDefeated") then { _fields pushBack ["rivals_defeated", areRivalsDefeated] };

// Occupiers
if (!isNil "aggressionLevelOccupants") then { _fields pushBack ["occupiers_aggression_level", aggressionLevelOccupants] };
if (!isNil "aggressionOccupants") then { _fields pushBack ["occupiers_aggression_value", aggressionOccupants] };
if (!isNil "areOccupantsDefeated") then { _fields pushBack ["occupiers_defeated", areOccupantsDefeated] };

// Invaders
if (!isNil "aggressionLevelInvaders") then { _fields pushBack ["invaders_aggression_level", aggressionLevelInvaders] };
if (!isNil "aggressionInvaders") then { _fields pushBack ["invaders_aggression_value", aggressionInvaders] };
if (!isNil "areInvadersDefeated") then { _fields pushBack ["invaders_defeated", areInvadersDefeated] };

// Faction Names
{
    private _key = _x select 0;
    private _faction = _x select 1;
    if (!isNil "_faction") then {
        private _name = _faction get "name";
        if (!isNil "_name") then {
            _tags pushBack [_key, _name];
        };
    };
} forEach [
    ["rebel_name", A3A_faction_reb],
    ["rivals_name", A3A_faction_riv],
    ["occupiers_name", A3A_faction_occ],
    ["invaders_name", A3A_faction_inv],
    ["civilian_name", A3A_faction_civ]
];

private _hashes = [_tags, _fields];

TRACE_1("Antistasi server update",_hashes);
["antistasiServerUpdate", _hashes] call CBA_fnc_serverEvent;
