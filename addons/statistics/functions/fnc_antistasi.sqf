#include "script_component.hpp"

// check players
{
    private _money = _x getVariable "moneyX";
    private _rank = rank _x;
    private _isUndercover = (captive _x) and !(_x getVariable ["incapacitated", false]);
    private _afk = _x getVariable ["isAFK", false];
    // report

    _hashes = [
        ["tags", [
            ["playerName", name _x],
            ["playerUID", getPlayerUID _x]
        ]],
        ["fields", [
            ["money", _money],
            ["rank", _rank],
            ["isUndercover", _isUndercover],
            ["isAfk", _afk]
        ]]
    ];

    ["antistasiPlayerUpdate", _hashes] call CBA_fnc_serverEvent;
} forEach [] call CBA_fnc_players;

// check faction
private _hr = server getVariable "hr"
private _money = server getVariable "resourcesFIA"
private _commander = theBoss;
private _rallyPointDeployed = !isNil "isRallyPointPlaced" && { isRallyPointPlaced };
private _rebelName = A3A_faction_reb get "name",
private _warLevel = tierWar;

private _rivalsName = A3A_faction_riv get "name";
private _rivalsLevel = inactivityLevelRivals;
private _rivalsEnabled = areRivalsEnabled;
private _rivalsDiscovered = areRivalsDiscovered;
private _rivalsDefeated = areRivalsDefeated;

private _occupiersName = A3A_faction_occ get "name";
private _occupiersAggressionLevel = aggressionLevelOccupants;
private _occupiersAggressionValue = aggressionOccupants;
private _occupiersDefeated = areOccupantsDefeated;

private _invadersName = A3A_faction_inv get "name";
private _invadersAggressionLevel = aggressionLevelInvaders;
private _invadersAggressionValue = aggressionInvaders;
private _invadersDefeated = areInvadersDefeated;

private _civilianName = A3A_faction_civ get "name";
// report

_hashes = [
    ["tags", [
        ["rebelName", _rebelName],
        ["rivalsName", _rivalsName],
        ["occupiersName", _occupiersName],
        ["invadersName", _invadersName],
        ["civilianName", _civilianName]
    ]],
    ["fields", [
        ["hr", _hr],
        ["money", _money],
        ["commander", _commander],
        ["rallyPointDeployed", _rallyPointDeployed],
        ["warLevel", _warLevel],
        ["rivalsLevel", _rivalsLevel],
        ["rivalsEnabled", _rivalsEnabled],
        ["rivalsDiscovered", _rivalsDiscovered],
        ["rivalsDefeated", _rivalsDefeated],
        ["occupiersAggressionLevel", _occupiersAggressionLevel],
        ["occupiersAggressionValue", _occupiersAggressionValue],
        ["occupiersDefeated", _occupiersDefeated],
        ["invadersAggressionLevel", _invadersAggressionLevel],
        ["invadersAggressionValue", _invadersAggressionValue],
        ["invadersDefeated", _invadersDefeated]
    ]]
];

["antistasiServerUpdate", _hashes] call CBA_fnc_serverEvent;
