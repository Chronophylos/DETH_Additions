#include "script_component.hpp"

/*
 * Author: Chronophylos
 * Handles unconscious state changes for chat tracking
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Unconscious State <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, true] call DTA_uncon_chat_fnc_unconscious
 */

 // joined and left chat messages are not working on the server

params ["_unit", "_unconsciousState"];

if (!isServer) exitWith {};
if (!isPlayer _unit) exitWith {
    TRACE_1("Unit is not a player",_unit);
};


if (isNil QGVAR(radioChannel)) then {
    LOG("Radio channel is nil");
    GVAR(radioChannel) = radioChannelCreate [
        [0.96, 0.34, 0.13, 0.8],
        "Unconscious",
        "%UNIT_NAME",
        [],
        true
    ];
    if (GVAR(radioChannel) == 0) exitWith {
        ERROR("Failed to create radio channel");
    };
    TRACE_1("Radio channel created",GVAR(radioChannel));
};


if (_unconsciousState) then {
    TRACE_1("Unit is unconscious",_unit);

    GVAR(radioChannel) radioChannelAdd [_unit];

    TRACE_2("Setting current channel",_unit,GVAR(radioChannel));
    _unit setVariable [QGVAR(oldChannel), getPlayerChannel _unit];
    [GVAR(radioChannel) + 5] remoteExec ["setCurrentChannel", _unit];

    [GVAR(radioChannel), [true, false]] remoteExec ["enableChannel", _unit];

    _unit customChat [GVAR(radioChannel), "joined"];

    TRACE_2("Unit joined radio channel",_unit,GVAR(radioChannel));
} else {
    TRACE_1("Unit is conscious",_unit);

    private _oldChannel = _unit getVariable [QGVAR(oldChannel), 0];

    _unit customChat [GVAR(radioChannel), "left"];

    TRACE_2("Setting current channel",_oldChannel,_unit);
    [_oldChannel] remoteExec ["setCurrentChannel", _unit];
    _unit setVariable [QGVAR(oldChannel), nil];

    GVAR(radioChannel) radioChannelRemove [_unit];
    TRACE_2("Unit left radio channel",_unit,_oldChannel);
};

