#include "script_component.hpp"

params ["_target", "_player"];

TRACE_2("Applying flag",_target,GVAR(flagTexture));

_target forceFlagTexture GVAR(flagTexture);

GVAR(flaggedVehicles) pushBack _target;
