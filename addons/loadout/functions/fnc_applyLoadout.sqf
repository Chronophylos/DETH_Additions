#define DISABLE_COMPILE_CACHE

#include "..\script_component.hpp"

params [
	["_logic", objNull, [objNull]], // Argument 0 is module logic
	["_units", [], [[]]], // Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]// true when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

// Module specific behavior. Function can extract arguments from logic and use them.
if (_activated) then {
	// Attribute values are saved in module's object space under their class names

	// select the first synched Create Loadout Module
	private _module = synchronizedObjects _logic select {
		_x isKindOf QGVAR(createLoadout)
	} select 0;
	TRACE_1("Create Loadout Module", _module);

	// Retrieve loadout from Module
	private _loadout = GETVAR(_module, GVAR(loadout), []);
	{
		// set loadout
		_x setUnitLoadout [_loadout, true];
		TRACE_1("Applied Loadout", _x);

		// Store loadout on Unit and transmit over network
		SETPVAR(_x, GVAR(loadout), _loadout);

		// Add Respawn Event Handler for loading loadout
		_x addEventHandler ["Respawn", {
			params ["_unit", "_corpse"];

			// Attempt to get loadout from Unit and apply it
			private _loadout = GETVAR(_unit, GVAR(loadout), []);
			if !(_loadout isEqualTo []) then {
				_unit setUnitLoadout [_loadout, true];
				TRACE_1("Applied Respawn Loadout", _unit);
			};
		}];
	} forEach _units;
};
// Module function is executed by spawn command, so returned value is not necessary, but it is good practice.
true;