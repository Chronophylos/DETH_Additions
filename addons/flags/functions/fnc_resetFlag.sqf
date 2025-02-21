#include "script_component.hpp"

params ["_target"];

_target forceFlagTexture "";

GVAR(flaggedVehicles) = GVAR(flaggedVehicles) - [_target];
