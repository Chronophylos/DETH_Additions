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

// Antistasi fires AIVehInit at the end of A3A_fnc_AIVEHinit for every vehicle it
// creates. The event is declared isLocal, so every machine registers and each one
// handles the vehicles it spawned itself. Guarded so the addon stays inert
// outside Antistasi Ultimate.
if (isNil "A3A_Events_fnc_addEventListener") exitWith {
    TRACE_1("Antistasi event system not available, skipping auto flag listener",QUOTE(ADDON));
};

["AIVehInit", QUOTE(ADDON), LINKFUNC(handleVehicleInit)] call A3A_Events_fnc_addEventListener;
