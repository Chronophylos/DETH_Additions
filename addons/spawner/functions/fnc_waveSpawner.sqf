#include "script_component.hpp"

params [
	["_logic", objNull, [objNull]], // Argument 0 is module logic
	["_units", [], [[]]], // Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]// true when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

// Module specific behavior. Function can extract arguments from logic and use them.
if (_activated) then {
    // Load Attributes
    private _interval = _logic getVariable [QGVAR(interval), [10, 15, 20]];
    private _size = _logic getVariable [QGVAR(size), [3, 4, 6]];
    private _init = _logic getVariable [QGVAR(init), ""];
    private _initCode = compile _init;
    TRACE_3("WaveSpawner Init",_interval,_size,_init);

    _classes = _units apply { typeOf _x };
    { deleteVehicle _x } forEach _units;

    [player, player, civilian, _classes, _size select 2, random _interval, _initCode] spawn BIS_fnc_spawnEnemy;
};
// Module function is executed by spawn command, so returned value is not necessary, but it is good practice.
true;
