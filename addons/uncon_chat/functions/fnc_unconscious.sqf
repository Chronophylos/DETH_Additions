#include "script_component.hpp"

if (!isServer) exitWith {};

//IGNORE_PRIVATE_WARNING ["_unit, _state(BOOL)"];

if (!isPlayer _unit) exitWith {};

if (isNil QGVAR(radioChannel)) then {
    GVAR(radioChannel) = radioChannelCreate [
        [0.96, 0.34, 0.13, 0.8],
        "%UNIT_NAME",
        [],
        true
    ];
    if (GVAR(radioChannel == 0)) exitWith {
        ERROR("Failed to create radio channel");
    };
};


if (_state) then {
    _unit setVariable [QGVAR(oldChannel), getPlayerChannel _unit];
    GVAR(radioChannel) radioChannelAdd [_unit];
    [GVAR(radioChannel), _unit] call remoteExec ["setCurrentChannel", _unit];
} else {
    GVAR(radioChannel) radioChannelRemove [_unit];
    private _oldChannel = _unit getVariable [QGVAR(oldChannel), 0];
    [_oldChannel, _unit] call remoteExec ["setCurrentChannel", _unit];
    _unit setVariable [QGVAR(oldChannel), nil];
};

