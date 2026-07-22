#include "script_component.hpp"

// Statistics collection runs on dedicated server and listen-server host only
if (!isServer) exitWith {};

GVAR(sessionId) = hashValue systemTime;

// Check for Antistasi compatibility
private _isAntistasiLoaded = isClass (configFile >> "CfgPatches" >> "A3A_ultimate");
if (_isAntistasiLoaded) then {
    INFO("Antistasi detected");
    [{!isNil "A3A_startupState" && A3A_startupState isEqualTo "completed"}, {
        LOG("Antistasi startup complete, adding per frame handler");
        [LINKFUNC(antistasiServer), 10, []] call CBA_fnc_addPerFrameHandler;
    }] call CBA_fnc_waitUntilAndExecute;
};

[LINKFUNC(score), 10, []] call CBA_fnc_addPerFrameHandler;
call FUNC(cps);

["ace_unconscious", LINKFUNC(unconscious)] call CBA_fnc_addEventHandler;

addMissionEventHandler ["PlayerConnected", LINKFUNC(connected)];
addMissionEventHandler ["PlayerDisconnected", LINKFUNC(disconnected)];
addMissionEventHandler ["HandleChatMessage", LINKFUNC(chat)];

[LINKFUNC(session), 10, []] call CBA_fnc_addPerFrameHandler;
