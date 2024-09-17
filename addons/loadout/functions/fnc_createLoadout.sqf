#include "script_component.hpp"

params [
	["_logic", objNull, [objNull]], // Argument 0 is module logic
	["_units", [], [[]]], // Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]// true when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

// Module specific behavior. Function can extract arguments from logic and use them.
if (_activated) then {
	// Attribute values are saved in module's object space under their class names

	private _unitCount = count _units;
	if (_unitCount > 1) then {
		// TODO: Warn User
	};

	private _preset = _units select 0;
	TRACE_1("Found Preset Unit",_preset);

	private _loadout = getUnitLoadout [_preset, true];
	SETVAR(_logic,GVAR(loadout),_loadout);
	TRACE_1("Stored Preset Loadout",_loadout);

	deleteVehicle _preset;
	TRACE_1("Removed Preset Unit",_preset);
};
// Module function is executed by spawn command, so returned value is not necessary, but it is good practice.
true;
