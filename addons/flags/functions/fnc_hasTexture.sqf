#include "script_component.hpp"

params ["_target"];

private _hasTexture = GETVAR(_target,GVAR(oldTexture),nil);

!isNil "_hasTexture"
