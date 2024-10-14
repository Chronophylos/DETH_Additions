#include "script_component.hpp"

params [
	["_logic", objNull, [objNull]], // Argument 0 is module logic
	["_units", [], [[]]], // Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]// true when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

// Module specific behavior. Function can extract arguments from logic and use them.
if (_activated) then {
    assert (count _units == 1);
    _object = _units select 0;

    TRACE_2("Initiating Oneway Teleporter",_logic,_object);

    _action = [
        QGVAR(onewayTeleporter),
        CSTRING(OnewayTeleporter_ActionName),
        "\a3\ui_f\data\igui\cfg\simpletasks\types\move_ca.paa",
        {
            params [
                ["_target", objNull, [objNull]],
                ["_player", ace_player, [ace_player]],
                ["_actionParams", [], [[]]]
            ];
            _actionParams params [
                ["_logic", objNull, [objNull]]
            ];

            _player setPos getPos _logic;
            _player setDir getDir _logic;
        },
        {true},
        {},
        [_logic]
    ] call ace_interact_menu_fnc_createAction;
    [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};
// Module function is executed by spawn command, so returned value is not necessary, but it is good practice.
true;
