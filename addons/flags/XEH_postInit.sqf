#include "script_component.hpp"

// Clients raise these instead of touching vehicles themselves. Both
// forceFlagTexture and setObjectTextureGlobal have a global effect, so a single
// server-side writer keeps every machine in sync and keeps working after the
// requesting player disconnects.
if (isServer) then {
    [QGVAR(applyFlag), LINKFUNC(applyFlag)] call CBA_fnc_addEventHandler;
    [QGVAR(resetFlag), LINKFUNC(resetFlag)] call CBA_fnc_addEventHandler;
    [QGVAR(applyTexture), LINKFUNC(applyTexture)] call CBA_fnc_addEventHandler;
    [QGVAR(resetTexture), LINKFUNC(resetTexture)] call CBA_fnc_addEventHandler;
    [QGVAR(refreshFlags), LINKFUNC(refreshFlags)] call CBA_fnc_addEventHandler;
};

// forceFlagTexture is not documented as JIP persistent, so have joining clients
// ask the server to broadcast the current flags again
if (hasInterface && {didJIP}) then {
    [QGVAR(refreshFlags), []] call CBA_fnc_serverEvent;
};
