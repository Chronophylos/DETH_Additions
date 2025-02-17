#define DEBUG_MODE_FULL
#include "script_component.hpp"

if (!isServer) exitWith {};

params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType", "_params"];

TRACE_1("Chat message",_this);

if (_text isEqualTo "") exitWith {};

private _player_name = "";
private _player_uid = "";

if (isPlayer _person) then {
    _player_name = name _person;
    _player_uid = getPlayerUID _person;
};

private _hashes = [
    [
        ["player_name", _player_name],
        ["player_uid", _player_uid],
        ["name", _name],
        ["from", _from],
        ["channel", _channel]
    ],
    [
        ["message", _text]
    ]
];

TRACE_1("Chat message",_hashes);
[QGVAR(chat), _hashes] call CBA_fnc_serverEvent;

// Return nothing to allow for default chat handling
