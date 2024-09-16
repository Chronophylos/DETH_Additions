#include "..\script_component.hpp"

params [
	["_logic", objNull, [objNull]], // Argument 0 is module logic
	["_units", [], [[]]], // Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]// true when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

// Module specific behavior. Function can extract arguments from logic and use them.
if (_activated) then {
	// Attribute values are saved in module's object space under their class names

	diag_log text format ["Synchronized Objects: %1", _units];

	// find createLoadoutModule and players

	// apply loadout to players and set respawn handler
};
// Module function is executed by spawn command, so returned value is not necessary, but it is good practice.
true;