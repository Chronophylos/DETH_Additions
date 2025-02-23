#include "script_component.hpp"

params [["_target", objNull, [objNull]]];

TRACE_1("hasFlag",_target);

if (_target isEqualTo objNull) exitWith {
    WARNING("hasFlag called with invalid target");
    false
};

getForcedFlagTexture _target != ""
